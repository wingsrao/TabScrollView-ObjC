//
//  WSWebView.m
//  TabScrollView-ObjC
//
//  Created by shoujian on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "WSWebView.h"
#import "WSHeaderView.h"

@interface WSWebView()<UIWebViewDelegate>
@property (nonatomic, assign) CGPoint lastContentOffset;
@end
@implementation WSWebView

- (void)setHeaderView:(WSHeaderView *)headerView{
    _headerView = headerView;
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://baidu.com"]]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",title);
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
