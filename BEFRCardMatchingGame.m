//
//  BEFRCardMatchingGame.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRCardMatchingGame.h"

@interface BEFRCardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation BEFRCardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(BEFRDeck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++){
            BEFRCard *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (BEFRCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? [self.cards objectAtIndex:index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    BEFRCard *card = [self.cards objectAtIndex:index];
    
    if (!card.isMatched){
        if (card.isChosen){
            NSLog(@"Chose a card that was already chosen: %@", card.contents);
            card.chosen = NO;
        } else {
            for (BEFRCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched && (otherCard != card)) {
                    NSLog(@"Iterating through cards.  Current card is %@", otherCard.contents);
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        NSLog(@"Match created! Card is: %@, Other card is: %@", card.contents, otherCard.contents);
                        break;
                    } else {
                        otherCard.chosen = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                } else {
                    otherCard.chosen = NO;
                    card.chosen = YES;
                }
            }
        }
    }
}

@end
