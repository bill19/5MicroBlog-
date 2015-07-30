//
//  GPHeadFooter.m
//  美食quanquan
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "GPHeadFooter.h"
#import "GPRefresh.h"
@interface GPHeadFooter()
@property (nonatomic,weak)GPRefresh * header;
@property (nonatomic,weak)GPRefresh * footer;
@property (nonatomic,weak)UITableView * tableView;
@end

@implementation GPHeadFooter
+(id)HeadFooterWithTableView:(UITableView *)tableView andInstall:(id<GPHeadFooterDelegate>)view
{
    GPHeadFooter * headFooter = [[GPHeadFooter alloc]init];
    headFooter.tableView = tableView;
    headFooter.delegate = view;
    return headFooter;
}

- (GPRefresh *)footer
{
    if ([self.delegate usingHeaderOrFooterOrBoth]==GPHeadFooterUsingWhoHeader) {
        return nil;
    }
    if (!_footer) {
        GPRefresh *footer = [GPRefresh refreshWithPositionType:GPRefreshPositionTypeFooter];
        [self.tableView addSubview:footer];
        _footer = footer;
    }
    return _footer;
}

- (GPRefresh *)header
{
    if ([self.delegate usingHeaderOrFooterOrBoth]==GPHeadFooterUsingWhoFooter) {
        return nil;
    }
    if (!_header) {
        GPRefresh * header = [GPRefresh refreshWithPositionType:GPRefreshPositionTypeHeader];
        [self.tableView addSubview:header];
        _header = header;
    }
    return _header;
}

- (void)GPscrollViewDidScroll:(UIScrollView *)scrollView
{
    //只安装了Header 不允许使用Footer
    if ([self.delegate usingHeaderOrFooterOrBoth]!=GPHeadFooterUsingWhoHeader) {
        
        CGFloat maxY = scrollView.contentSize.height - scrollView.frame.size.height;
        CGFloat footerHeight = self.footer.frame.size.height;
        //如果已经滑动到了底部，设置Footerd的状态位
        if (scrollView.contentOffset.y > maxY && scrollView.contentOffset.y < maxY + footerHeight) {
            [self.footer setStatus:GPRefreshStatusDraging];
        }
        if (scrollView.contentOffset.y > maxY + footerHeight) {
            [self.footer setStatus:GPRefreshStatusDragingEnding];
        }
    }
    //只安装了Footer不允许使用Header
    if ([self.delegate usingHeaderOrFooterOrBoth]!=GPHeadFooterUsingWhoFooter) {
        
        CGFloat headerHeight = self.header.frame.size.height;
        CGFloat minY = 0;
        
        //如果已经滑动到了顶，设置header的状态位
        if (scrollView.contentOffset.y < minY && scrollView.contentOffset.y > minY - headerHeight) {
            [self.header setStatus:GPRefreshStatusDraging];
        }
        if (scrollView.contentOffset.y < minY - headerHeight) {
            [self.header setStatus:GPRefreshStatusDragingEnding];
        }
    }
}
- (void)GPscrollViewDidEndDragging:(UIScrollView *)scrollView
{
    
    //只安装了Footer不允许使用Header
    if ([self.delegate usingHeaderOrFooterOrBoth]!=GPHeadFooterUsingWhoFooter) {
        
        if (self.header.status == GPRefreshStatusDragingEnding) {
            [self.header setStatus:GPRefreshStatusLoading];
            scrollView.contentInset = UIEdgeInsetsMake(self.header.frame.size.height, 0, 0, 0);
            //加载数据完成
            //恢复 contentInset
            //删除 footerRefresh
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                [self.delegate loadDataByWhoRefresh:GPHeadFooterWhoRefreshUsingHeaderRefresh];
                [(UITableView *)scrollView reloadData];
                [self.header removeFromSuperview];
                [self.footer removeFromSuperview];
            });
        }
    }
    
    //只安装了Header 不允许使用Footer
    if ([self.delegate usingHeaderOrFooterOrBoth]!=GPHeadFooterUsingWhoHeader) {
        
        if (self.footer.status == GPRefreshStatusDragingEnding) {
            [self.footer setStatus:GPRefreshStatusLoading];
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.footer.frame.size.height, 0);
            //加载数据完成
            //恢复 contentInset
            //删除 footerRefresh
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                [self.delegate loadDataByWhoRefresh:GPHeadFooterWhoRefreshUsingFooterRefresh];
                [(UITableView *)scrollView reloadData];
                [self.footer removeFromSuperview];
                [self.header removeFromSuperview];
                
            });
        }
    }
}


@end
