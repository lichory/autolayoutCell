//
//  UITableView+LeeAutoLayoutCell.h
//  动态计算cell 的高度
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+LeeKeyedHeightCache.h"

@interface UITableView (LeeAutoLayoutCell)

/* 返回自动布局cell的高度**/
- (CGFloat)heightForAutoLayoutCellWithIdentifier:(NSString *)identifier
                                     cacheForKey:(NSString *)key
                                   configuration:(void (^)(id cell))configuration;


@end
