//
//  MicoCellFrame.h
//  MicroBlog
//
//  Created by qianfeng on 15-6-30.
//  Copyright (c) 2015年 lix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MicoBlogModel.h"
@interface MicoCellFrame : NSObject

@property (nonatomic,assign,readonly)CGRect photoViewF;
@property (nonatomic,assign,readonly)CGRect nameLabelF;
@property (nonatomic,assign,readonly)CGRect vipViewF;
@property (nonatomic,assign,readonly)CGRect titleLabelF;
@property (nonatomic,assign,readonly)CGRect picViewF;
@property (nonatomic,retain)MicoBlogModel * model;
@property (nonatomic,assign,readonly) CGFloat cellHeight;

+ (id)micoCellFrameWithModel:(MicoBlogModel *)model;
@end
