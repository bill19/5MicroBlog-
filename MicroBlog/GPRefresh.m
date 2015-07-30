//
//  GPRefresh.m
//  美食quanquan
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "GPRefresh.h"
@interface GPRefresh()


@property(nonatomic,weak)UIButton * alertButton;
@property(nonatomic,weak)UIView * loadView;
@property(nonatomic,retain)NSArray * btnTitle;
@property(nonatomic,assign)GPRefreshPositionType type;
@end

@implementation GPRefresh

+(id)refreshWithPositionType:(GPRefreshPositionType)type
{
    GPRefresh * refresh = [[GPRefresh alloc]init];
    refresh.type = type;
    return refresh;
}

-(UIButton *)alertButton
{
    if (!_alertButton) {
        UIButton * btn = [[UIButton alloc]init];
        [self addSubview:btn];
        btn.frame = self.bounds;
        if (self.type == GPRefreshPositionTypeFooter) {
            [btn setTitle:@"上拉加载" forState:UIControlStateNormal];
        }
        else if(self.type == GPRefreshPositionTypeHeader)
        {
            [btn setTitle:@"下拉加载" forState:UIControlStateNormal];
        }
        
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
        btn.userInteractionEnabled = NO;
        if (self.type ==GPRefreshPositionTypeFooter) {
            
            btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _alertButton = btn;
    }
    return _alertButton;
}

- (UIView *)loadView
{
    if (!_loadView) {
        UIView * loadView = [[UIView alloc]init];
        [self addSubview:loadView];
        loadView.frame = self.bounds;
        _loadView = loadView;
             UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc]init];
        [loadView addSubview:activity];
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activity startAnimating];
        CGFloat activityX = 100;
        CGFloat activityY = 10;
        CGFloat activityW = 30;
        CGFloat activityH = 30;
        activity.frame = CGRectMake(activityX, activityY, activityW, activityH);
        
        UILabel * textLable = [[UILabel alloc]init];
        [loadView addSubview:textLable];
        CGFloat  textLableX = activityX+50;
        CGFloat  textLableY = 10;
        CGFloat  textLableW = 100;
        CGFloat  textLableH = 40;
        textLable.text = @"加载中...";
        textLable.frame = CGRectMake(textLableX, textLableY, textLableW, textLableH);

    }
    return _loadView;
}

- (void)setStatus:(GPRefreshStatus)status
{
    _status = status;
        switch (status) {

            case GPRefreshStatusDraging:
            {
                if (self.type == GPRefreshPositionTypeFooter) {
                    [self.alertButton setTitle:@"上拉加载" forState:UIControlStateNormal];
                    self.alertButton.imageView.transform =CGAffineTransformIdentity;
                }
                else if(self.type == GPRefreshPositionTypeHeader)
                {
                    [self.alertButton setTitle:@"下拉加载" forState:UIControlStateNormal];
                    self.alertButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                }
                break;
            }
            case GPRefreshStatusDragingEnding:
            {
                [self.alertButton setTitle:@"松开加载" forState:UIControlStateNormal];
                if (self.type ==GPRefreshPositionTypeFooter) {
                    
                    self.alertButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                }
                else if(self.type ==GPRefreshPositionTypeHeader)
                {
                    self.alertButton.imageView.transform =CGAffineTransformIdentity;
                }
                break;
            }
            case GPRefreshStatusLoading:
            {
                self.alertButton.hidden = YES;
                [self.loadView class];
                break;
            }
            default:
                break;
        }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView * tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfH = 60;
    CGFloat selfY = (self.type == GPRefreshPositionTypeHeader)? -selfH :tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
}
@end
