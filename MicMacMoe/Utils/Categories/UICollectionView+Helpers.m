//
//  UICollectionView+Helpers.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import "UICollectionView+Helpers.h"

@implementation UICollectionView (Helpers)

- (__kindof UICollectionViewCell *)dequeueCell:(Class)cell forIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(cell);
    return [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
