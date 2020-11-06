//
//  TicTacToeCollectionViewCell.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import "TicTacToeCollectionViewCell.h"

@interface TicTacToeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;

@end

@implementation TicTacToeCollectionViewCell

- (void)configureWithSymbol:(NSString *)symbol {
    self.symbolLabel.text = symbol;
}

@end
