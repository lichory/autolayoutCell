//
//  UITableView+LeeKeyedHeightCache.h
//  动态计算cell 的高度
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import <UIKit/UIKit.h>

/*缓存对象Cache**/
@interface LeeKeyedHeightCache : NSObject


@end


/*-------------------华丽的分界线-------------------**/
@interface UITableView (LeeKeyedHeightCache)


/*
 * 下面两个方法  用户是可以使用
 * 情况  1.当cell 改变的时候需要删除缓存高度
        2.当cell 删除、增加 等等，只要index的顺序改变了，都要重新改变
 **/
/* 清空某个Key的缓存的高度 **/
- (void)removeHeightCacheOfCellForKey:(NSString *)key;
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell;


/*
 * 下面两个方法不需要 用户使用的
 **/
/* 把某个高度 缓存到 key 中去**/
- (void)cacheCellHeight:(CGFloat)height forKey:(NSString *)key;
/* 从key 中取出某个高度 **/
- (CGFloat)heightOfCellForKey:(NSString *)key;



@end
