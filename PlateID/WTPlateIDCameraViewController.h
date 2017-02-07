//
//  CameraViewController.h
//  BankCardRecog
//
//  Created by chinasafe on 15/1/22.
//  Copyright (c) 2015年 chinasafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMedia/CoreMedia.h>
#import "PlateResult.h"

@protocol PlateIDCameraResultDelegate;
@interface WTPlateIDCameraViewController : UIViewController
@property (nonatomic,weak) id<PlateIDCameraResultDelegate> delegate;
@end

@protocol PlateIDCameraResultDelegate <NSObject>
-(void)cameraResult:(PlateResult *)plateResult formViewController:(WTPlateIDCameraViewController *)viewController;
@end
