//
//  CameraViewController.m
//  BankCardRecog
//
//  Created by wintone on 15/1/22.
//  Copyright (c) 2015年 wintone. All rights reserved.
//

#import "CameraViewController.h"
#import "OverView.h"
#import "DataSourceReader.h"
#import "MainType.h"
#import "SubType.h"
#import "ListTableViewCell.h"
#import "ResultTableViewCell.h"
#import "SmartOCR.h"
#import "VINSharedManager.h"

//屏幕的宽、高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//cellName
#define kListCellName @"listcell"
#define kResultCellName @"resultcell"

@interface CameraViewController ()<UIAlertViewDelegate>{
    
    OverView *_overView;//预览界面覆盖层,显示是否找到边
    BOOL _on;//闪光灯是否打开
    
    NSTimer *_timer;//定时器，实现实时对焦
    CAShapeLayer *_maskWithHole;//预览界面覆盖的半透明层
    int _recogType;//识别总类型
    int _currentRecogType;//当前识别的子类型
    NSString *_currentOCRID;//当前识别的子类型代码
    NSString *_resultViewTitle;//结果展示页面title
    SmartOCR *_ocr;//核心
    BOOL _isTakePicBtnClick;//是否点击拍照按钮
    BOOL _isRecoging;//是否正在识别
    UIButton *_takePicBtn;//拍照按钮
}

@property (assign, nonatomic) BOOL adjustingFocus;//是否正在对焦
@property (strong, nonatomic) UILabel *middleLabel;
///扫描区域的横线是否是应该向上跑动
@property (nonatomic, assign) BOOL shouldUp;
///扫描区域图片
@property (nonatomic, strong) UIImageView *imageV;
///记录向右滑动最小边界
@property (nonatomic, assign) CGFloat maxX;
///记录向左滑动最大边界
@property (nonatomic, assign) CGFloat minX;
//确认按钮
@property (strong, nonatomic) UIButton *ensureBtn;
//当前类型的子类型
@property (strong, nonatomic) NSMutableArray *subTypes;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [[VINSharedManager sharedInstance] initOCRSource];
    _ocr = [VINSharedManager sharedInstance].ocr;
    
    //初始化相机
    [self initialize];
    //创建相机界面控件
    [self createCameraView];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.adjustingFocus = YES;
    _isRecoging = NO;

    //隐藏navigationBar
    self.navigationController.navigationBarHidden = YES;
    //定时器 开启连续对焦

    _isTakePicBtnClick = NO;
    
    if (self.listTableView) {
        [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[self.listTableView delegate] tableView:self.listTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    int flags = NSKeyValueObservingOptionNew;
    //注册通知
    [camDevice addObserver:self forKeyPath:@"adjustingFocus" options:flags context:nil];
    [self.session startRunning];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除聚焦监听
    AVCaptureDevice*camDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [camDevice removeObserver:self forKeyPath:@"adjustingFocus"];
    [self.session stopRunning];
    
    // show navigation bar when going to disappear
    self.navigationController.navigationBarHidden = NO;
}
- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // It can't work sometimes, so move this code to viewWillDisappear
//    self.navigationController.navigationBarHidden = NO;
    
    //关闭定时器
    [_timer invalidate];
}

//监听对焦
-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if([keyPath isEqualToString:@"adjustingFocus"]){
        self.adjustingFocus =[[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1]];
        //对焦中
    }
}

#pragma mark - 初始化识别核心
//初始化相机
- (void) initialize
{
    //判断摄像头授权
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView * alt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"allowCamare", nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alt show];
        return;
    }
    
    //1.创建会话层
    self.session = [[AVCaptureSession alloc] init];
    //设置图片品质，此分辨率为最佳识别分辨率，建议不要改动
    [self.session setSessionPreset:AVCaptureSessionPreset1920x1080];
    
    //2.创建、配置输入设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
            self.captureInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        }
    }
    [self.session addInput:self.captureInput];
    
    ///创建、配置预览输出设备
    AVCaptureVideoDataOutput *captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    captureOutput.alwaysDiscardsLateVideoFrames = YES;
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("cameraQueue", NULL);
    [captureOutput setSampleBufferDelegate:self queue:queue];
    
    NSString* key = (NSString*)kCVPixelBufferPixelFormatTypeKey;
    NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
    [captureOutput setVideoSettings:videoSettings];
    
    [self.session addOutput:captureOutput];
    
    //3.创建、配置输出
    self.captureOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.captureOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.captureOutput];
    
    //设置预览
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.preview];
    
    [self.session startRunning];
}

