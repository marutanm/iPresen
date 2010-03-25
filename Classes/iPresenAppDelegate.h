//
//  iPresenAppDelegate.h
//  iPresen
//
//  Created by marutanm on 3/21/10.
//  Copyright shisobu.in 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageControlViewController;

@interface iPresenAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	PageControlViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PageControlViewController *viewController;

@end
