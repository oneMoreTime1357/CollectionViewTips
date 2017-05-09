//
//  SectionBackgroudVC.m
//  CollectionTips
//
//  Created by YangDan on 16/8/22.
//  Copyright © 2016年 YangDan. All rights reserved.
//

#import "SectionBackgroudVC.h"
#import "MoveCollectionViewCell.h"
#import "SectionBackgroundFlowLayout.h"
#import "SectionBackGroundReusableView.h"

static NSString *identity = @"identity";

@interface SectionBackgroudVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *data;

@end

@implementation SectionBackgroudVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    for (int i = 1; i <= 10; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [self.data addObject:img];
    }
    
    [self.collectionView reloadData];

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    cell.img = _data[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(15, 15, 15, 15);
}




- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        SectionBackgroundFlowLayout *sectionFlowLayout = [[SectionBackgroundFlowLayout alloc] init];
        sectionFlowLayout.itemSize = CGSizeMake(45, 45);
        sectionFlowLayout.decorationViewOfKinds = @[@"SectionBackGroundReusableView",@"SecondCollectionReusableView"];
        sectionFlowLayout.alternateBackgrounds = YES;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:sectionFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:identity];
        
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)data {
	if(_data == nil) {
		_data = [[NSMutableArray alloc] init];
	}
	return _data;
}

@end