//重绘透明部分
- (void) drawShapeLayer
{
    //设置覆盖层
    _maskWithHole = [CAShapeLayer layer];
    
    // Both frames are defined in the same coordinate system
    CGRect biggerRect = self.view.bounds;
    CGFloat offset = 1.0f;
    if ([[UIScreen mainScreen] scale] >= 2) {
        offset = 0.5;
    }
    
    //设置检边视图层
    CGRect smallFrame = _overView.frame;
    CGRect smallerRect = CGRectInset(smallFrame, -offset, -offset) ;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMinY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMaxY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(biggerRect), CGRectGetMaxY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(biggerRect), CGRectGetMinY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMinY(biggerRect))];
    
    [maskPath moveToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMinY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMaxY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(smallerRect), CGRectGetMaxY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(smallerRect), CGRectGetMinY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMinY(smallerRect))];
    
    [_maskWithHole setPath:[maskPath CGPath]];
    [_maskWithHole setFillRule:kCAFillRuleEvenOdd];
    [_maskWithHole setFillColor:[[UIColor colorWithWhite:0 alpha:0.5] CGColor]];
    [self.view.layer addSublayer:_maskWithHole];
    [self.view.layer setMasksToBounds:YES];
    
}

//重绘不透明部分
- (void) redrawShapeLayer
{
    CGRect biggerRect = self.view.bounds;
    CGFloat offset = 1.0f;
    if ([[UIScreen mainScreen] scale] >= 2) {
        offset = 0.5;
    }
    
    CGRect smallFrame = _overView.frame;
    CGRect smallerRect = CGRectInset(smallFrame, -offset, -offset) ;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMinY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMaxY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(biggerRect), CGRectGetMaxY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(biggerRect), CGRectGetMinY(biggerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(biggerRect), CGRectGetMinY(biggerRect))];
    
    [maskPath moveToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMinY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMaxY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(smallerRect), CGRectGetMaxY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(smallerRect), CGRectGetMinY(smallerRect))];
    [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(smallerRect), CGRectGetMinY(smallerRect))];
    
    [_maskWithHole setPath:[maskPath CGPath]];
    [_maskWithHole setFillRule:kCAFillRuleEvenOdd];
    [_maskWithHole setFillColor:[[UIColor colorWithWhite:0 alpha:0.35] CGColor]];
}

//根据不同识别类型，创建不同的识别扫描框
- (void) creatOverViewWithType:(int)type
{
    
//    _currentRecogType = type;
    CGPoint overCenter = self.view.center;
    if (_overView.hidden) {
        _overView.hidden = NO;
        self.ensureBtn.hidden = YES;
        self.middleLabel.hidden = NO;
        _takePicBtn.hidden = NO;
        _takePicBtn.enabled = YES;
        [_maskWithHole setFillColor:[[UIColor colorWithWhite:0 alpha:0.35] CGColor]];

    }
    if (type == 0) {
        //长方形框
        _overView.frame = CGRectMake(0, 0, kScreenWidth/6, kScreenHeight/1.5);
        self.imageV.hidden = YES;
        self.middleLabel.center = CGPointMake(overCenter.x+kScreenWidth/6+10, overCenter.y-50);

    }else if(type == 1){
        //长方形框
        _overView.frame = CGRectMake(0, 0, kScreenWidth/6, kScreenHeight/1.3);
        self.imageV.hidden = YES;
        self.middleLabel.center = CGPointMake(overCenter.x+kScreenWidth/6+10, overCenter.y-50);

    }
    else if(type == 2){
        //二维码扫描框
        _overView.frame = CGRectMake(0, 0, 150, 150);
        self.middleLabel.center = CGPointMake(overCenter.x+150/2+40, overCenter.y-50);

    }else if(type == 3){
        //长方形框
        _overView.frame = CGRectMake(0, 0, kScreenWidth/6, kScreenHeight/2);
        self.imageV.hidden = YES;
        self.middleLabel.center = CGPointMake(overCenter.x+kScreenWidth/6+10, overCenter.y-50);
    }

    _overView.backgroundColor = [UIColor clearColor];
    _overView.center = CGPointMake(overCenter.x+20, overCenter.y-20);
    self.minX = CGRectGetMinX(_overView.frame);
    self.maxX = CGRectGetMaxX(_overView.frame);
    if (type == 2) {
        [self scanningAnimationWith:_overView.frame];
    }
    [self redrawShapeLayer];
    
}

