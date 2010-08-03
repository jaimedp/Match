//
//  ServicesController.h
//  Match2
//
//  Created by Jaime on 8/2/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ServicesController : UITableViewController {
	
	NSNetServiceBrowser *browser;
	NSMutableArray *services;    
}

@end