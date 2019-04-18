//
//  WSCollectionView.m
//  TabScrollView-ObjC
//
//  Created by shoujian on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "WSCollectionView.h"
#import "WSHeaderView.h"
@interface WSCollectionView() <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) CGPoint lastContentOffset;

@end


@implementation WSCollectionView

- (void)setHeaderView:(WSHeaderView *)headerView{
    _headerView = headerView;
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerV"];
    
    [self reloadData];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, self.headerView.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 90) / 3, 130);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerV" forIndexPath:indexPath];
    return view;
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat placeHolderHeight = self.headerView.height - 44;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY >= 0 && offSetY <= placeHolderHeight) {
        if (offSetY > self.lastContentOffset.y) {
            //往上滑动
            if (offSetY > -self.headerView.y) {
                self.headerView.y = -offSetY;
            }
        }else{
            //往下滑动
            if (offSetY < -self.headerView.y) {
                self.headerView.y = -offSetY;
            }
        }
    }else if (offSetY > placeHolderHeight){
        if (self.headerView.y != -placeHolderHeight) {
            if (offSetY > self.lastContentOffset.y) {
                //往上滑动
                self.headerView.y = self.headerView.y - (scrollView.contentOffset.y-self.lastContentOffset.y);
            }
            if (self.headerView.y < -placeHolderHeight) {
                self.headerView.y = -placeHolderHeight;
            }
            if (self.headerView.y >= 0) {
                self.headerView.y = 0;
            }
        }
    }else if (offSetY < 0){
        self.headerView.y = -offSetY;
    }
    self.lastContentOffset = scrollView.contentOffset;
}

@end
