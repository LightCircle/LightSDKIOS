//
//  BaseViewModel.h
//  ShotEyesiPAD
//
//  Created by kita on 14-5-14.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa.h>
@interface BaseViewModel : NSObject
@property (retain, nonatomic) id model;
@property (retain, nonatomic) NSString *createAPIPath;
@property (retain, nonatomic) NSString *updateAPIPath;
@property (retain, nonatomic) NSString *fetchAPIPath;
@property (retain, nonatomic) NSDictionary *updateFilter;
@property (retain, nonatomic) NSDictionary *fetchFilter;

-(id)initWithModel:(id)model;
-(RACSignal *)createSignal;
-(RACSignal *)updateSignal;
-(RACSignal *)fetchSignal;
-(RACSignal *)saveSignal;
@end
