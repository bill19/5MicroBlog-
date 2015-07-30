//
//  ZoomImageView.m
//  MicroBlog
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 lix. All rights reserved.
//
/**
 *循序渐进(不是一下 就可以写出结构合理的 最终想要的代码)
 *各司其职(方法要找对自己的归属)
 *去除重复(相同内容的类可以提升父类)
 *反复推敲(重复上面两个步骤)
 */
#import "ZoomImageView.h"
@interface ZoomImageView()

@property (nonatomic,weak)UIView *popView;
@property (nonatomic,weak)UIImageView * popImageView;
@property (nonatomic,assign)CGRect transRect;
@end

@implementation ZoomImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomPic:)];
    [self addGestureRecognizer:tap];
}

- (void)zoomPic:(UITapGestureRecognizer *)sender
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //弹出的存放大图片的view 将其添加到window上设置为
    UIView * popView = [[UIView alloc]init];
    [window addSubview:popView];
    _popView = popView;
    popView.frame = CGRectMake(0, 0,screenW ,screenH );
    popView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    //得到原图的imageView在window上的位置
    CGRect tranRect = [self convertRect:self.bounds toView:popView];
    _transRect = tranRect;
    //在popView上添加一个 imageView 使其的位置与原图的位置重合
    UIImageView *popImageView = [[UIImageView alloc]initWithFrame:tranRect];
    popImageView.image = self.image;
    popImageView.backgroundColor = [UIColor blackColor];
    [_popView addSubview:popImageView];
    _popImageView = popImageView;
    //开始用动画放大
    //先算出放大后图片的比例,放大的图片宽默认为屏幕宽度
    CGFloat popImageViewW = screenW;
    //等比放大高度
    CGFloat popImageViewH = screenW /self.frame.size.width * self.frame.size.height;
    CGFloat popImageViewX = 0;
    //屏幕高度 减去 imageView的高度 然后 除以2
    CGFloat popImageViewY = (screenH-popImageViewH)/2;
    [UIView animateWithDuration:0.5 animations:^{
        popImageView.frame = CGRectMake(popImageViewX, popImageViewY, popImageViewW, popImageViewH);

    }];
    
    //给popImageView 添加手势隐藏图片
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopView:)];
    [_popView addGestureRecognizer:tap];
}

- (void)hidePopView:(UITapGestureRecognizer *)sender
{

    [UIView animateWithDuration:0.5 animations:^{
        _popImageView.frame = _transRect;
    } completion:^(BOOL finished) {
        [_popView removeFromSuperview];
      
    }];
}
@end












