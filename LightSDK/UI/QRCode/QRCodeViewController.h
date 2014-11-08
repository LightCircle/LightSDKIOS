//
//  QRCodeViewController.h
//  LiveManager
//
//  Created by LI LIN on 14/11/8.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^QRCodeViewControllerComplet)(id);

@interface QRCodeViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *preview;
- (IBAction)onCancelTouched:(id)sender;
@property (strong, nonatomic) QRCodeViewControllerComplet onComplet;

+ (QRCodeViewController *)loadController;

@end
