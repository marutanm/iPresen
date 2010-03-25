//
//  iPresenAppDelegate.m
//  iPresen
//
//  Created by marutanm on 3/21/10.
//  Copyright shisobu.in 2010. All rights reserved.
//

#import "iPresenAppDelegate.h"
#import "PageControlViewController.h"

@implementation iPresenAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    self.window = [[[UIWindow alloc] initWithFrame:screenBounds] autorelease];
    viewController = [[PageControlViewController alloc] init];
    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end

