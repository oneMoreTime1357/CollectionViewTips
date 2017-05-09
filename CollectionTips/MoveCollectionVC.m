//
//  MoveCollectionVC.m
//  CollectionTips
//
//  Created by YangDan on 16/8/13.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import "MoveCollectionVC.h"
#import "MoveCollectionViewCell.h"

static NSString *identity = @"identity";

@interface MoveCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)NSMutableArray *cellAttributesArray;

@property (nonatomic,assign)BOOL isChange;

@end

@implementation MoveCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    for (int i = 1; i <= 10; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [self.data addObject:img];
    }
    
    [self.collectionView reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    cell.img = _data[indexPath.row];
    //为每个cell 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
    
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    MoveCollectionViewCell *cell = (MoveCollectionViewCell *)longPress.view;
    NSIndexPath *cellIndexpath = [_collectionView indexPathForCell:cell];
    
    [_collectionView bringSubviewToFront:cell];
    
    _isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.data.count; i++) {
                [self.cellAttributesArray addObject:[_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            
        }
            
            break;
        
        case UIGestureRecognizerStateChanged: {
            
            cell.center = [longPress locationInView:_collectionView];
            
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSString *imgStr = self.data[cellIndexpath.row];
                    [self.data removeObjectAtIndex:cellIndexpath.row];
                    [self.data insertObject:imgStr atIndex:attributes.indexPath.row];
                    [self.collectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            if (!_isChange) {
                cell.center = [_collectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
        }
            
            break;
            
        default:
            break;
    }
    
}


- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(45, 45);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:identity];
        
    }
    return _collectionView;
}

- (NSMutableArray *)data {
	if(_data == nil) {
		_data = [[NSMutableArray alloc] init];
	}
	return _data;
}

- (NSMutableArray *)cellAttributesArray {
	if(_cellAttributesArray == nil) {
		_cellAttributesArray = [[NSMutableArray alloc] init];
	}
	return _cellAttributesArray;
}

@end
