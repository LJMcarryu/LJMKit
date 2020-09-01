//
//  LJMCustomViewController.m
//  LJMKit
//
//  Created by 刘佳明 on 2020/8/29.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMCustomViewController.h"

#import "LJMNewsViewController.h"
#import "LJMMapViewController.h"

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface LJMCustomViewController ()<UITableViewDelegate, UITableViewDataSource>

/// tableView
@property (nonatomic, strong) UITableView *tableView;

/// titleArray
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation LJMCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"新闻(骨架图+PPNetworkHelper+YYModel)", @"地图"].mutableCopy;
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
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[NSClassFromString(@"LJMNewsViewController")alloc]init] animated:YES];
            break;
        case 1:
        [self.navigationController pushViewController:[[NSClassFromString(@"LJMMapViewController")alloc]init] animated:YES];
        break;

        default:
            break;
    }
}

#pragma mark - lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = kBackgroud_Color;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellReuseIdentifier];
    }
    return _tableView;
}

@end