///扫描时从右往左跑动的线
- (void)scanningAnimationWith:(CGRect) rect {
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat with = rect.size.width;
    CGFloat height = rect.size.height;
    self.imageV.frame = CGRectMake(x+with, y, 3, height);
    self.imageV.hidden = NO;
    self.shouldUp = NO;
}
//二维码扫描动画
- (void)repeatAction {
    CGFloat num = 1;
    if (self.shouldUp == NO) {
        self.imageV.frame = CGRectMake(CGRectGetMinX(self.imageV.frame)+num, CGRectGetMinY(self.imageV.frame), CGRectGetWidth(self.imageV.frame), CGRectGetHeight(self.imageV.frame));
        if (CGRectGetMaxX(self.imageV.frame) >= self.maxX) {
            self.shouldUp = YES;
        }
    }else {
        self.imageV.frame = CGRectMake(CGRectGetMinX(self.imageV.frame)- num, CGRectGetMinY(self.imageV.frame) , CGRectGetWidth(self.imageV.frame), CGRectGetHeight(self.imageV.frame));
        if (CGRectGetMinX(self.imageV.frame) <= self.minX) {
            self.shouldUp = NO;
        }
    }
}

//创建相机界面
- (void)createCameraView{
    //设置检边视图层
    _overView = [[OverView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/6, kScreenHeight/1.5)];
    _overView.backgroundColor = [UIColor clearColor];
    CGPoint overCenter = self.view.center;
    _overView.center = CGPointMake(overCenter.x+20, overCenter.y-50);
    self.minX = CGRectGetMinX(_overView.frame);
    self.maxX = CGRectGetMaxX(_overView.frame);
    
    [self.view addSubview:_overView];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"scanLine" ofType:@"png"];
    self.imageV.image = [UIImage imageWithContentsOfFile:imagePath];
    [self.view addSubview:self.imageV];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(repeatAction) userInfo:nil repeats:YES];
    
    //设置覆盖层
    [self drawShapeLayer];
    
    //显示当前识别类型
    self.middleLabel = [[UILabel alloc] init];
    self.middleLabel.frame = CGRectMake(0, 0, 300, 30);
    self.middleLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.middleLabel.center = CGPointMake(overCenter.x+kScreenWidth/6+10, overCenter.y-50);
    self.middleLabel.backgroundColor = [UIColor clearColor];
    self.middleLabel.textColor = [UIColor whiteColor];
    self.middleLabel.textAlignment = NSTextAlignmentCenter;
    self.middleLabel.font = [UIFont boldSystemFontOfSize:20.f];
    self.middleLabel.text = self.typeName;
    [self.view addSubview:self.middleLabel];
    
    //返回、闪光灯按钮
    CGRect backBtnFrame = CGRectMake(CGRectGetMaxX(self.view.bounds)-45, 30, 35, 35);
    UIButton *backBtn = [[UIButton alloc]initWithFrame:backBtnFrame];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back_camera_btn"] forState:UIControlStateNormal];
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:backBtn];
    
    CGRect flashBtnFrame = CGRectMake(CGRectGetMaxX(self.view.bounds)-45, CGRectGetMaxY(self.view.bounds)-45-50, 35, 35);
    UIButton *flashBtn = [[UIButton alloc]initWithFrame:flashBtnFrame];
