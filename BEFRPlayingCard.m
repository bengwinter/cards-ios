//
//  BEFRPlayingCard.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRPlayingCard.h"

@implementation BEFRPlayingCard

+ (NSArray*)validSuits
{
    return @[@"♥", @"♠", @"♦", @"♣"];
}

+ (NSArray*)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


// overriding setters and getters for suit property; must synthesize as a result

@synthesize suit = _suit;

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[BEFRPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// using maxRank as a check paramters for the custom rank setter method
+ (NSUInteger)maxRank
{
    return [[BEFRPlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [BEFRPlayingCard maxRank]){
        _rank = rank;
    }
}

- (int)match:(NSArray*)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        BEFRPlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    }
    return score;
}

- (NSString*)contents
{
    return [[[BEFRPlayingCard rankStrings] objectAtIndex:self.rank] stringByAppendingString:self.suit];
}



@end



