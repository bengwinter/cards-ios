//
//  BEFRDeck.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRDeck.h"


// create a private local mutable array of cards for each instance of Deck class
@interface BEFRDeck()
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation BEFRDeck

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(BEFRCard*)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(BEFRCard *)card
{
    [self.cards addObject:card];
}

- (BEFRCard*)drawRandomCard
{
    BEFRCard *randomCard = nil;
    if ([self.cards count]) {
        int index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}


@end
