//
//  WSTableView.m
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "WSTableView.h"
#import "WSHeaderView.h"

@interface WSTableView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation WSTableView

- (void)setHeaderView:(WSHeaderView *)headerView{
    _headerView = headerView;
    self.dataSource = self;
    self.delegate = self;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.headerView.height)];
    self.tableHeaderView = tableHeaderView;
    
    [self reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试数据";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
