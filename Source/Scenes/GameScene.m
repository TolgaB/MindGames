//
//  GameScene.m
//  MultiplayerTurnBasedGame
//
//  Created by Tolga Beser on 7/8/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "UserInfo.h"
#import "CCSpriteDownloadImage.h"
#import "Tile.h"
#import "Grid.h"

@implementation GameScene {
    CCSprite *_playerOne;
    Grid * myGrid;
    CCSprite *_playerTwo;
    
    BOOL playerOneTurn;
    
    
    NSString *_opponent;
    NSString *_gameState;
    NSMutableDictionary *_gameData;
    
    
    int officialMoveNumber;
    int _playerOneHealth;
    int _playerTwoHealth;
    
    bool pastFirstMove;
    
    bool firstPlayerCanShoot;
    bool secondPlayerCanShoot;
    
    CCButton *_rematchButton;
    
    bool pastFirstTurn;
    int gameId;
    
    
    CCLabelTTF *_titleBarLabel;
    
    int moveNumber;
    
    bool isMoveButtonPressed;
    bool isShootButtonPressed;
    bool isMeleeButtonPressed;
    bool _isFirstPlayer;
    
    NSString *_checkOpponent;
   
    
    
}

-(void)onEnter {
    [super onEnter];
    
    self.userInteractionEnabled = TRUE;
    playerOneTurn = YES;
    officialMoveNumber = 1;
    pastFirstMove =  false;
    _rematchButton.visible = NO;
    playerOneTurn = true;
    _opponent = _game[@"opponent"];
    pastFirstTurn = false;
    isMeleeButtonPressed = false;
    isMoveButtonPressed = false;
    isShootButtonPressed = false;
    
    
    
    [self reload];
    
    [self gameStarted];
    
}

