//
//  Grid.h
//  MultiplayerTurnBasedGame
//
//  Created by Tolga Beser on 7/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Tile.h"

@interface Grid : CCNode


-(void)generateGrid;
-(id)init;
-(CGPoint) getPositionOfTile: (int) x andY: (int) y;
-(Tile *) getTileForTouchPosition: (CGPoint) pos;



@end
