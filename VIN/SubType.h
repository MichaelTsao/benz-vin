//
//  SubType.h
//  SmartvisionOCR
//
//  Created by wintone on 16/4/28.
//  Copyright © 2016年 chinasafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubType : NSObject
//当前识别类型代号
@property (strong, nonatomic) NSString *type;
//当前识别类型名称
@property (strong, nonatomic) NSString *name;
//当前识别模板名称
@property (strong, nonatomic) NSString *OCRId;

@end
