//
//  UITableView+LeeAutoLayoutCell.m
//  动态计算cell 的高度
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "UITableView+LeeAutoLayoutCell.h"
#import <objc/runtime.h>

static const char cellCacheKey;
@implementation UITableView (LeeAutoLayoutCell)

#pragma mark - 私有方法
/* 通过自动布局 来计算cell的高度 **/
- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration {
    
    UITableViewCell *cell = [self cellForReuseIdentifier:identifier];
    /*手动调用确保cell 在显示屏幕中 **/
    [cell prepareForReuse];
    /*需要把这个cell 传递出去 **/
    if (configuration) {
        configuration(cell);
    }
    /* 获得cell 的宽度 **/
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    
    
    /* 修复cell 的宽度 **/
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    if (contentViewWidth <= 0) {
        return 0;
    }
    
    CGSize fittingSize = CGSizeZero;
    
    /* 因为label 换行的时候 需要知道contentView 的最大的宽度 
     * 这个方法很good
     **/
    NSLayoutConstraint *tempWidthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:tempWidthConstraint];
    // 自动布局的系统方法 计算高度
    fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    /* 计算完后 再删除 **/
    [cell.contentView removeConstraint:tempWidthConstraint];
    /* 修复 线 的1个像素 **/
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
    }
    return fittingSize.height;
    
}

/* 获取 cell **/
- (UITableViewCell *)cellForReuseIdentifier:(NSString *)identifier {
    
    NSCache * cellCache = objc_getAssociatedObject(self, &cellCacheKey);
    if (cellCache == nil) {
        cellCache = [[NSCache alloc]init];
        objc_setAssociatedObject(self, &cellCacheKey, cellCache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UITableViewCell *cell = [cellCache objectForKey:identifier];
    if (cell == nil) {
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        /* cell 如果是nil 就报一个错误：提示用户应该要在tableView 注册cell**/
        NSAssert(cell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [cellCache setObject:cell forKey:identifier];
    }
    return cell;
    
}

#pragma mark - 公共方法
/* 返回自动布局cell的高度**/
- (CGFloat)heightForAutoLayoutCellWithIdentifier:(NSString *)identifier
                                     cacheForKey:(NSString *)key
                                   configuration:(void (^)(id cell))configuration {
    
    if (identifier.length == 0 || key.length == 0) {
        return 0;
    }
    /*先从缓存中取 **/
    CGFloat cachedHeight = [self heightOfCellForKey:key];
    if (cachedHeight >0) {
        return cachedHeight;
    }else {
        //计算cell 的高度并且缓存进去
        CGFloat height = [self heightForCellWithIdentifier:identifier configuration:configuration];
        /* 缓存cell的高度**/
        [self cacheCellHeight:height forKey:key];
        return height;
    }
    
}

@end
