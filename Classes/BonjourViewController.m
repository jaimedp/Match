//
//  BonjourViewController.m
//  Match2
//
//  Created by Jaime on 7/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BonjourViewController.h"
#import <netinet/in.h>
#import <arpa/inet.h>

@implementation BonjourViewController

@synthesize tblView, services, browser;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


-(void)showMessage:(NSString*)msg {

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:msg
												delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];

}

-(void)browseForServices { 
	services = [[NSMutableArray alloc] init];
	self.browser = [[[NSNetServiceBrowser alloc] init] autorelease];
	self.browser.delegate = self;
	[self.browser searchForServicesOfType:@"_MyService._tcp." inDomain:@""];
	
}

-(void)resolveIpAddress: (NSNetService*) service {
	NSNetService* remoteService = service;
	remoteService.delegate = self;
	[remoteService resolveWithTimeout:0];
}

-(void)netServiceBrowser:(NSNetServiceBrowser*)aBrowser didFindService:(NSNetService*) aService moreComing:(BOOL)more {

	[services addObject:aService];
//	[self resolveIpAddress:aService];
	NSLog(@"did find service %@", aService);
    /*
    NSIndexPath* ip = [NSIndexPath indexPathForRow:[services count]-1 inSection:0];
    [[self tblView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationRight];
     */
    [self.tblView reloadData];
}

-(void)netServiceBrowser:(NSNetServiceBrowser*) aBrowser didRemoveService:(NSNetService*)aService moreComing:(BOOL)more {
    NSLog(@"Removing service: %@", aService);
    
    NSUInteger row = [services indexOfObject:aService];
    if(row == NSNotFound)
    {
        NSLog(@"Service not found");
        return;
    }
    
    
    
	[services removeObjectAtIndex:row];
    /*
    NSIndexPath* ip = [NSIndexPath indexPathForRow:row inSection:0];
    [[self tblView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationRight];
    */
	[self.tblView reloadData];
}

-(void)netServiceDidResolveAddress:(NSNetService *)sender {
	NSString* name = nil;
	NSData* address = nil;
	
	struct sockaddr_in* socketAddress = nil;
	NSString* ipAddress = nil;
	int port;
	
	for(int j=0; j<[[sender	addresses]count]; j++ )
	{
		name = [sender name];
		address = [[sender addresses] objectAtIndex:j];
		socketAddress = (struct sockaddr_in*) [address bytes];
		
		ipAddress = [NSString stringWithFormat:@"%s", inet_ntoa(socketAddress->sin_addr)];
		port = socketAddress->sin_port;
	}
	
	[self.tblView reloadData];
}

-(void) netService:(NSNetService*) service didNotResolve:(NSDictionary*)errors {
}

-(void)initView {
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	tblView = [[UITableView alloc] initWithFrame:[self.view bounds]];
    [self.view addSubview:tblView];
    
    
	[self.view setBackgroundColor:[UIColor redColor]];
	[self browseForServices];

    [super viewDidLoad];

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tblView release];
	[browser release];
	[services release];
	
    [super dealloc];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [services count];
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
	cell.textLabel.text = [services objectAtIndex:indexPath.row];
	return cell;
}
@end
