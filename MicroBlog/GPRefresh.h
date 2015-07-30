//
//  GPRefresh.h
//  美食quanquan
//
//  Created by qianfeng on 15-7-2.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    GPRefreshStatusDraging,
    GPRefreshStatusDragingEnding,
    GPRefreshStatusLoading,

}GPRefreshStatus;

typedef enum
{
    GPRefreshPositionTypeHeader,
    GPRefreshPositionTypeFooter
}GPRefreshPositionType;

@interface GPRefresh : UIView
@property(nonatomic,assign)GPRefreshStatus status;
+(id)refreshWithPositionType:(GPRefreshPositionType)type;
@end
