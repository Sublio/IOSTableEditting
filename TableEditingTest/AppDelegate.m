//
//  AppDelegate.m
//  TableEditingTest
//
//  Created by sublio on 08/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import "AppDelegate.h"
#import "DMViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    DMViewController* controller = [[DMViewController alloc]init];
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    
    self.window.rootViewController = navController;
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