//    [flashBtn setImage:[UIImage imageNamed:@"flash_camera_btn"] forState:UIControlStateNormal];
    [flashBtn setImage:[UIImage imageNamed:@"camera_flash_off.png"] forState:UIControlStateNormal];
    [flashBtn setImage:[UIImage imageNamed:@"camera_flash_on.png"] forState:UIControlStateSelected];
    [flashBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:flashBtn];
    
    self.listDataSource = [NSMutableArray arrayWithCapacity:0];
    self.listDataSource = [DataSourceReader getMainTypeDataSource];
    //创建识别类型列表
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, 80) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.transform = CGAffineTransformMakeRotation(M_PI/2);
    if (kScreenHeight == 480) {
        self.listTableView.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
        
    }else{
        self.listTableView.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
    }
    self.listTableView.backgroundColor = [UIColor blackColor];
    self.listTableView.alpha = 0.7;
    self.listTableView.hidden = true;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.listTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier: kListCellName];
    
    [self.view addSubview: self.listTableView];
    
    [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    MainType *mainType = self.listDataSource[0];
    _recogType = (int)[mainType.type integerValue];

    self.subTypes = [NSMutableArray array];
    self.subTypes = [DataSourceReader getSubTypeDataSource:mainType.type];
    _resultViewTitle = mainType.typeName;

    self.resultDataSource = [NSMutableArray array];
    self.fieldDataSource = [NSMutableArray array];
    for (SubType *subtype in self.subTypes) {

        [self.resultDataSource addObject:@""];
        [self.fieldDataSource addObject:subtype.name];
        [self.imagePaths addObject:@""];
    }
    //选择当前识别模板
    SubType *subtype = self.subTypes[0];
    _currentRecogType = 0;
    int currentTemplate = [_ocr setCurrentTemplate:subtype.OCRId];
    self.middleLabel.text = [NSString stringWithFormat:@"请扫描%@", subtype.name];
    _currentOCRID = subtype.OCRId;
    NSLog(@"设置当前模板返回值 = %d", currentTemplate);

    //创建识别结果列表
    self.resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    self.resultTableView.transform = CGAffineTransformMakeRotation(M_PI/2);
    CGFloat btnX;
    if (kScreenHeight == 480) {
        self.resultTableView.frame = CGRectMake(0, 0, 100, kScreenHeight-100);
        btnX = kScreenHeight-170;
    }else{
        self.resultTableView.frame = CGRectMake(0, 0, 100, kScreenHeight-100);
        btnX = kScreenHeight-210;
    }

    self.resultTableView.backgroundColor = [UIColor darkGrayColor];
    self.resultTableView.alpha = 0.7;
    self.resultTableView.hidden = true;
    self.resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.resultTableView registerClass:[ResultTableViewCell class] forCellReuseIdentifier:kResultCellName];
    
    [self.view addSubview: self.resultTableView];
    
    [self.resultTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    //确定按钮
    self.ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ensureBtn.frame = CGRectMake(20, btnX, 100, 40);
    self.ensureBtn.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.ensureBtn.backgroundColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1];
    [self.ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.ensureBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.ensureBtn addTarget:self action:@selector(pushToResultView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ensureBtn];
    //识别完成前隐藏确定按钮
    self.ensureBtn.hidden = YES;
    [self setROI];
    
    self.imagePaths = [NSMutableArray array];
    
    //添加拍照按钮 2017年02月05日16:02:13 去掉拍照按钮
//    _takePicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _takePicBtn.frame = CGRectMake(kScreenWidth/2 - 5, kScreenHeight/1.5+60, 50, 50);
//    [_takePicBtn setImage:[UIImage imageNamed:@"take_pic_btn"] forState:UIControlStateNormal];
//    _takePicBtn.transform = CGAffineTransformMakeRotation(M_PI/2);
//    [_takePicBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_takePicBtn];
}


- (void) setROI
{
    //设置识别区域
    CGRect rect = _overView.frame;
    CGFloat scale = 1080.0/kScreenWidth; //1080为当前分辨率(1920*1080)中的宽
    int sTop = (kScreenWidth - CGRectGetMaxX(rect))*scale;
    int sBottom = (kScreenWidth - CGRectGetMinX(rect))*scale;
    int sLeft = CGRectGetMinY(rect)*scale;
    int sRight = (CGRectGetMinY(rect) + CGRectGetHeight(rect))*scale;
    CGFloat dValue = (kScreenWidth/1080*1920-kScreenHeight)*scale*0.5;
    
    [_ocr setROIWithLeft:sLeft+dValue Top:sTop Right:sRight+dValue Bottom:sBottom];
}

- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationUp];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    //裁剪图片
    CGRect tempRect = _overView.frame;
    CGFloat scale = 1080/kScreenWidth; //1080为当前分辨率(1920*1080)中的宽
    CGFloat dValue = (kScreenWidth/1080*1920-kScreenHeight)*scale*0.5;
    
    CGFloat y = (kScreenWidth - CGRectGetMaxX(tempRect))*scale;
    CGFloat x = CGRectGetMinY (tempRect)*scale+dValue;
    CGFloat w = tempRect.size.height*scale;
    CGFloat h = tempRect.size.width*scale;
    CGRect rect = CGRectMake(x, y, w, h);
    
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context1, rect, subImageRef);
    UIImage *image1 = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return (image1);
}

//点击拍照按钮
- (void) takePhoto
{
    _isTakePicBtnClick = YES;
}

//从摄像头缓冲区获取图像
#pragma mark - AVCaptureSession delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    //获取当前帧数据
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    
    int width = (int)CVPixelBufferGetWidth(imageBuffer);
    int height = (int)CVPixelBufferGetHeight(imageBuffer);
    
    if (!_isRecoging) {
        //加载图像

        [_ocr loadStreamBGRA:baseAddress Width:width Height:height];

        //识别
        int recog = [_ocr recognize];

        if (recog == 0 || _isTakePicBtnClick) {
            NSLog(@"_currentRecogType3 = %d", _currentRecogType);
            _isRecoging = YES;
            //识别成功，取结果
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            NSString *result = [_ocr getResults];
            
            NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *imagePath = [documents[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", _currentOCRID]];
            [_ocr saveImage:imagePath];
            
            self.resultDataSource[_currentRecogType] = result;
            NSLog(@"%d,%@",  _currentRecogType, self.resultDataSource[_currentRecogType]);
            
            self.imagePaths[_currentRecogType] = imagePath;
            if (_isTakePicBtnClick) {
                self.resultDataSource[_currentRecogType] = @" ";
                _isTakePicBtnClick = NO;
            }
            NSLog(@"_currentRecogType4 = %d", _currentRecogType);

            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *string = self.resultDataSource[self.resultDataSource.count-1];
                
                if (string.length == 0) {
                    
                    if (_currentRecogType < self.fieldDataSource.count-1) {

                        [self.resultTableView reloadData];
                        _isRecoging = NO;
                        //识别完成继续选中下一行
                        [self.resultTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentRecogType+1 inSection:0] animated:YES scrollPosition: UITableViewScrollPositionMiddle];
                        
                        [[self.resultTableView delegate] tableView:self.resultTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:_currentRecogType+1 inSection:0]];
                    }
                }else{
                    [_session stopRunning];
                    
                    if (_recogType == 1 || _recogType == 2) {
                        //VIN码或者手机号
                        [self pushToResultView];
                        
                    }else{
                        //去主线程刷新UI
                        [self.resultTableView reloadData];
                        _overView.hidden = YES;
                        self.ensureBtn.hidden = NO;
                        self.imageV.hidden = YES;
                        _takePicBtn.enabled = NO;
                        _takePicBtn.hidden = YES;
                        self.middleLabel.hidden = YES;
                        [_maskWithHole setFillColor:[[UIColor colorWithWhite:0 alpha:0] CGColor]];
                    }
                }
            });
        }
        
    }

    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}

//获取摄像头位置
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

//对焦
- (void)fouceMode{
    NSError *error;
    AVCaptureDevice *device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
    {
        if ([device lockForConfiguration:&error]) {
            CGPoint cameraPoint = [self.preview captureDevicePointOfInterestForPoint:self.view.center];
            [device setFocusPointOfInterest:cameraPoint];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            [device unlockForConfiguration];
        } else {
            NSLog(@"Error: %@", error);
        }
    }
}

