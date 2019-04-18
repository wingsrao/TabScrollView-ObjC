//
//  MainVC.m
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "MainVC.h"
#import "WSHeaderView.h"
#import "WSTableView.h"
#import "WSCollectionView.h"
#import "WSWebView.h"

#define tabCount  4
#define kHeadViewHeight    200

@interface MainVC ()<UIScrollViewDelegate,WSHeaderViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) WSHeaderView *headerView;
@property (nonatomic,strong) WSTableView *tableView1;
@property (nonatomic,strong) WSTableView *tableView2;
@property (nonatomic,strong) WSTableView *tableView3;
@property (nonatomic,strong) WSCollectionView *collectionView;
@property (nonatomic,strong) WSWebView *webView;
@property (nonatomic, assign) CGPoint lastContentOffset;
@end

@implementation MainVC

#pragma mark -----   life cycle method 生命周期（包含类方法等初始化）
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Demo";
    
    //处理导航栏透明不透明的情况
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    
}
#pragma mark - init UI
- (void)initUI{
    [self.view addSubview:self.scrollView]; //scrollView容器
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.scrollView addSubview:self.collectionView];
    [self.scrollView addSubview:self.webView];
    [self.scrollView addSubview:self.headerView];//放在最顶层，覆盖offset的y值
}

#pragma mark - event response  事件响应


#pragma mark - delegate 代理方法
//WSHeaderViewDelegate
- (void)headerView:(WSHeaderView *)headerView selectIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * index, 0) animated:YES];
}
//ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        self.headerView.x = scrollView.contentOffset.x;
        int index = 0;
        if (self.lastContentOffset.x < scrollView.contentOffset.x){
            //往右滑动，向上取整
            index = ceil((scrollView.contentOffset.x/ScreenWidth));
        }else if (self.lastContentOffset.x > scrollView.contentOffset.x){
            //往左滑动，向下取整
            index = floor((scrollView.contentOffset.x/ScreenWidth));
        }else{
            //没动
            index = (scrollView.contentOffset.x/ScreenWidth);
        }
        CGFloat mobileDistance = (0-self.headerView.y);
        switch (index) {
            case 0:{
                //修改tableView1
                if (self.tableView1.contentOffset.y<mobileDistance){
                    [self.tableView1 setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 1:{
                //修改tableView2
                if (self.tableView2.contentOffset.y<mobileDistance){
                    [self.tableView2 setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 2:{
                //修改collectionView
                if (self.collectionView.contentOffset.y<mobileDistance){
                    [self.collectionView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 3:{
                //修改webView
                if (self.webView.scrollView.contentOffset.y<mobileDistance){
                    [self.webView.scrollView setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            default:
                break;
        }
        self.lastContentOffset = scrollView.contentOffset;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    static int lastIndex = 0;
    int index = 0;
    if (self.lastContentOffset.x < scrollView.contentOffset.x) {
        //往右滑动，向上取整
        index = ceil((scrollView.contentOffset.x/ScreenWidth));
    }else if (self.lastContentOffset.x > scrollView.contentOffset.x){
        //往左滑动，向下取整
        index = floor((scrollView.contentOffset.x/ScreenWidth));
    }else{
        //没动
        index = (scrollView.contentOffset.x/ScreenWidth);
    }
    //    if (lastIndex != index) {  //让headerView重新设置选中的item
    self.headerView.selectIndex = index;
    //    }
    lastIndex = index;
}
#pragma mark - request 请求方法


#pragma mark - private method  私有事件


#pragma mark  - getter or  setter
- (WSHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[WSHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kHeadViewHeight)];
        _headerView.backgroundColor = [UIColor grayColor];
        _headerView.delegate = self;
    }
    return _headerView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWidth * tabCount, 0);
    }
    return _scrollView;
}


- (UITableView *)tableView1{
    if (!_tableView1) {
        _tableView1 = [[WSTableView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, self.scrollView.height)];
        _tableView1.backgroundColor = [UIColor redColor];
        _tableView1.showsHorizontalScrollIndicator = NO;
        _tableView1.showsVerticalScrollIndicator = NO;
        _tableView1.headerView = self.headerView;
    }
    return _tableView1;
}
- (UITableView *)tableView2{
    if (!_tableView2) {
        _tableView2 = [[WSTableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0,ScreenWidth, self.scrollView.height)];
        _tableView2.backgroundColor = [UIColor greenColor];
        _tableView2.showsHorizontalScrollIndicator = NO;
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.headerView = self.headerView;
    }
    return _tableView2;
}

- (WSCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
        shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[WSCollectionView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0,ScreenWidth, self.scrollView.height) collectionViewLayout:shareflowLayout];
        _collectionView.headerView = self.headerView;
    }
    return _collectionView;
}

- (WSWebView *)webView{
    if (!_webView) {
        _webView = [[WSWebView alloc]initWithFrame:CGRectMake(ScreenWidth*3, 0, ScreenWidth, self.scrollView.height)];
        _webView.headerView = self.headerView;
    }
    return _webView;
}

@end
