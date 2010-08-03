//
//  SessionService.m
//  Match2
//
//  Created by Jaime on 8/2/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "SessionService.h"


@implementation SessionService

@synthesize delegate;

-(id) init {
   	peerList = [[NSMutableArray alloc]init];

    NSString* name = [[UIDevice currentDevice]name];
    NSLog(@"device name: %@", name);
	curSession = [[GKSession alloc] initWithSessionID:nil displayName:name sessionMode:GKSessionModePeer];
	curSession.delegate = self;
	[curSession setDataReceiveHandler:self withContext:NULL];
	curSession.available = YES; 
    
    return self;
}

-(void)receiveData:(NSData*)data fromPeer:(NSString*)peer inSession:(GKSession*) session context:(void*)context{
    NSLog(@"receiveData: %@", data);
    
}



-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	switch (state) { 
        case GKPeerStateAvailable:
            // A peer became available by starting app, exiting settings, or ending a call.
            if (![peerList containsObject:peerID]) {
                [peerList addObject:peerID]; 
            }
            break;
        case GKPeerStateUnavailable:
            // Peer unavailable due to joining a call, leaving app, or entering settings.
            [peerList removeObject:peerID]; 
            break;
        case GKPeerStateConnected:
            // Connection was accepted, set up the voice chat.
            //            currentConfPeerID = [peerID retain];
            curSession.available = NO;
            //            sessionState = ConnectionStateConnected;
            // Compare the IDs to decide which device will invite the other to a voice chat.            }
            break;              
        case GKPeerStateDisconnected:
            // The call ended either manually or due to failure somewhere.
            //            [self disconnectCurrentCall];
            [peerList removeObject:peerID]; 
            //            [lobbyDelegate peerListDidChange:self];
            break;
        case GKPeerStateConnecting:
            // Peer is attempting to connect to the session.
            break;
        default:
            break;
    }
    
    NSString* name = [session displayNameForPeer:peerID];
    
    NSLog(@"didChangeState peerId: %@", name);
    /*&& [delegate respondsToSelector:@selector(peerListChanged:)]*/
    if(delegate)
        [delegate peerListChanged];
    
}


-(void)session:(GKSession *)session didFailWithError:(NSError *)error {
    NSLog(@"failed with error: %@", error);
}

-(NSArray*) ListOfPeers {
    return peerList;
}

-(NSString*) displayNameForPeer:(NSString*) peerID {
    return [curSession displayNameForPeer:peerID];
}

-(void)dealloc {
    [curSession disconnectFromAllPeers];
    curSession.available = NO;
    curSession.delegate = nil;
    [curSession setDataReceiveHandler:nil withContext:nil];
    [curSession release];
    curSession = nil;
    
    [peerList removeAllObjects];
    [peerList release];
    peerList = nil;
    
    [super dealloc];
    
}

@end
