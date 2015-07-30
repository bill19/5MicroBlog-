//
//  MicoBlogCell.h
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicoCellFrame.h"
@interface MicoBlogCell : UITableViewCell
@property (nonatomic,retain) MicoCellFrame * micoFrame;


+(id)micoBlogCellWithModel:(MicoCellFrame *)micoFrame andtableView:(UITableView *)tableView;


@end
