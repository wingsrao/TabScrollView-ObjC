//
//  WSHeaderView.m
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "WSHeaderView.h"
#import "WSTabControlView.h"

@interface WSHeaderView()

@property (nonatomic,strong) WSTabControlView *tabView;


@end

@implementation WSHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.tabView];
    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(44);
    }];
}

- (WSTabControlView *)tabView{
    if (!_tabView) {
        _tabView = [WSTabControlView new];
        _tabView.backgroundColor = [UIColor lightGrayColor];
        _tabView.items = @[@"table1",@"table2",@"collection",@"webView"];
        __weak typeof(self) weakself = self;
        _tabView.selectTabBlock = ^(NSInteger index) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(headerView:selectIndex:)]) {
                [weakself.delegate headerView:weakself selectIndex:index];
            }
        };
    }
    return _tabView;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    _tabView.selectIndex = selectIndex;
}

@end
