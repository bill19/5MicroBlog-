//
//  GPHeadFooter.h
//  美食quanquan
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum
{
    GPHeadFooterWhoRefreshUsingHeaderRefresh,
    GPHeadFooterWhoRefreshUsingFooterRefresh
}GPHeadFooterWhoRefresh;
typedef enum
{
    GPHeadFooterUsingWhoHeader,
    GPHeadFooterUsingWhoFooter,
    GPHeadFooterUsingWhoBoth
}GPHeadFooterUsingWho;

@protocol GPHeadFooterDelegate <NSObject>
@required
- (void)loadDataByWhoRefresh:(GPHeadFooterWhoRefresh)who;
- (GPHeadFooterUsingWho)usingHeaderOrFooterOrBoth;
@end

@interface GPHeadFooter : NSObject

@property (nonatomic,assign)id <GPHeadFooterDelegate> delegate;

+(id)HeadFooterWithTableView:(UITableView *)tableView andInstall:(id<GPHeadFooterDelegate>)view;
- (void)GPscrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)GPscrollViewDidScroll:(UIScrollView *)scrollView;

@end
