//
//  LoginViewController.m
//  ShotEyes
//
//  Created by LI LIN on 14/10/29.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <AFNetworking.h>
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "ABConfigManager.h"
#import "ABDefine.h"
#import "ABHelper.h"
#import "ABEntities.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnLogin.backgroundColor = self.color;
    self.imgLogo.image = self.logo;
    [self.txtUserID becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Functions

+ (LoginViewController *)loadController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
}

+ (void)logout
{
    [ABConfigManager.defaults removeObjectForKey:kConfigManagerUserID];
    [ABConfigManager.defaults removeObjectForKey:kConfigManagerCookie];
    [ABConfigManager.defaults removeObjectForKey:kConfigManagerCsrfToken];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotificationNameNeedsLogin object:nil]];
}

- (IBAction)onLoginClicked:(id)sender
{
    // 记住用户ID
    [ABConfigManager.defaults setObject:self.txtUserID.text forKey:kConfigManagerDefaultUserID];
    
    if ([self isValid] == NO) {
        return;
    }
    
    [self login];
}

- (void)login
{
    // 登陆参数
    NSString *params = [NSString stringWithFormat:@"name=%@&password=%@", self.txtUserID.text, self.txtPassword.text];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:[ABHelper url:@"/user/login" params:params]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             NSDictionary *data = responseObject[@"data"];
             
             // 保存登陆用户用户
             NSError* error = nil;
             User *user = [[User alloc] initWithDictionary:data error:&error];
             [ABConfigManager.defaults setObject:user.id forKey:kConfigManagerUserID];
             
             // 保存和cookie，csrftoken
             NSDictionary *headerFields = [((NSHTTPURLResponse *)task.response) allHeaderFields];
             [ABConfigManager.defaults setObject:[headerFields objectForKey:kHTTPHeaderCookieName] forKey:kConfigManagerCookie];
             [ABConfigManager.defaults setObject:[headerFields objectForKey:kHTTPHeaderCsrftokenName] forKey:kConfigManagerCsrfToken];
             // 设有回调函数，则调用
             if (self.onComplet) {
                 self.onComplet();
             }
             
             // 关闭登陆画面
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [self.view removeFromSuperview];
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             
             // 错误
             NSLog(@"Error: %@", error);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [ABHelper showError:error.description];
         }];
}

- (BOOL)isValid
{
    // 检证userId是否为空，去掉前后的半角和全角空格
    NSString * userId = [self.txtUserID.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" 　" ]];
    if (userId.length == 0) {
        [ABHelper showError:@"请输入用户名"];
        [self.txtUserID becomeFirstResponder];
        return NO;
    }
    
    // 检证password是否为空，去掉前后的半角和全角空格
    NSString * password = [self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" 　" ]];
    if ( password.length  == 0) {
        [ABHelper showError:@"请输入密码"];
        [self.txtPassword becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
