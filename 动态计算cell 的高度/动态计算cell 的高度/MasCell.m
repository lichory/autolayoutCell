//
//  MasCell.m
//  动态计算cell 的高度
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "MasCell.h"


@interface MasCell ()

@property (nonatomic,strong) UIView * baseView;

@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) UIButton* moreBtn;

@end

@implementation MasCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor yellowColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        
        [self setupSubviews];
      
        [self setupMas_Constraints];
        
    }
    return self;
}


/* 初始化数据 **/
- (void)setupSubviews {
    /* 基本视图**/
    _baseView = [[UIView alloc]init];
    _baseView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_baseView];
    
    /* 名字 **/
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.backgroundColor = [UIColor blueColor];
    [_baseView addSubview:_nameLabel];
    
    /* 内容 **/
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.backgroundColor = [UIColor redColor];
    _contentLabel.numberOfLines = 0;
    [_baseView addSubview:_contentLabel];
    
    /* 是否显示更多的按钮 **/
    _moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_moreBtn setTitle:@"点击" forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_moreBtn];
    
}

/* 设置限制 **/
- (void)setupMas_Constraints {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    /* 基本视图**/
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(padding.top);
        make.left.equalTo(padding.left);
        
        make.bottom.equalTo(-padding.bottom);
        make.right.equalTo(-padding.right);
    }];
    
    /* 名字 **/
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(0);
        make.left.equalTo(0);
        
        make.width.equalTo(100);
        make.height.equalTo(21);
        
        
    }];
    
    /** 内容 */
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.bottom.equalTo(self.moreBtn.mas_top);
        make.right.equalTo(0);
        
    }];
    
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(0);
//        make.left.equalTo(self.nameLabel.mas_right).offset(10);
//        make.height.equalTo(120);
//        make.right.equalTo(0);
//    }];
    
    /* 是否显示更多的按钮 **/
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.left.equalTo(self.contentLabel.mas_left);
        make.bottom.equalTo(-10);
        make.width.equalTo(50);
        
    }];
    
   
    
    
    
}

- (void)setModel:(MasModel *)model {
    
    
    
    _model = model;
    
    if (self.model.isOpen) {
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
            make.height.equalTo(120);
            make.right.equalTo(0);
        }];
        
    }else {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
            make.bottom.equalTo(self.moreBtn.mas_top);
            make.right.equalTo(0);
        }];
    }
    
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.content;
    
    
    
    
    //[self updateConstraints];
}


- (void)moreBtnClick {
    
    self.model.isOpen = !self.model.isOpen;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    
    
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        [self layoutIfNeeded];
//    }];
    
    if ([self.delegate respondsToSelector:@selector(masCellMoreBtnClickWithMasModel:)]) {
        [self.delegate masCellMoreBtnClickWithMasModel:self.model];
    }
}

//+ (BOOL)requiresConstraintBasedLayout
//{
//    return YES;
//}
//
//- (void)updateConstraints {
//    
//    if (self.model.isOpen) {
//        
//        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(0);
//            make.left.equalTo(self.nameLabel.mas_right).offset(10);
//            make.height.equalTo(120);
//            make.right.equalTo(0);
//        }];
//        
//    }else {
//        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(0);
//            make.left.equalTo(self.nameLabel.mas_right).offset(10);
//            make.bottom.equalTo(self.moreBtn.mas_top);
//            make.right.equalTo(0);
//        }];
//    }
//    
//    
//    [super updateConstraints];
//    
//}

@end























