//
//  MicroBlogView.h
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MicroBlogView : UIView

+(id)micoBlog;
+(id)micoBlogWithModel:(NSArray *) models andTableView:(UIView *)view;

@end
