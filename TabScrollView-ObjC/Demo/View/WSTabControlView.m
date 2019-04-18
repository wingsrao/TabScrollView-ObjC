//
//  WSTabControlView.m
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import "WSTabControlView.h"

@interface WSTabControlView()

@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) NSMutableArray *itemArray;

@end

@implementation WSTabControlView


-(void)itemClick:(UIButton *)item{
    static UIButton *last = nil;
    if (last != item) {
        [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(100);
            make.centerX.mas_equalTo(item.mas_centerX);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
        
        if (_selectTabBlock) {
            _selectTabBlock(item.tag);
        }
    }
    last = item;
}

#pragma mark - getter & setter

- (void)setItems:(NSArray *)items{
    _items = items;
    CGFloat w = ScreenWidth/(items.count*1.0);
    CGFloat h = 44;
    UIButton *last = nil;
    for (int i = 0; i < items.count; i ++) {
        UIButton *btn = [UIButton new];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:items[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [self addSubview:btn];
        [self.itemArray addObject:btn];
        
        [btn addTarget:self action:@selector(itemClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
            make.centerY.mas_equalTo(self);
            if (last) {
                make.left.mas_equalTo(last.mas_right);
            }else{
                make.left.mas_offset(0);
            }
        }];
        if (i==0) {
            [self addSubview:self.indicatorView];
            [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(0);
                make.height.mas_equalTo(2);
                make.width.mas_equalTo(ScreenWidth/items.count);
                make.centerX.mas_equalTo(btn.mas_centerX);
            }];
        }
        last = btn;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    UIButton *item = [_itemArray objectAtIndex:selectIndex];
    if (item) {
        [self itemClick:item];
    }else{
        [self itemClick:_itemArray.firstObject];
    }
}


- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [UIView new];
        _indicatorView.backgroundColor = [UIColor blueColor];
    }
    return _indicatorView;
}

- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray new];
    }
    return _itemArray;
}

@end
