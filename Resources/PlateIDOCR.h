//
//  PlateIDOCR.h
//  PlateIDOCR
//
//  Created by chinasafe on 16/3/29.
//  Copyright © 2016年 chinasafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "PlateFormat.h"
#import "PlateResult.h"

@interface PlateIDOCR : NSObject

//初始化核心，devcode为开发码,type为识别的类型0为快速识别，1为精准识别
- (int) initPalteIDWithDevcode: (NSString *)devcode RecogType:(int) type;

//预览识别，buffer为传入的图片帧数据，count为识别的最大车牌个数，width为图片的宽度，height为图片的高度，rect为识别的预览框的位置，plateFormat为识别的设置，具体见PlateFormat类
- (NSArray *) recogImageWithBuffer:(UInt8 *)buffer recogCount: (int)count nWidth: (int)width nHeight: (int) height recogRange:(CGRect) rect PlateFormat: (PlateFormat *)plateFormat;

@end
