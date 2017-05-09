//
//  SectionBackGroundReusableView.m
//  CollectionTips
//
//  Created by YangDan on 16/8/22.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import "SectionBackGroundReusableView.h"

@implementation SectionBackGroundReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor yellowColor];
}


@end
