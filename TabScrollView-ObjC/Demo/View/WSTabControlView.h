//
//  WSTabControlView.h
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSTabControlView : UIView

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic, copy) void (^selectTabBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
