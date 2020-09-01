//
//  LJMTabBarViewController.m
//  LJMKit
//
//  Created by 刘佳明 on 2020/8/29.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMTabBarViewController.h"
#import "LJMMessageViewController.h"
#import "LJMCustomViewController.h"

@interface LJMTabBarViewController ()

@end

@implementation LJMTabBarViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:[self viewControllers] tabBarItemsAttributes:[self tabBarItemsAttributes]];
    self.navigationController.navigationBar.hidden = YES;
    return (self = (LJMTabBarViewController *)tabBarController);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray *)viewControllers {
    LJMMessageViewController *messageVC = LJMMessageViewController.alloc.init;
    messageVC.navigationItem.title = @"消息";
    UIViewController *messageNav = [[CYLBaseNavigationController alloc] initWithRootViewController:messageVC];
    [messageNav cyl_setHideNavigationBarSeparator:YES];

    LJMCustomViewController *customVC = LJMCustomViewController.alloc.init;
    customVC.navigationItem.title = @"自定义";
    UIViewController *customNav = [[CYLBaseNavigationController alloc] initWithRootViewController:customVC];
    [customNav cyl_setHideNavigationBarSeparator:YES];

    NSArray *viewControllers = @[
        messageNav,
        customNav
    ];

    return viewControllers;
}

- (NSArray<NSDictionary *> *)tabBarItemsAttributes {
    NSDictionary *messageTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"消息",
        CYLTabBarItemImage: @"tabbar_message_no",
        CYLTabBarItemSelectedImage: @"tabbar_message_yes",
    };
    NSDictionary *customTabBarItemsAttributes = @{
        CYLTabBarItemTitle: @"自定义",
        CYLTabBarItemImage: @"tabbar_friend_no",
        CYLTabBarItemSelectedImage: @"tabbar_friend_yes",
    };

    NSArray *tabBarItemsAttributes = @[
        messageTabBarItemsAttributes,
        customTabBarItemsAttributes,
    ];

    return tabBarItemsAttributes;
}

@end
