//
//  DataSourceReader.h
//  SmartvisionOCR
//
//  Created by wintone on 16/4/28.
//  Copyright © 2016年 chinasafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceReader : NSObject
//获取所有主类型
+(NSMutableArray *) getAllMainTypeDataSource;
//获取选中的主类型
+(NSMutableArray *) getMainTypeDataSource;
//获取子类型
+(NSMutableArray *) getSubTypeDataSource: (NSString *) mainType;
@end
