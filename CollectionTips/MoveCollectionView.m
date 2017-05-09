//
//  ViewController.m
//  CollectionTips
//
//  Created by YangDan on 16/8/13.
//  Copyright © 2016年 YangDan. All rights reserved.
//

/**
 *  iOS9 新特性，可以拖拽collectionView 只要实现 相应的dataSource 方法
 */


#import "MoveCollectionView.h"
#import "MoveCollectionViewCell.h"

static NSString *identity = @"moveCellIdentity";

@interface MoveCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation MoveCollectionView

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
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    cell.img = _data[indexPath.row];
    return cell;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return NO;
    }
    return YES;
}

//当移动结束的时候会调用这个方法。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    
    [_data removeObjectAtIndex:sourceIndexPath.row];
    
    UIImage *img = _data[sourceIndexPath.row];
    
    [_data insertObject:img atIndex:destinationIndexPath.row];
    
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            
            if (!indexPath) {
                break;
            }
            
            BOOL canMove = [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            if (!canMove) {
                break;
            }
            break;
        
        case UIGestureRecognizerStateChanged:
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
            
        case UIGestureRecognizerStateEnded:
            [_collectionView endInteractiveMovement];
            break;
            
        default:
            [_collectionView cancelInteractiveMovement];
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
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPressGesture];
        
    }
	return _collectionView;
}

- (NSMutableArray *)data {
	if(_data == nil) {
		_data = [[NSMutableArray alloc] init];
	}
	return _data;
}

@end
