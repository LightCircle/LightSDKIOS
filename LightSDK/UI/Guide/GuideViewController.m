//
//  GuideViewController.m
//  LiveManager
//
//  Created by LI LIN on 14/11/4.
//  Copyright (c) 2014年 Alphabets. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()
@end

@implementation GuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

+ (GuideViewController *)loadController:(NSArray *)images titles:(NSArray *)titles subtitles:(NSArray *)subtitles
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Guide" bundle:nil];
    
    GuideViewController *viewController = [sb instantiateViewControllerWithIdentifier:@"GuideViewController"];
    viewController.images = images;
    viewController.titles = titles;
    viewController.subtitles = subtitles;

    return viewController;
}

@end

@interface GuideDetailViewController ()
@end

@implementation GuideDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *images = ((GuideViewController*)self.navigationController).images;
    NSArray *titles = ((GuideViewController*)self.navigationController).titles;
    NSArray *subtitles = ((GuideViewController*)self.navigationController).subtitles;

    // 图像
    self.imgMain.image = [UIImage imageNamed:[images objectAtIndex:self.page]];
    self.lblTitle.text = [titles objectAtIndex:self.page];
    self.lblSubTitle.text = [subtitles objectAtIndex:self.page];
    
    // 页数
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = self.page;

    // 左
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];

    // 右
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSArray *images = ((GuideViewController*)self.navigationController).images;
    if (self.page + 1 >= images.count) {
        return;
    }
    
    GuideDetailViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"GuideDetailViewController"];
    viewController.page = self.page + 1;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)swipeRight:(UISwipeGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onFinished:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPageTouched:(id)sender
{
    self.pageControl.currentPage = self.page;
    [self swipeLeft:sender];
}

@end
