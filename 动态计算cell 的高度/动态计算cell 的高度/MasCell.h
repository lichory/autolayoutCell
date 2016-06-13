//
//  MasCell.h
//  动态计算cell 的高度
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 李重阳. All rights reserved.
//

//引入该宏后，不用区别mas_equalTo和equalTo等，但一定要在Masonry.h头文件之前引入。
#define MAS_SHORTHAND_GLOBALS
//引入该宏后，不用区别mas_right和right等，但一定要在Masonry.h头文件之前引入
//#define MAS_SHORTHAND
#import "Masonry.h"


#import <UIKit/UIKit.h>
#import "MasModel.h"

@protocol MasCellDelegate <NSObject>

- (void)masCellMoreBtnClickWithMasModel:(MasModel *)model;

@end

@interface MasCell : UITableViewCell


@property (nonatomic,strong)MasModel * model;

@property (nonatomic,weak) id <MasCellDelegate>delegate;

@end
