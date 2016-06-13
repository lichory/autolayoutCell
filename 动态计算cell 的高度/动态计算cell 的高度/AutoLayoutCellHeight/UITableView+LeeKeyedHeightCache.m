//
//  UITableView+LeeKeyedHeightCache.m
//  动态计算cell 的高度
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 李重阳. All rights reserved.
//


#import "UITableView+LeeKeyedHeightCache.h"
#import <objc/runtime.h>

@interface LeeKeyedHeightCache ()

/* 竖着的 高度缓存数组**/
@property (nonatomic, strong) NSCache *heightValuesForPortrait;
/* 全屏的 高度缓存数组**/
@property (nonatomic, strong) NSCache *heightValuesForLandscape;


/* 把某个高度 缓存到 key 中去**/
- (void)cacheHeight:(CGFloat)height forKey:(NSString *)key;
/* 从key 中取出某个高度 **/
- (CGFloat)heightForKey:(NSString *)key;
/* 清空某个Key的缓存的高度 **/
- (void)removeHeightForKey:(NSString *)key;
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCache;


@end

@implementation LeeKeyedHeightCache

#pragma mark - 初始化数据
/*初始化数据源 **/
- (NSCache *)heightValuesForPortrait {
    
    if (_heightValuesForPortrait == nil) {
        _heightValuesForPortrait = [[NSCache alloc]init];
    }
    return _heightValuesForPortrait;
}

- (NSCache *)heightValuesForLandscape {
    
    if (_heightValuesForLandscape == nil) {
        _heightValuesForLandscape = [[NSCache alloc]init];
    }
    return _heightValuesForLandscape;
}


#pragma mark - 私有方法
/* 判断出是 竖屏 还是 横屏中的某个值 **/
- (NSCache *)heightValuesForCurrentOrientation {
    
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? self.heightValuesForPortrait:self.heightValuesForLandscape;
}

/* 通过number类型转换成CGFloat 类型**/
- (CGFloat)getFloatValueWithNumber:(NSNumber *)number {
    
#if CGFLOAT_IS_DOUBLE
    return [number doubleValue];
#else
    return [number floatValue];
#endif
    
}

#pragma mark - 公共接口

/* 把某个高度 缓存到 key 中去**/
- (void)cacheHeight:(CGFloat)height forKey:(NSString *)key {
    
    if (height > 0) {
        [self.heightValuesForCurrentOrientation setObject:@(height) forKey:key];
    }
    
}
/* 从key 中取出某个高度 **/
- (CGFloat)heightForKey:(NSString *)key {
    
    NSNumber * number = [self.heightValuesForCurrentOrientation objectForKey:key];
    return [self getFloatValueWithNumber:number];
}


/* 清空某个Key的缓存的高度 **/
- (void)removeHeightForKey:(NSString *)key {
    
    [self.heightValuesForPortrait  removeObjectForKey:key];
    [self.heightValuesForLandscape removeObjectForKey:key];
}
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCache {
    
    [self.heightValuesForPortrait  removeAllObjects];
    [self.heightValuesForLandscape removeAllObjects];
}

@end


/*-------------------华丽的分界线-------------------**/
/* 在类别中加入一个缓存对象**/
static const char LeeKeyedHeightCacheKey;


@implementation UITableView (LeeKeyedHeightCache)

- (LeeKeyedHeightCache *)keyedHeighCache {
    
    LeeKeyedHeightCache * cache = objc_getAssociatedObject(self, &LeeKeyedHeightCacheKey);
    if (cache == nil) {
        
        cache = [[LeeKeyedHeightCache alloc]init];
        objc_setAssociatedObject(self, &LeeKeyedHeightCacheKey, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}



/* 把某个高度 缓存到 key 中去**/
- (void)cacheCellHeight:(CGFloat)height forKey:(NSString *)key {
    
    [self.keyedHeighCache cacheHeight:height forKey:key];
}
/* 从key 中取出某个高度 **/
- (CGFloat)heightOfCellForKey:(NSString *)key {
    
    return [self.keyedHeighCache heightForKey:key];
}

/* 清空某个Key的缓存的高度 **/
- (void)removeHeightCacheOfCellForKey:(NSString *)key {
    
    [self.keyedHeighCache removeHeightForKey:key];
}
/* 清空所有的缓存的高度 **/
- (void)removeAllHeightCacheOfCell {
    
    [self.keyedHeighCache removeAllHeightCache];
}




@end
