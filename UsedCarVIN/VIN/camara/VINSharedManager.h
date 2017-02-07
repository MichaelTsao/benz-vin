//
//  VINSharedManager.h
//  UsedCarVIN
//
//  Created by huiguan on 12/20/16.
//  Copyright © 2016 daimler. All rights reserved.
//


#import "SmartOCR.h"

typedef void (^VinResult)(NSDictionary *dict);

@interface VINSharedManager: NSObject

@property (strong, nonatomic) NSArray *imagePaths;//识别图像路径
@property (strong, nonatomic) NSArray *resultData;//识别结果
@property (strong, nonatomic) NSArray *fieldData;//识别字段名
@property (strong, nonatomic) SmartOCR *ocr;

+(VINSharedManager *)sharedInstance;

- (void) initOCRSource;

-(void)searchVINInfo:(NSString *)vinCode andResult:(VinResult)result;
@end
