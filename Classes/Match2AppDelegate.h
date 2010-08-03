//
//  Match2AppDelegate.h
//  Match2
//
//  Created by Jaime on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Match2ViewController;

@interface Match2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Match2ViewController *viewController;
	
	NSNetService *netService;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Match2ViewController *viewController;
@property (nonatomic,retain) NSNetService *netService;

@end

