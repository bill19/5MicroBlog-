//
//  MicoBlogController.m
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import "MicoBlogController.h"
#import "MicoBlogModel.h"
#import "MicoCellFrame.h"
#import "MicroBlogView.h"
@interface MicoBlogController ()
@property (nonatomic,retain)NSArray * micoBlogs;
@end

@implementation MicoBlogController

- (NSArray *)micoBlogs
{
    if (!_micoBlogs) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"statuses.plist" ofType:nil];
        NSArray * plist = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * tmpModels = [NSMutableArray array];
        for (NSDictionary * dic in plist) {
            MicoBlogModel * micoModel = [MicoBlogModel micoBlogWithDictionary:dic];
            MicoCellFrame * micFrame = [MicoCellFrame micoCellFrameWithModel:micoModel];
            [tmpModels addObject:micFrame];
        }
        _micoBlogs = tmpModels;
    }
    return _micoBlogs;
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MicroBlogView micoBlogWithModel:self.micoBlogs andTableView:self.view];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
