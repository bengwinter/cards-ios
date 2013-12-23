//
//  BEFRDeck.h
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BEFRCard.h"

@interface BEFRDeck : NSObject

- (void)addCard:(BEFRCard *)card atTop:(BOOL)atTop;
- (void)addCard:(BEFRCard *)card;
- (BEFRCard*)drawRandomCard;

@end