#pragma mark - ButtonAction
//返回按钮按钮点击事件
- (void)backAction{
    [_session stopRunning];
    _session = nil;
    int uninit = [_ocr uinitOCREngine];
    NSLog(@"uninit=======%d", uninit);

    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

//闪光灯按钮点击事件
- (void)openFlash:(UIButton *) btn{
    btn.selected = !btn.selected;
    AVCaptureDevice *device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    if (![device hasTorch]) {
        //        NSLog(@"no torch");
    }else{
        [device lockForConfiguration:nil];
        if (!_on) {
            [device setTorchMode: AVCaptureTorchModeOn];
            _on = YES;
        }
        else
        {
            [device setTorchMode: AVCaptureTorchModeOff];
            _on = NO;
        }
        [device unlockForConfiguration];
    }
}

#pragma mark -- TableViewDelegate && TableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.listTableView) {
        return self.listDataSource.count;
    }else if (tableView == self.resultTableView){
        return self.resultDataSource.count;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.listTableView) {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kListCellName forIndexPath:indexPath];
        if (!cell) {
            cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kListCellName];
        }
        MainType *mainType = self.listDataSource[indexPath.row];
        cell.textLabel.text = mainType.typeName;
        
        return cell;
    }else if(tableView == self.resultTableView){
        ResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultCellName forIndexPath:indexPath];
        if (!cell) {
            cell = [[ResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kResultCellName];
        }

        cell.textLabel.textColor = [UIColor whiteColor];

        NSString *fieldText = self.fieldDataSource[indexPath.row];
        NSString *resultText = self.resultDataSource[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@", fieldText, resultText];
        return cell;
    }
    
    
    return nil;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(tableView == self.resultTableView){
        
        if (indexPath.row > 0) {
            NSString *cellText = self.resultDataSource[indexPath.row-1];
            if ([cellText isEqualToString:@""]) {
                return nil;
            }
        }
    }
    
    return indexPath;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_session isRunning]) {
        [_session startRunning];
    }
    if (tableView == self.listTableView) {
        //移除原有内容
        [self.resultDataSource removeAllObjects];
        [self.fieldDataSource removeAllObjects];
        [self.imagePaths removeAllObjects];

        [self.subTypes removeAllObjects];
        MainType *mainType = self.listDataSource[indexPath.row];
        _resultViewTitle = mainType.typeName;
        _recogType = [mainType.type intValue];
        self.subTypes = [DataSourceReader getSubTypeDataSource:mainType.type];
        for (SubType *subtype in self.subTypes) {

            [self.resultDataSource addObject:@""];
            [self.imagePaths addObject:@""];
            [self.fieldDataSource addObject: subtype.name];
        }
        
        [self.resultTableView reloadData];
        
        [self.resultTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [[self.resultTableView delegate] tableView:self.resultTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
    }else if(tableView == self.resultTableView){
        _currentRecogType = (int)indexPath.row;
        SubType *subtype = self.subTypes[indexPath.row];
        [self creatOverViewWithType:[subtype.type intValue]];
        if (![self.session isRunning]) {
            [self.session startRunning];
        }
        _isRecoging = NO;
        //选择当前识别模板
        int currentTemplate = [_ocr setCurrentTemplate:subtype.OCRId];
        NSLog(@"设置模板返回值：%d", currentTemplate);
        _currentOCRID = subtype.OCRId;
        self.middleLabel.text = [NSString stringWithFormat:@"请扫描%@", subtype.name];
        
        [self setROI];
        NSLog(@"SetROI 完成");
    }
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.listTableView) {
        //选中识别类型
        UITableViewCell *cell = [self.listTableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor whiteColor];
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.resultTableView) {
        return 100.0/3;
    }
    return 44.f;
}

-(void) pushToResultView
{
    VINSharedManager *sharedManager = [VINSharedManager sharedInstance];
    sharedManager.resultData = self.resultDataSource;
    sharedManager.fieldData = self.fieldDataSource;
    sharedManager.imagePaths = self.imagePaths;

    if (self.delegate) {

        NSString *vinCode = [NSString stringWithFormat:@"%@",sharedManager.resultData[0]];
        [self.delegate cameraResult:vinCode formViewController:self];
    }

    if (self.navigationController == nil){
        [self dismissViewControllerAnimated:NO completion:NULL];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

//隐藏状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end