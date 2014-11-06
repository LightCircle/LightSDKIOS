//
//  LoginViewController.h
//  ShotEyes
//
//  Created by LI LIN on 14/10/29.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginViewControllerComplet)();

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UITextField *txtUserID;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)onLoginClicked:(id)sender;

@property (strong, nonatomic) LoginViewControllerComplet onComplet;
@property (strong, nonatomic) UIImage *logo;
+ (LoginViewController *)loadFromNib;
+ (void)logout;

@end
