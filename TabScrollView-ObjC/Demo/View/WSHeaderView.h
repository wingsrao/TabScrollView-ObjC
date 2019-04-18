//
//  WSHeaderView.h
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSHeaderView;

@protocol WSHeaderViewDelegate <NSObject>

@required

- (void)headerView:(WSHeaderView *)headerView selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WSHeaderView : UIView

@property (nonatomic,weak) id<WSHeaderViewDelegate> delegate;
@property (nonatomic,assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
