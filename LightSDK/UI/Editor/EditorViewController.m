//
//  EditorViewController.m
//  LiveManager
//
//  Created by LI LIN on 14/10/28.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 文本编辑
    if (self.type == LEEditorText || self.type == LEEditorNumber) {
        self.txtEdit.hidden = NO;

        // 设定光标
        [self.txtEdit becomeFirstResponder];
        
        // 文本框左侧空白
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        paddingView.opaque = NO;
        paddingView.backgroundColor = [UIColor clearColor];
        self.txtEdit.leftView = paddingView;
        self.txtEdit.leftViewMode = UITextFieldViewModeAlways;
        
        if (self.type == LEEditorNumber) {
            self.txtEdit.keyboardType = UIKeyboardTypeNumberPad;
        }

        // 缺省值
        self.txtEdit.text = self.defaults;
    }
    
    // 日期选择
    if (self.type == LEEditorDate) {
        self.selDateTime.hidden = NO;
        [self.selDateTime setDate:self.defaults];
    }
    
    // 选择
    if (self.type == LEEditorOption) {
        self.tableView.hidden = NO;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 取消
- (IBAction)onCancelTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onEditEnd:(id)sender
{
    self.onComplet(self.txtEdit.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditorViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];

    if ([cell.textLabel.text isEqualToString:self.defaults]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    self.onComplet(cell.textLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
