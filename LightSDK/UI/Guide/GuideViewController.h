//
//  GuideViewController.h
//  LiveManager
//
//  Created by LI LIN on 14/11/4.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UINavigationController

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *subtitles;

+ (GuideViewController *)loadController:(NSArray *)images titles:(NSArray *)titles subtitles:(NSArray *)subtitles;

@end

@interface GuideDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;
- (IBAction)onFinished:(id)sender;
- (IBAction)onPageTouched:(id)sender;

@property (nonatomic) NSInteger page;

@end

