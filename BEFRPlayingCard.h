//
//  BEFRPlayingCard.h
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRCard.h"

@interface BEFRPlayingCard : BEFRCard

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
- (NSString*)contents;

+ (NSArray*)validSuits;
+ (NSUInteger)maxRank;

@end
