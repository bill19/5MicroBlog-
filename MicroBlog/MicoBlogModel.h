//
//  MicoBlogModel.h
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#define  lixFont [UIFont systemFontOfSize:17]
#import <Foundation/Foundation.h>
@interface MicoBlogModel : NSObject
@property (nonatomic,copy)NSString * picture;
@property (nonatomic,copy)NSString * text;
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign)NSNumber * vip;

+ (id)micoBlogWithDictionary:(NSDictionary *)dic;


@end

