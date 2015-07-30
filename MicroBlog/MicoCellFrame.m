//
//  MicoCellFrame.m
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "MicoCellFrame.h"

@implementation MicoCellFrame


+ (id)micoCellFrameWithModel:(MicoBlogModel *)model
{
    MicoCellFrame * micoFrame = [[MicoCellFrame alloc]init];
    micoFrame.model = model;
    return micoFrame;
}
- (void)setModel:(MicoBlogModel *)model
{
    _model = model;
    float padding = 10;
    float screenW = [UIScreen mainScreen].bounds.size.width;
    //头像
    float photoX = padding;
    float photoY = padding;
    float photoW = 50;
    float photoH = 50;
    _photoViewF = CGRectMake(photoX, photoY, photoW, photoH);
    
    //名字
    float nameLabelX = CGRectGetMaxX(_photoViewF)+padding;
    float nameLabelY = padding * 2;
    float nameLabelW = 100;
    float nameLabelH = 40;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    //VIP
    float vipViewX = CGRectGetMaxX(_nameLabelF)+padding;
    float vipViewY = padding * 2;
    float vipViewW = 30;
    float vipViewH = 30;
    _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    //title
    float titleX = padding;
    float titleY = CGRectGetMaxY(_photoViewF);
    float titleW = screenW -2*padding;
    CGSize fontMax = CGSizeMake(titleW, MAXFLOAT);
    float titleH = [model.text boundingRectWithSize:fontMax options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lixFont} context:nil].size.height;
    
    _titleLabelF = CGRectMake(titleX, titleY, titleW, titleH);
    
    if (model.picture) {
        //pic
        float picViewX = padding;
        float picViewY = CGRectGetMaxY(_titleLabelF);
        float picViewW = screenW/3;
        float picViewH = screenW/3;
        
        _picViewF = CGRectMake(picViewX, picViewY, picViewW, picViewH);
    }

    
    _cellHeight = MAX(CGRectGetMaxY(_picViewF), CGRectGetMaxY(_titleLabelF))+padding;
    
}
@end





