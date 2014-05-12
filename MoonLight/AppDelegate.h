//
//  AppDelegate.h
//  MoonLight
//
//  Created by chen Jaykie on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong,nonatomic) LightViewController *lightViewController;
@end
