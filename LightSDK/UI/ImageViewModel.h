//
//  ImageViewModel.h
//  ShotEyesiPAD
//
//  Created by kita on 14-5-16.
//  Copyright (c) 2014年 kita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Jastor.h>

@interface DAFile : Jastor
@property NSString *_id;
@end


@interface ImageViewModel : NSObject
@property(retain,nonatomic) DAFile *model;
@property(retain, nonatomic) UIImage *image;
@property(retain, nonatomic) NSString* uploadPath;
@property(retain, nonatomic) NSString* fetchPath;

-(id)initWithFetchPath:(NSString *)fetchPath fileId:(NSString *)_id;
-(id)initAndFetchImageWithFetchPath:(NSString *)fetchPath fileId:(NSString *)_id;

-(void)upLoadImageCompleted:(void (^)(void))completed;
-(void)setImageInImageView:(UIImageView *)imageView placeholderImage:(UIImage *)image;
@end
