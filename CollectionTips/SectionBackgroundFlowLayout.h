//
//  SectionBackgroundFlowLayout.h
//  CollectionTips
//
//  Created by YangDan on 16/8/22.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionBackgroundFlowLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) BOOL alternateBackgrounds;
@property (strong, nonatomic) NSArray *decorationViewOfKinds;


@property (nonatomic,strong) NSMutableArray *itemAttributes;

@end
