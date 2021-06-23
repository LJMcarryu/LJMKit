//
//  LJMHuobiViewController.m
//  LJMKit
//
//  Created by admin on 2021/6/16.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMHuobiViewController.h"

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface LJMHuobiViewController ()<UITableViewDelegate, UITableViewDataSource>

/// tableView
@property (nonatomic, strong) UITableView *tableView;

/// titleArray
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation LJMHuobiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"新闻(骨架图+PPNetworkHelper+YYModel)", @"地图（隐藏：GitHub上传有包的大小控制）"].mutableCopy;
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    cell.backgroundColor = kBackgroud_Color_Cell;
    cell.contentView.backgroundColor = kBackgroud_Color_Cell;
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = kBackgroud_Color_Main;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = UIView.new;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellReuseIdentifier];
    }
    return _tableView;
}

@end
