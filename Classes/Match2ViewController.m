//
//  Match2ViewController.m
//  Match2
//
//  Created by Jaime on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Match2ViewController.h"
#import <GameKit/GameKit.h>

@implementation Match2ViewController

@synthesize grid, label, groupSelector;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

    session = [[SessionService alloc] init];
    session.delegate = self;
    [super viewDidLoad];
	[self updateCountLabel];
    
    [groupSelector addTarget:self action:@selector(selectorAction:) forControlEvents:nil];
    
}

-(IBAction)selectorAction {
    NSLog(@"click on selector");
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [session release];
	[super dealloc];
}


-(void) peerListChanged {
    [self updateCountLabel];
    [self updatePeerList];
}

-(void) updatePeerList {
	[grid reloadData];
}

-(void) updateCountLabel {
    
	NSUInteger count = [[session ListOfPeers] count];

	[label setText:[NSString stringWithFormat:@"count : %d", count]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* peers = [session ListOfPeers];
	return [peers count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	// Set up the cell...
  
//    [cell.textLabel setText:@"someone"];
    NSString* peerID = [[session ListOfPeers] objectAtIndex:[indexPath row]];
    NSString* name = [session displayNameForPeer:peerID];
	[cell.textLabel setText:name];
    NSLog(@"change for %@", name);
//	cell.text = [peerList objectAtIndex:indexPath.row];
	return cell;
}

@end
