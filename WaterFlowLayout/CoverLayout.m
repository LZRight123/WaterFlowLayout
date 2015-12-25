//
//  CoverLayout.m
//  WaterFlowLayout
//
//  Created by 梁泽 on 15/12/2.
//  Copyright © 2015年 Right. All rights reserved.
//

#import "CoverLayout.h"

@implementation CoverLayout
- (void) prepareLayout {
//    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width/3, self.collectionView.bounds.size.height*0.5);
    self.sectionInset =  UIEdgeInsetsMake(self.collectionView.bounds.size.height*0.1, 10, 0, 0);
    self.minimumInteritemSpacing = 10;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attrbutes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect ;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size   = self.collectionView.bounds.size;
    CGFloat collectionViewHalfWidth = self.collectionView.frame.size.width*0.5;
    
    [attrbutes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(obj.frame, rect)) {
            CGFloat attributeCenterX = obj.center.x;
            CGFloat distance = CGRectGetMidX(visibleRect) - attributeCenterX ;
            NSLog(@"%f",CGRectGetMidX(visibleRect));
//            NSLog(@"%f",distance);
            //比例 越到中点 越小 接近0  越靠边越大 接近1
            CGFloat biLi = distance/collectionViewHalfWidth;
            if (ABS(distance) < collectionViewHalfWidth) {
                CGFloat zoom = 1 + 0.1*(1-ABS(biLi));
                
                obj.transform3D = CATransform3DMakeScale(1,1*zoom,0.3);
                obj.alpha = 1*zoom;
            }else{
//                obj.alpha = 0;
            }
        }

        
        
    }];
    
    
    return attrbutes;
}
@end
