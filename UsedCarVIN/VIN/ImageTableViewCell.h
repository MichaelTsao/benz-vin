//
//  ImageTableViewCell.h
//  SmartVisionOCRDemo
//
//  Created by wintone on 16/7/28.
//  Copyright © 2016年 chinasafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *recogImageView;
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
