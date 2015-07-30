//
//  MicoBlogCell.m
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "MicoBlogCell.h"
#import "UIImage+Circel.h"
#include "MicoBlogModel.h"
#import "UIImage+animatedGIF.h"
#import "ZoomImageView.h"
@interface MicoBlogCell()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ZoomImageView *picView;

@end

@implementation MicoBlogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self prepareView];
    }
    
    return self;
}

- (void)prepareView
{
    UIImageView * photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:photoView];
    _photoView = photoView;
    
    UILabel * nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UIImageView * vipView = [[UIImageView alloc]init];
    [self.contentView addSubview:vipView];
    _vipView = vipView;
    
    UILabel * titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = lixFont;
    _titleLabel = titleLabel;
    
    ZoomImageView * picView = [[ZoomImageView alloc]init];
    [self.contentView addSubview:picView];
    _picView = picView;
}

+(id)micoBlogCellWithModel:(MicoCellFrame *)micoFrame andtableView:(UITableView *)tableView;
{
    MicoBlogCell * cell = [tableView dequeueReusableCellWithIdentifier:@"blog"];
    
    if (!cell) {
        cell = [[MicoBlogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blog"];
    }
    
    cell.micoFrame = micoFrame;
    NSLog(@"%p",cell);
    return cell;
}


- (void)setMicoFrame:(MicoCellFrame *)micoFrame
{
    _micoFrame = micoFrame;
    MicoBlogModel * model = micoFrame.model;
    
    //头像
    _photoView.frame = micoFrame.photoViewF;
    _photoView.image = [UIImage circleImageWithName:model.icon ];
    
    //名字
    _nameLabel.frame = micoFrame.nameLabelF;
    _nameLabel.text = model.name;
    
    //vip
    _vipView.frame = micoFrame.vipViewF;
    
//    if (model.vip.intValue == 1) {
//        _vipView.image 
//    }
   //title
    _titleLabel.frame = micoFrame.titleLabelF;
    _titleLabel.text = model.text;
    _titleLabel.font = lixFont;
    _titleLabel.numberOfLines = 0;
    
    //pic
    _picView.frame = micoFrame.picViewF;
    if (model.picture) {
        if ([model.picture hasSuffix:@"gif"]) {
            NSString * filePath = [[NSBundle mainBundle]pathForResource:model.picture ofType:nil];
            NSURL * fileUrl = [NSURL fileURLWithPath:filePath];//这个方法用来进行本地地下的转换
            
            NSData * data = [[NSData alloc]initWithContentsOfURL:fileUrl];
            
            UIImage * image = [UIImage animatedImageWithAnimatedGIFData:data];
            
            _picView.image = image;
 
        }else
        {
            _picView.image = [UIImage imageNamed:model.picture];
        }
    }

    
    
}

- (void)awakeFromNib {
    //根据内容布局
    
}



@end
