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

    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    // NSLog([NSString stringWithFormat:@"screenBounds\norigin.x:%f\norigin.y:%f\nsize.width:%f\nsize.height%f", screenBounds.origin.x, screenBounds.origin.y, screenBounds.size.width, screenBounds.size.height]);
    self.window = [[[UIWindow alloc] initWithFrame:screenBounds] autorelease];
    window.backgroundColor = [UIColor cyanColor];

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

