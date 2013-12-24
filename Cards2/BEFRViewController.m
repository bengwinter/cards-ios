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
@property (weak, nonatomic) IBOutlet UILabel *matchDescription;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchQuantitySelector;
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

- (IBAction)setNumberMatches:(id)sender {
    NSInteger buttonIndex = self.matchQuantitySelector.selectedSegmentIndex;
    NSInteger numberMatches = (buttonIndex == 0) ? 2 : 3;
    self.game = [[BEFRCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    self.game.numberCardMatch = numberMatches;
    [self updateUI:@"New game dealt"];
}

- (BEFRDeck*)createDeck
{
    return[[BEFRPlayingCardDeck alloc] init];
}

- (BEFRCardMatchingGame*)game
{
    if (!_game){
        _game = [[BEFRCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.numberCardMatch = 2;
    }
    return _game;
}

- (NSString *)titleForCard:(BEFRCard *)card
{
    return (card.isChosen || card.isMatched) ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(BEFRCard *)card
{
    return [UIImage imageNamed:(card.isChosen || card.isMatched) ? @"cardfront" : @"cardback"];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    NSString *updateMessage = [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI:updateMessage];
}

- (void)updateUI:(NSString*)message {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        BEFRCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    self.matchDescription.text = message;
}

- (IBAction)resetGame {
    UIAlertView *confirmClearAlert = [[UIAlertView alloc] initWithTitle:@"Reset Game"
                                                                message:@"Are you sure you want to reset your game?"
                                                               delegate:self
                                                      cancelButtonTitle:@"Nevermind"
                                                        otherButtonTitles:@"I'm sure", nil];
    [confirmClearAlert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.game = [[BEFRCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        [self updateUI:@"New game dealt"];
    }
}



@end
