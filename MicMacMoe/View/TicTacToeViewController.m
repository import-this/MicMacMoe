//
//  TicTacToeViewController.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 29/10/20.
//

#import "TicTacToeViewController.h"
#import "TicTacToeCollectionViewCell.h"
#import "UICollectionView+Helpers.h"
#import "CALayer+Shadow.h"
#import "CALayer+Border.h"
#import "TicTacToeGame.h"

@interface TicTacToeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *difficultyButton;
@property (weak, nonatomic) IBOutlet UIView *xContainerView;
@property (weak, nonatomic) IBOutlet UIView *oContainerView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabelX;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabelO;
@property (weak, nonatomic) IBOutlet UICollectionView *boardCollectionView;

@property (nonatomic, strong) TicTacToeGame* game;

@end

// MARK: - TicTacToeViewController Implementation
@implementation TicTacToeViewController

static uint boardSize = 3;

// MARK: - Colors
+ (UIColor *)colorSelected {
    return [UIColor colorWithRed:0 green:0.76 blue:0.71 alpha:1];
}

+ (UIColor *)colorUnselected {
    return UIColor.blackColor;
}

// MARK: - Helpers
- (void)setupUI {
    // Game starts with Player X.
    [self.xContainerView.layer shadowWithColor:self.class.colorSelected opacity:1];
    [self.oContainerView.layer shadowWithColor:self.class.colorUnselected];
}

- (void)updateCellAt:(NSInteger)index withSymbol:(NSString *)symbol {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    TicTacToeCollectionViewCell* const cell = (TicTacToeCollectionViewCell *)
        [self.boardCollectionView cellForItemAtIndexPath:indexPath];
    [cell configureWithSymbol:symbol];
}

- (void)updateCellAt:(NSInteger)index forPlayer:(Player)player {
    [self updateCellAt:index withSymbol:(player == PlayerX) ? @"X" : @"O"];
}

- (void)clearTable {
    NSInteger count = [self.boardCollectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; ++i) {
        [self updateCellAt:i withSymbol:@""];
    }
}

- (void)updateScores {
    self.scoreLabelX.text = @(self.game.score.x).stringValue;
    self.scoreLabelO.text = @(self.game.score.o).stringValue;
}

// MARK: - Game methods
- (void)makeFirstMove {
    Move *aiMove = [self.game gambit];
    [self updateCellAt:(aiMove.i*boardSize + aiMove.j) forPlayer:!self.game.player];
}

- (void)restartGame {
    [self.game restart];
    [self clearTable];
}

- (void)setDifficulty:(Difficulty)level {
    self.game.difficulty = level;

    NSString *levelStrings[] = {@"Easy", @"Medium", @"Impossible"};
    [self.difficultyButton setTitle:levelStrings[level] forState:UIControlStateNormal];
    [self clearTable];
}

- (void)changeDifficulty {
    Difficulty levels[] = {Easy, Medium, Impossible};
    Difficulty level = self.game.difficulty;
    Difficulty nextLevel = (level + 1) % (sizeof(levels) / sizeof(levels[0]));
    [self setDifficulty:nextLevel];
    [self selectPlayerX];
}

- (void)selectPlayerX {
    if (self.game.player == PlayerX) { return; }
    self.game.player = PlayerX;
    [self.xContainerView.layer shadowWithColor:self.class.colorSelected opacity:1];
    [self.oContainerView.layer shadowWithColor:self.class.colorUnselected];
    [self clearTable];
    // 'X' plays first, so wait for human to move.
}

- (void)selectPlayerO {
    if (self.game.player == PlayerO) { return; }
    self.game.player = PlayerO;
    [self.xContainerView.layer shadowWithColor:self.class.colorUnselected];
    [self.oContainerView.layer shadowWithColor:self.class.colorSelected opacity:1];
    [self clearTable];
    // 'X' plays first, so AI will make the first move.
    [self makeFirstMove];
}

- (void)playedAtIndex:(NSInteger)index {
    if (self.game.isOver) {
        [self restartGame];
        return;
    }

    const NSInteger i = index / boardSize;
    const NSInteger j = index % boardSize;
    Move *move = [Move i:i j:j];

    if (![self.game isEmptyAtPos:move]) {   // Illegal move (taken square).
        return;
    }

    [self updateCellAt:index forPlayer:self.game.player];
    Move *aiMove = [self.game playMove:move];
    if (aiMove == nil) {                    // Game over (No more squares or win/loss).
        [self updateScores];
        return;
    }
    [self updateCellAt:(aiMove.i*boardSize + aiMove.j) forPlayer:!self.game.player];
    if (self.game.isOver) {                 // AI move filled the board (may have won).
        [self updateScores];
        return;
    }
}

// MARK: - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    [self.boardCollectionView setDataSource:self];
    [self.boardCollectionView setDelegate:self];

    Difficulty level = Medium;
    self.game = [[TicTacToeGame alloc] initForPlayer:PlayerX atDifficulty:level boardSize:boardSize];
    [self selectPlayerX];
    [self setDifficulty:level];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat size = self.boardCollectionView.frame.size.width / boardSize;
    UICollectionViewFlowLayout *layout =
        (UICollectionViewFlowLayout *) self.boardCollectionView.collectionViewLayout;

    layout.itemSize = CGSizeMake(size, size);   // Square tiles.
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
}

// MARK: - Actions
- (IBAction)didPressDifficultyButton:(UIButton *)sender {
    [self changeDifficulty];
}

- (IBAction)selectPlayerX:(UIButton *)sender {
    [self selectPlayerX];
}

- (IBAction)selectPlayerO:(UIButton *)sender {
    [self selectPlayerO];
}

- (IBAction)restartGame:(UIButton *)sender {
    [self restartGame];
}

// MARK: - UICollectionViewDataSource Conformance
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return boardSize * boardSize;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TicTacToeCollectionViewCell* cell = [collectionView dequeueCell:[TicTacToeCollectionViewCell class] forIndexPath:indexPath];
    [cell.layer borderWithColor:[UIColor.blackColor colorWithAlphaComponent:0.25] width:5];
    [cell configureWithSymbol:@""];
    return cell;
}

// MARK: - UICollectionViewDelegate Conformance
- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self playedAtIndex:indexPath.row];
}

@end
