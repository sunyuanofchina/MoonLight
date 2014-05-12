//
//  AppDelegate.m
//  MoonLight
//
//  Created by chen Jaykie on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController;
@synthesize lightViewController;

- (void)dealloc
{
    [_window release];
    [tabBarController release];
    [lightViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if 1
    NSData *dataTV = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://live.tv.sohu.com"]];
    //NSData *dataUTF8 = [self GBK2Utf8:dataTV];
    char *pdataTV = (char *)[dataTV bytes];
    int len = strlen(pdataTV);
    printf("len =%d,%s\n",len,pdataTV);
    
#endif
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabBarController = [[UITabBarController alloc] init];
    lightViewController =[[LightViewController alloc]init];
#if 0
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:lightViewController, nil];
    self.window.rootViewController = self.tabBarController;
    [lightViewController release];
#endif
     self.window.rootViewController = lightViewController;
   
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [lightViewController turnOffLed:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    if (lightViewController.isLightOn) {
        [lightViewController turnOnLed:YES];
    }
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