-(void)gameStarted {
   
   
    //This loads the grid
    myGrid = [[Grid alloc ]init];
    NSLog(@"The grid has been initialized");
    
   // _playerOne.position = [myGrid getPositionOfTile:2 andY:0];
    
   // _playerTwo.position = [myGrid getPositionOfTile:0 andY:2];
    
    
    [self reload];
    
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self reload];
    
    CGPoint touchLocation = [touch locationInNode:self];
    Tile* myTile = [myGrid getTileForTouchPosition:touchLocation];
    
    
    if (isMoveButtonPressed == true) {
        
        
        
        
        
        
        
        
        if ((moveNumber % 2) == 0 )  {
            CGPoint _playerTwoPos = _playerTwo.position;
            
              if (abs(_playerTwoPos.x - touchLocation.x) < 175.5 & abs(_playerTwoPos.y - touchLocation.y) < 175.5) {
                  
                  if ([_gameState isEqualToString:@"inprogress"] || [_gameState isEqualToString:@"started"]) {
                      
                      _gameState = @"inprogress";
                      
                      _playerTwo.position = myTile.position;
                      //NSDictionary *playerMove = @{@"X": myTile.positionX, @"Y": myTile.positionY}; //nbb*
                      _gameData = [@{@"X": myTile.positionX, @"Y": myTile.positionY, @"player" : @"playertwo"} mutableCopy];
                      [MGWU move:_gameData withMoveNumber:moveNumber forGame:gameId withGameState:_gameState withGameData:_gameData againstPlayer:_opponent withPushNotificationMessage:@"Opponent has moved" withCallback:@selector(gotGame:) onTarget:self];
                      
                      NSLog(@"[A] %i ----------- touchBegan -------\nID:%d\nState: %@\nData:%@\nopponent:%@\n", moveNumber, gameId, _gameState, _gameData, _opponent);
                      officialMoveNumber++;
                      
                      
                      [[CCDirector sharedDirector] popToRootScene];
                  }
                  
                  
                  
              }
            
            
        }
        
        
        
        
        
        else if (!(moveNumber % 2) == 0) {
            
            CGPoint _playerOnePos = _playerOne.position;
            
            
            NSLog(@" %f, player x, %f, player y", _playerOnePos.x, _playerOnePos.y);
            
            
            
            
            
            
            if (abs(_playerOnePos.x - touchLocation.x) < 175.5 & abs(_playerOnePos.y - touchLocation.y) < 175.5) {
            
        
    
    
    if (_gameState == nil) {
        
        NSLog(@"Game started move");
        if(myTile != nil){
            
            
            
            
            _playerOne.position = myTile.position;
            //NSDictionary *playerMove = @{@"X": myTile.positionX, @"Y": myTile.positionY};
            _gameData = [@{@"X": myTile.positionX, @"Y": myTile.positionY} mutableCopy];
            [MGWU move:_gameData withMoveNumber:moveNumber forGame:0 withGameState:@"started" withGameData:_gameData againstPlayer:_opponent withPushNotificationMessage:@"Opponent has moved" withCallback:@selector(moveCompleted:) onTarget:self];
        
            
          
        
               [[CCDirector sharedDirector] popToRootScene];
            
          
            
        
        }
    }
        
    
        if ([_gameState isEqualToString:@"inprogress"] || [_gameState isEqualToString:@"started"]) {
            
            _gameState = @"inprogress";
            
            _playerOne.position = myTile.position;
            //NSDictionary *playerMove = @{@"X": myTile.positionX, @"Y": myTile.positionY};
            _gameData = [@{@"X": myTile.positionX, @"Y": myTile.positionY} mutableCopy];
            [MGWU move:_gameData withMoveNumber:moveNumber forGame:gameId withGameState:_gameState withGameData:_gameData againstPlayer:_opponent withPushNotificationMessage:@"Opponent has moved" withCallback:@selector(gotGame:) onTarget:self];
            
            NSLog(@"[B] %i ----------- touchBegan -------\nID:%d\nState: %@\nData:%@\nopponent:%@\n", moveNumber, gameId, _gameState, _gameData, _opponent);
            officialMoveNumber++;
            
            officialMoveNumber++;
          
            
               [[CCDirector sharedDirector] popToRootScene];
                   }
        
    
    }
    
    }
    
    }
    
    
    
    
    
    

    if (isShootButtonPressed == true) {
        
        
        
        
        if (_gameState == nil) {
            
            NSLog(@"Game started move");
            if(myTile != nil){
                
                
                
                //NSDictionary *playerMove = @{@"X": myTile.positionX, @"Y": myTile.positionY};
                _gameData = [@{@"X": @"test", @"Y": @"test"} mutableCopy];
                [MGWU move:_gameData withMoveNumber:moveNumber forGame:0 withGameState:@"started" withGameData:_gameData againstPlayer:_opponent withPushNotificationMessage:@"Opponent has moved" withCallback:@selector(moveCompleted:) onTarget:self];
                
                
                pastFirstMove = false;
                
                
                [[CCDirector sharedDirector] popToRootScene];
                
                
                
                
            }
        }

        
        
        if ([_gameState isEqualToString:@"inprogress"] || [_gameState isEqualToString:@"started"]) {
            
            _gameState = @"inprogress";
            

            //NSDictionary *playerMove = @{@"X": myTile.positionX, @"Y": myTile.positionY};
            _gameData = [@{@"X": @"test", @"Y": @"test"} mutableCopy];
            [MGWU move:_gameData withMoveNumber:moveNumber forGame:gameId withGameState:_gameState withGameData:_gameData againstPlayer:_opponent withPushNotificationMessage:@"Opponent has moved" withCallback:@selector(gotGame:) onTarget:self];
            
            officialMoveNumber++;
            
            
            [[CCDirector sharedDirector] popToRootScene];
            
        }

        
        
        
        
        
    }
    
    
    NSLog(@"Touch Gotten");
  

    
      
}


