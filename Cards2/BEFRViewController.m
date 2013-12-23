//
//  BEFRViewController.m
//  Cards2
//
//  Created by Blake Ruddock on 12/22/13.
//  Copyright (c) 2013 Blake Ruddock. All rights reserved.
//

#import "BEFRViewController.h"

@interface BEFRViewController ()
@property (strong, nonatomic) BEFRCardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation BEFRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *backgroundImage = [CALayer layer];
    backgroundImage.frame = self.view.bounds;
    backgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]].CGColor;
    [self.view.layer insertSublayer:backgroundImage atIndex:0];
}

- (BEFRDeck*)createDeck
{
    return[[BEFRPlayingCardDeck alloc] init];
}

- (BEFRCardMatchingGame*)game
{
    if (!_game) _game = [[BEFRCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (NSString *)titleForCard:(BEFRCard *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(BEFRCard *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        BEFRCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
}



@end
