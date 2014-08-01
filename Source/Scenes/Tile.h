//
//  Tile.h
//  MultiplayerTurnBasedGame
//
//  Created by Tolga Beser on 7/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Tile : CCNode

@property(nonatomic, assign)CGPoint point;
@property(nonatomic, strong)NSNumber *positionX;
@property(nonatomic, strong)NSNumber *positionY;

@end
