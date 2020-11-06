//
//  UICollectionView+Helpers.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Helpers)

- (__kindof UICollectionViewCell *)dequeueCell:(Class)cell forIndexPath:(nonnull NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
