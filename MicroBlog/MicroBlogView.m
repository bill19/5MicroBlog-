//
//  MicroBlogView.m
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "MicroBlogView.h"
#import "MicoBlogCell.h"
#import "MicoCellFrame.h"
#import "GPHeadFooter.h"
@interface MicroBlogView ()<UITableViewDelegate,UITableViewDataSource,GPHeadFooterDelegate>
@property (nonatomic,retain) NSMutableArray * dataSource;
@property (nonatomic,retain)GPHeadFooter * headerFooter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
@implementation MicroBlogView

+(id)micoBlog
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (GPHeadFooter *)headerFooter
{
    if (!_headerFooter) {
        _headerFooter = [GPHeadFooter HeadFooterWithTableView:self.tableView andInstall:self];
    }
    return _headerFooter;
}
+(id)micoBlogWithModel:(NSArray *) models andTableView:(UIView *)view
{
    MicroBlogView * mic = [self micoBlog];
    mic.dataSource = (NSMutableArray *)models;
    [view addSubview:mic];
    return mic;
}

#pragma UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((MicoCellFrame *)_dataSource[indexPath.row]).cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MicoBlogCell * cell = [MicoBlogCell micoBlogCellWithModel:self.dataSource[indexPath.row] andtableView:tableView];
    return cell;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.headerFooter GPscrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerFooter GPscrollViewDidScroll:scrollView];
}
#pragma mark GPFooterRefreshDelegate
#pragma mark GPHeadFooterDelegate方法
- (void)loadDataByWhoRefresh:(GPHeadFooterWhoRefresh)who
{
    if (who == GPHeadFooterWhoRefreshUsingFooterRefresh) {
        [self.dataSource addObject:[self.dataSource objectAtIndex:arc4random()%self.dataSource.count]];
    }else if (who == GPHeadFooterWhoRefreshUsingHeaderRefresh)
    {
        [self.dataSource insertObject:[self.dataSource objectAtIndex:arc4random()%self.dataSource.count] atIndex:0];
    }
    
}
- (GPHeadFooterUsingWho)usingHeaderOrFooterOrBoth
{
    return GPHeadFooterUsingWhoBoth;
}
@end
