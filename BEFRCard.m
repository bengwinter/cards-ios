//
//  BEFRCard.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRCard.h"

@interface BEFRCard()

@end

@implementation BEFRCard

- (int)match:(NSArray*)otherCards
{
    int score = 0;
    for (BEFRCard *card in otherCards) {
        if ([self.contents isEqualToString:card.contents]){
            score = 1;
        }
    }
    return score;
}

@end
