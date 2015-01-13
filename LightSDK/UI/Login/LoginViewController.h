//
//  LoginViewController.h
//  ShotEyes
//
//  Created by LI LIN on 14/10/29.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^LoginViewControllerComplet)();

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UITextField *txtUserID;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)onLoginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (strong, nonatomic) LoginViewControllerComplet onComplet;
@property (strong, nonatomic) UIImage *logo;
@property (strong, nonatomic) UIColor *color;
+ (LoginViewController *)loadController;
+ (void)logout;

@end
