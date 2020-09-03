//
//  LJMNewsViewController.m
//  LJMKit
//
//  Created by ios on 2020/8/31.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMNewsViewController.h"
#import "LJMNewsModel.h"
#import "LJMNewsTableViewCell.h"

#import "LJMWebViewController.h"

static NSString *newsCellID = @"newsCellID";

@interface LJMNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

/// tableView
@property (nonatomic, strong) UITableView *tableView;

/// titleArray
@property (nonatomic, strong) NSMutableArray <LJMNewsModel *> *dataArray;

@end

@implementation LJMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新闻(骨架图+PPNetworkHelper+YYModel)";
    self.view.backgroundColor = kBackgroud_Color;
    self.dataArray = @[].mutableCopy;
    [self.view addSubview:self.tableView];
    [self.tableView tab_startAnimation];
    [PPNetworkHelper GET:[NSString stringWithFormat:@"http://v.juhe.cn/toutiao/index"] parameters:@{ @"type": @"top", @"key": News_Key } success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        NSArray *resultArray = [NSArray arrayWithArray:dict[@"result"][@"data"]];
        for (NSDictionary *dic in resultArray) {
            LJMNewsModel *model = [LJMNewsModel yy_modelWithDictionary:dic];
            if (model.uniquekey.length > 0) {
                [self.dataArray addObject:model];
            }
        }
        [[BGDB shareManager] bg_saveOrUpateArray:self.dataArray ignoredKeys:nil complete:^(BOOL isSuccess) {
            NSLog(@"success");
        }];
        //TODO: 为了展示骨架图
        [NSThread sleepForTimeInterval:3.0];
        [self.tableView tab_endAnimation];
    } failure:^(NSError *error) {
        JMSLogError(@"%@", error.description);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJMNewsTableViewCell *cell = [[LJMNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCellID];
    LJMNewsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LJMNewsModel *model = self.dataArray[indexPath.row];
    LJMWebViewController *vc = LJMWebViewController.alloc.init;
    vc.webTitle = model.title;
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy init
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = kBackgroud_Color;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:LJMNewsTableViewCell.class forCellReuseIdentifier:newsCellID];
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:LJMNewsTableViewCell.class cellHeight:70];
    }
    return _tableView;
}

@end
