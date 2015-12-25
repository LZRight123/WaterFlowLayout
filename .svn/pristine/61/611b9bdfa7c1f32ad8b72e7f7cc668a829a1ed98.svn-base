//
//  WaterFlowLayout.h
//  WaterFlowLayout
//
//  Created by Right on 15/12/1.
//  Copyright © 2015年 Right. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;
@protocol WaterFlowLayoutDelegate <NSObject>
@optional
- (CGFloat) collectionView:(nonnull UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout indexPath:(nonnull NSIndexPath*)indexPath;
@end
@interface WaterFlowLayout : UICollectionViewLayout//UICollectionViewFlowLayout
@property (weak  , nonatomic) id<WaterFlowLayoutDelegate> delegate;
@property (assign, nonatomic) IBInspectable NSInteger numberOfColumn;
@property (assign, nonatomic) IBInspectable CGFloat interItemSpacing;
@property (assign, nonatomic) IBInspectable CGFloat lineSpacing;
@property (assign, nonatomic) IBInspectable UIEdgeInsets sectionInset;
@end
