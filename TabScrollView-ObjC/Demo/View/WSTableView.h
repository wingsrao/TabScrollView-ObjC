//
//  WSTableView.h
//  TabScrollView-ObjC
//
//  Created by zhl on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSHeaderView;
NS_ASSUME_NONNULL_BEGIN

@interface WSTableView : UITableView 
@property (nonatomic,strong) WSHeaderView *headerView;
@end

NS_ASSUME_NONNULL_END
