//
//  ViewController.m
//  动态计算cell 的高度
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "ViewController.h"
#import "MasModel.h"
#import "MasCell.h"
#import "UITableView+LeeAutoLayoutCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MasCellDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
    
        make.top.and.left.and.bottom.and.right.equalTo(0);
        
    }];
    
    _dataArr = [[NSMutableArray alloc]init];
    
    
    NSArray * contentArr = @[
                             @"1asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa123",
                             @"2asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa123",
                             @"3asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa123",
                             @"4asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa1234",
                             @"5asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa234",
                             @"6qewfasdfadsfasdfadsf123",
                             @"7asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfaasdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa123",
                             @"8asdfasdfjasl;dkfja; Do any additional setup after loading the view, typically from a nibsldjfasdfasdfadfa1234",
                             ];
    for (NSInteger i = 0; i< contentArr.count; i++) {
        
        MasModel * model = [[MasModel alloc]init];
        model.name = [NSString stringWithFormat:@"name ___ %@",@(i)];
        model.content = contentArr[i];
        [self.dataArr addObject:model];
        
    }
    
    [self.tableView reloadData];
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MasCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MasCell" forIndexPath:indexPath];
    
    cell.model = self.dataArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return [self.tableView heightForAutoLayoutCellWithIdentifier:@"MasCell" cacheForKey:[NSString stringWithFormat:@"MasCell%ld_%ld",indexPath.section,indexPath.row] configuration:^(MasCell *cell) {
        /*cell  需要重新布局 **/
        cell.model = self.dataArr[indexPath.row];
    }];
    
    
}

- (void)masCellMoreBtnClickWithMasModel:(MasModel *)model {
    
    /* 删除所有的 cell 的高度缓存**/
    [self.tableView removeAllHeightCacheOfCell];
    [self.tableView reloadData];
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MasCell class] forCellReuseIdentifier:NSStringFromClass([MasCell class])];
        
    }
    return _tableView;
}

@end


















