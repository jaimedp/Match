//
//  ServicesController.m
//  Match2
//
//  Created by Jaime on 8/2/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ServicesController.h"


@implementation ServicesController



#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/

-(id) init {
    [super initWithStyle:UITableViewStylePlain];
    
    services = [[NSMutableArray alloc] init];
    
    browser = [[NSNetServiceBrowser alloc] init];
    
    [browser setDelegate:self];
    [browser searchForServicesOfType:@"_MyService._tcp." inDomain:@""];
    
    return self;
    
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [services count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    NSNetService* ns = [services objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[ns name]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}



-(void)browseForServices { 
	services = [[NSMutableArray alloc] initWithCapacity:5];
	browser = [[[NSNetServiceBrowser alloc] init] autorelease];
	browser.delegate = self;
	[browser searchForServicesOfType:@"_MyService._tcp." inDomain:@""];
	
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

    NSIndexPath* ip = [NSIndexPath indexPathForRow:[services count]-1 inSection:0];
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationRight];
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
    
     NSIndexPath* ip = [NSIndexPath indexPathForRow:row inSection:0];
     [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationRight];
}

/*
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
*/

@end

