//
//  WaterFlowLayout.m
//  WaterFlowLayout
//
//  Created by Right on 15/12/1.
//  Copyright © 2015年 Right. All rights reserved.
//

#import "WaterFlowLayout.h"
@interface WaterFlowLayout()
@property (strong, nonatomic) NSMutableDictionary *lastMaxYDic;
@property (strong, nonatomic) NSMutableDictionary *layoutInfoDic;
@end
@implementation WaterFlowLayout
- (void) setupDefaultParameters{
    self.numberOfColumn = 2;
    self.interItemSpacing = 10;
    self.lineSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}
- (instancetype) init {
    if (self = [super init]) {
        [self setupDefaultParameters];
        NSLog(@"init方法");
    }
    return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefaultParameters];
        NSLog(@"initWithCoder方法");
    }
    return self;
}
- (void) prepareLayout {
    self.delegate = (id<WaterFlowLayoutDelegate>)self.collectionView.delegate;
    CGFloat fullWidth      = self.collectionView.frame.size.width;
    CGFloat leftPadding    = self.sectionInset.left;
    CGFloat rightPadding   = self.sectionInset.right;
    CGFloat topPadding     = self.sectionInset.top;
    CGFloat bottomPadding  = self.sectionInset.bottom;
    CGFloat availableWidth = fullWidth - leftPadding - rightPadding - (self.numberOfColumn - 1)*self.interItemSpacing;
    CGFloat itemWidth      = availableWidth/self.numberOfColumn;
    
    _lastMaxYDic   = [NSMutableDictionary dictionary];
    _layoutInfoDic = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    
    NSInteger sectionNum = [self.collectionView numberOfSections];
    for (int section=0; section<sectionNum; section++) {
        NSInteger itemNum = [self.collectionView numberOfItemsInSection:section];
        if (section == 0) {
            CGFloat sectionTopY =  topPadding;
            for (int cloumn=0; cloumn<self.numberOfColumn; cloumn++) {
                _lastMaxYDic[@(cloumn)] = @(sectionTopY);
            }
        }else{
            CGFloat sectionTopY = [self maxYAtLastSection]+ topPadding + bottomPadding;
            for (int cloumn=0; cloumn<self.numberOfColumn; cloumn++) {
                _lastMaxYDic[@(cloumn)] = @(sectionTopY);
            }
        }
        for (int item=0; item<itemNum; item++) {
            NSInteger currentColumn = item%self.numberOfColumn;
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGFloat itemX = leftPadding + (itemWidth+self.interItemSpacing)*currentColumn;
            CGFloat itemY = [_lastMaxYDic[@(currentColumn)] doubleValue];
            CGFloat itemH = [(id<WaterFlowLayoutDelegate>)self.delegate collectionView:self.collectionView layout:self indexPath:indexPath];
            
            UICollectionViewLayoutAttributes *attribut = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attribut.frame =  CGRectMake(itemX, itemY, itemWidth, itemH);
            itemY += itemH;
            itemY += self.lineSpacing;
            _lastMaxYDic[@(currentColumn)] = @(itemY);
            
            _layoutInfoDic[indexPath] = attribut;
        }
    }
    
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributs = [NSMutableArray array];
    [self.layoutInfoDic enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *key,UICollectionViewLayoutAttributes *obj, BOOL * _Nonnull stop) {
        [attributs addObject:obj];
    }];
    return attributs;
}
/// 求现存的最大Y值
- (CGFloat) maxYAtLastSection{
    CGFloat maxHeight = 0;
    CGFloat currentColumn = 0;
    while (currentColumn < self.numberOfColumn) {
        CGFloat height = [self.lastMaxYDic[@(currentColumn)] doubleValue];
        if (height > maxHeight) {
            maxHeight = height;
        }
        currentColumn ++;
    }
    return maxHeight - self.lineSpacing;
}
- (CGSize) collectionViewContentSize {
    CGFloat maxHeight = [self maxYAtLastSection] + self.sectionInset.bottom;
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}
@end
