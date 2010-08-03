//
//  SessionService.h
//  Match2
//
//  Created by Jaime on 8/2/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>


@protocol SessionServiceDelegate
    -(void) peerListChanged;
@end

@interface SessionService : NSObject<GKSessionDelegate> {
	GKSession* curSession;
	NSMutableArray *peerList;
    id <SessionServiceDelegate> delegate;
}

@property (nonatomic, retain) id <SessionServiceDelegate> delegate;

-(NSArray*) ListOfPeers;
-(NSString*) displayNameForPeer:(NSString*) peerID;

@end
