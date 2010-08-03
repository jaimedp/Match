//
//  Match2ViewController.h
//  Match2
//
//  Created by Jaime on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionService.h"


@interface Match2ViewController : UIViewController<SessionServiceDelegate> {

    IBOutlet UISegmentedControl *groupSelector;
    SessionService* session;
	IBOutlet UITableView *grid;
	IBOutlet UILabel *label;
}

@property (nonatomic, retain) IBOutlet UITableView *grid;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UISegmentedControl *groupSelector;

-(void) updatePeerList;
-(void) updateCountLabel;
-(void) peerListChanged;
-(IBAction)selectorAction;
	

@end

