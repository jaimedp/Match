//
//  BonjourViewController.h
//  Match2
//
//  Created by Jaime on 7/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BonjourViewController : UIViewController<UITableViewDelegate> {
	
    UITableView *tblView;
	
	NSNetServiceBrowser *browser;
	NSMutableArray *services;
	
}

@property (nonatomic, retain) UITableView *tblView;
@property (nonatomic, retain) NSNetServiceBrowser *browser;
@property (nonatomic, retain) NSMutableArray *services;


@end
