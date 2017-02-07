//
//  VINSharedManager.m
//  UsedCarVIN
//
//  Created by huiguan on 12/20/16.
//  Copyright © 2016 daimler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VINSharedManager.h"
#import "UsedCarVIN-Swift.h"

@implementation VINSharedManager

+ (instancetype)sharedInstance
{
    static VINSharedManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VINSharedManager alloc] init];
        sharedInstance.ocr = [[SmartOCR alloc] init];
    });
    return sharedInstance;
}


- (void) initOCRSource
{
    //初始化核心
    int init = [self.ocr initOcrEngineWithDevcode:@"0005OI05AEG5YUS"];
    NSLog(@"初始化返回值 = %d 核心版本号 = %@", init, [self.ocr  getVersionNumber]);
    
    //添加模板
    NSString *templateFilePath = [[NSBundle mainBundle] pathForResource:@"SZHY" ofType:@"xml"];
    int addTemplate = [self.ocr addTemplateFile:templateFilePath];
    NSLog(@"添加主模板返回值 = %d", addTemplate);
}

-(void)searchVINInfo:(NSString *)vinCode andResult:(VinResult)result{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        [_ocr initVINEngine];
        NSArray *results =  [_ocr searchVINInfoWithVINCode:vinCode];

        NSMutableDictionary *convert = [NSMutableDictionary dictionary];

        //从[[String:String]] 转换成为 [String:String]

        for (NSDictionary *dict in results) {
            NSLog(@"%@",dict);

            [convert addEntriesFromDictionary:dict];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (result) {
                result(convert);
            }
        });
    });
}
@end