-(void)reload {
    

    NSLog(@"Reloaded");
     moveNumber = [_game[@"movecount"] intValue] + 1;
    
    _gameData = _game[@"gamedata"];
    
    gameId = [_game[@"gameid"] intValue];
    
    
    _opponent = _game[@"opponent"];
    
    
   _gameState = _game[@"gamestate"];

    
    
    if (_gameState == nil) {
        
        NSLog(@"Game is nil");
        
        _playerOne.position = [myGrid getPositionOfTile:2 andY:0];
         _playerTwo.position = [myGrid getPositionOfTile:0 andY:2];
        
        
        
       /* _checkOpponent = _game[@"opponent"];
        
        if ([_checkOpponent  isEqual: @"mgwu-random"]) {
            _isFirstPlayer = true;
        }
        
        else {
            _isFirstPlayer = false;
        }
        */

        
        
    }

    if ([_gameState  isEqualToString:@"inprogress"]) {
        
        
        NSLog(@"Game in progress");
        
        NSArray *myMoves= [_game objectForKey: @"moves"];
        NSLog(@"------move Dictionary receive---------\n%@", myMoves);
        
        //NSDictionary *lastMove= [myMoves lastObject];
        NSDictionary *lastMove= [myMoves objectAtIndex: [myMoves count] - 1];
        NSDictionary *prevMove= [myMoves objectAtIndex: [myMoves count] - 2 ];
        
        int sizeOfArray = [myMoves count];
        
        if (!(sizeOfArray % 2) == 0) {
        
        NSLog(@"%@, %@", [lastMove objectForKey: @"X"], [lastMove objectForKey: @"Y"]);
        NSLog(@"done");
        
        CGPoint refreshFirstPlayerPos;
        
        float refreshX = [[lastMove objectForKey: @"X"] integerValue];
        float refreshY = [[lastMove objectForKey: @"Y"] integerValue];
        
        refreshFirstPlayerPos = CGPointMake(refreshX, refreshY);
        
        _playerOne.position = refreshFirstPlayerPos;
            
            
            float refreshOtherPlayerX = [[prevMove objectForKey: @"X"] integerValue];
            float refreshOtherPlayerY = [[prevMove objectForKey: @"Y"] integerValue];
            
            CGPoint refreshOtherPlayerPos = CGPointMake(refreshOtherPlayerX, refreshOtherPlayerY);
            
            _playerTwo.position = refreshOtherPlayerPos;
        
        }
        
        else if ((sizeOfArray % 2) ==0) {
            
            
            NSLog(@"%@, %@", [lastMove objectForKey: @"X"], [lastMove objectForKey: @"Y"]);
            NSLog(@"done");
            
            CGPoint refreshSecondPlayerPos;
            
            float refreshX = [[lastMove objectForKey: @"X"] integerValue];
            float refreshY = [[lastMove objectForKey: @"Y"] integerValue];
            
            refreshSecondPlayerPos = CGPointMake(refreshX, refreshY);
            
            _playerTwo.position = refreshSecondPlayerPos;
            
            float refreshOtherPlayerX = [[prevMove objectForKey: @"X"] integerValue];
            float refreshOtherPlayerY = [[prevMove objectForKey: @"Y"] integerValue];
            
            CGPoint refreshOtherPlayerPos = CGPointMake(refreshOtherPlayerX, refreshOtherPlayerY);
            
            _playerOne.position = refreshOtherPlayerPos;
        }
    }
    
    
    if ([_gameState isEqualToString:@"started"]) {
        
        _playerTwo.position = [myGrid getPositionOfTile:0 andY:2];
        
        NSLog(@"Game in started");
        
        NSLog(@"Game in progress");
        NSArray *myMoves= [_game objectForKey: @"moves"];
        
        
        //NSDictionary *lastMove= [myMoves lastObject];
        NSDictionary *lastMove= [myMoves objectAtIndex: [myMoves count] - 1];
       

        
        int sizeOfArray = [myMoves count];
        
        if (!(sizeOfArray % 2) == 0) {
            
            NSLog(@"%@, %@", [lastMove objectForKey: @"X"], [lastMove objectForKey: @"Y"]);
            NSLog(@"done");
            
            CGPoint refreshFirstPlayerPos;
            
            float refreshX = [[lastMove objectForKey: @"X"] integerValue];
            float refreshY = [[lastMove objectForKey: @"Y"] integerValue];
            
            refreshFirstPlayerPos = CGPointMake(refreshX, refreshY);
            
            _playerOne.position = refreshFirstPlayerPos;
            
            
            
        }
        
        else if ((sizeOfArray % 2) ==0) {
            
            //This loads the move of the second player
            NSLog(@"%@, %@", [lastMove objectForKey: @"X"], [lastMove objectForKey: @"Y"]);
            NSLog(@"done");
            
            CGPoint refreshSecondPlayerPos;
            
            float refreshX = [[lastMove objectForKey: @"X"] integerValue];
            float refreshY = [[lastMove objectForKey: @"Y"] integerValue];
            
            refreshSecondPlayerPos = CGPointMake(refreshX, refreshY);
            
            _playerTwo.position = refreshSecondPlayerPos;
            
            
        }
    }
    
    
    
    
    if ([_game[@"turn"] isEqualToString:_opponent]) {
        _titleBarLabel.string = @"Waiting";
        
    }
    
    if (![_game[@"turn"] isEqualToString:_opponent]) {
        _titleBarLabel.string = @"Move Now";
    }
    
    
}

- (void)gotGame:(NSMutableDictionary*)game {
    NSLog(@"gotGame");
    _game = game;
    
}




- (void)backButtonPressed {
    [[CCDirector sharedDirector] popToRootScene];
}

- (void)moveCompleted:(NSMutableDictionary*)game {
   	_game = game;

}



-(void)moveButtonPressed {
    NSLog(@"move button pressed");
    isMoveButtonPressed = true;
}


-(void)shootButtonPressed {
    NSLog(@"Shoot button pressed");
    isShootButtonPressed = true;
}

-(void)meleeButtonPressed {
    NSLog(@"Melee button pressed");
    isMeleeButtonPressed = true;
}


@end
