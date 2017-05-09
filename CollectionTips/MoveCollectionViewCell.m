//
//  MoveCollectionViewCell.m
//  CollectionTips
//
//  Created by YangDan on 16/8/14.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import "MoveCollectionViewCell.h"

@implementation MoveCollectionViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self.contentView addSubview:self.imgView];
        
        self.imgView.autoresizesSubviews = YES;
        self.imgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
        
        self.imgView.autoresizesSubviews = YES;
        self.imgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    }
    return self;
}


- (void)setImg:(UIImage *)img {
    _img  = img;
    
    self.imgView.image = img;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        _imgView.backgroundColor = [UIColor yellowColor];
    }
    return _imgView;
}

@end
