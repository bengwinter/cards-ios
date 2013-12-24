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

- (NSString *)chooseCardAtIndex:(NSUInteger)index
{
    NSString *response = @"";
    if (self.numberCardMatch == 2) {
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
                            int reward = matchScore * MATCH_BONUS;
                            self.score += reward;
                            otherCard.matched = YES;
                            card.matched = YES;
                            response = [NSString stringWithFormat:@"Matched %@ with %@ for %d points", card.contents, otherCard.contents, reward];
                            break;
                        } else {
                            response = [NSString stringWithFormat:@"No match for %@ with %@. %d points deducted", card.contents, otherCard.contents, MISMATCH_PENALTY];
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
    } else {
        BEFRCard *card = [self.cards objectAtIndex:index];
        NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
        for (BEFRCard *card in self.cards) {
            if (card.isChosen) {
                [selectedCards addObject:card];
            }
        }
        NSLog(@"Card chosen: %@", card.contents);
        NSLog(@"# Selected Cards: %lu", [selectedCards count]);
//        begin the real logic here
        if (!card.isMatched) {
            if (card.isChosen) {
                NSLog(@"Chose a card that was already chosen: %@", card.contents);
                card.chosen = NO;
            } else {
                if (([selectedCards count] + 1) == self.numberCardMatch) {
                    int matchScore = [card match:selectedCards];
                    if (matchScore) {
                        int reward = matchScore * MATCH_BONUS;
                        self.score += reward;
                        for (BEFRPlayingCard *card in selectedCards) {
                            card.matched = YES;
                            card.chosen = NO;
                        }
                        card.matched = YES;
                        response = [NSString stringWithFormat:@"Matched these cards for %d points", reward];
                    } else {
                        for (BEFRPlayingCard *card in selectedCards) {
                            card.chosen = NO;
                        }
                        card.chosen = NO;
                        response = [NSString stringWithFormat:@"No match for these cards. %d points deducted", MISMATCH_PENALTY];
                    }
                } else {
                    card.chosen = YES;
                }
            }
        }
        NSLog(@"");
    }
    return response;
}

@end
