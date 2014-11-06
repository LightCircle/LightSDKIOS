//
//  EditorViewController.h
//  LiveManager
//
//  Created by LI LIN on 14/10/28.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EditorViewControllerComplet)(id);

typedef NS_ENUM(NSInteger, LMEditorType) {
    LEEditorText = 0,
    LEEditorNumber = 1,
    LEEditorDate = 2,
    LEEditorOption = 3
};

@interface EditorViewController : UIViewController
- (IBAction)onCancelTouched:(id)sender;
- (IBAction)onEditEnd:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtEdit;
@property (weak, nonatomic) IBOutlet UIDatePicker *selDateTime;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 多选时，选择项目
@property (nonatomic) NSArray *items;

// 缺省值
@property (nonatomic) id defaults;

// 类型
@property (nonatomic) LMEditorType type;

// 确定后的回调函数
@property (strong, nonatomic) EditorViewControllerComplet onComplet;

@end
