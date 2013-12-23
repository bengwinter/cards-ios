//
//  BEFRCardMatchingGame.h
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEFRPlayingCardDeck.h"

@interface BEFRCardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(BEFRDeck*)deck;
- (BEFRCard *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;

@end
