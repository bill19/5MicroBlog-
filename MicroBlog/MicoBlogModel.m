//
//  MicoBlogModel.m
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "MicoBlogModel.h"

@implementation MicoBlogModel
+ (id)micoBlogWithDictionary:(NSDictionary *)dic
{
    MicoBlogModel * micoModel = [[MicoBlogModel alloc]init];
    [micoModel setValuesForKeysWithDictionary:dic];
    return micoModel;
    
}
@end
