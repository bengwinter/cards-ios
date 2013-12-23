//
//  BEFRPlayingCardDeck.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRPlayingCardDeck.h"

@implementation BEFRPlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [BEFRPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [BEFRPlayingCard maxRank]; rank++){
                BEFRPlayingCard *card = [[BEFRPlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    
    return self;
}

@end
