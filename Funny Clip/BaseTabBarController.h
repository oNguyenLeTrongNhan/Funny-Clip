//
//  BaseTabBarController.h
//  Funny Clip
//
//  Created by NhanNLT on 4/15/15.
//  Copyright (c) 2015 NhanNLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunBaseViewController.h"
@interface BaseTabBarController : UITabBarController

@property (weak, nonatomic) IBOutlet UITabBar *tabbar;
@property (weak, nonatomic) IBOutlet UITabBarItem *item1;
@property (retain) FunBaseViewController* baseViewController;
@end
