//
//  SectionBackgroundFlowLayout.m
//  CollectionTips
//
//  Created by YangDan on 16/8/22.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import "SectionBackgroundFlowLayout.h"

@interface SectionBackgroundFlowLayout ()

@property (nonatomic,assign) BOOL insetForSectionAtIndexFlag;

@end

@implementation SectionBackgroundFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    //判断collectionview 组的视图是否对边界有设置，监听设置组的边界的协议方法。
    self.insetForSectionAtIndexFlag = [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)];
    
    self.itemAttributes = [NSMutableArray new];
    
    //组中有多少视图
    NSInteger numberOfSection = self.collectionView.numberOfSections;
    
    for (int section=0; section<numberOfSection; section++)
    {
        if (!self.alternateBackgrounds && section >= self.decorationViewOfKinds.count)
            break;
        
        NSString *decorationViewOfKind = self.decorationViewOfKinds[section ];
        if ([decorationViewOfKind isKindOfClass:[NSNull class]])
            continue;
        
        //组的背景视图 frame
        NSInteger lastIndex = [self.collectionView numberOfItemsInSection:section] - 1;
        if (lastIndex < 0)
            continue;
        
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:lastIndex inSection:section]];
        
        //如果设置了 collectionview 组的 边界 margin ，获取它的sectionInset， 根据这个margin计算frame
        UIEdgeInsets sectionInset = _insetForSectionAtIndexFlag ? [((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate) collectionView:self.collectionView layout:self insetForSectionAtIndex:section] : self.sectionInset;
        
        CGRect frame = CGRectUnion(firstItem.frame, lastItem.frame);
        frame.origin.x -= sectionInset.left;
        frame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
        {//水平滚动
            frame.size.width += sectionInset.left + sectionInset.right;
            frame.size.height = self.collectionView.frame.size.height;
        }
        else
        {
            frame.size.width = self.collectionView.frame.size.width;
            frame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewOfKind withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        attributes.zIndex = -1;
        attributes.frame = frame;
        [self.itemAttributes addObject:attributes];
        
        
        [self registerClass:NSClassFromString(decorationViewOfKind) forDecorationViewOfKind:decorationViewOfKind];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    for (UICollectionViewLayoutAttributes *attribute in self.itemAttributes)
    {
        if (!CGRectIntersectsRect(rect, attribute.frame))
            continue;
        [attributes addObject:attribute];
    }
    return attributes;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //和之前的frame 比较，如果不相同则重新计算，否则返回NO
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetHeight(oldBounds) != CGRectGetHeight(newBounds)) {
        return YES;
    }
    
    return NO;
}



@end
