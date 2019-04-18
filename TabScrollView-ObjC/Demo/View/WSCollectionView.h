//
//  WSCollectionView.h
//  TabScrollView-ObjC
//
//  Created by shoujian on 2019/4/18.
//  Copyright © 2019 wings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSHeaderView.h"
@class WSHeaderView;
NS_ASSUME_NONNULL_BEGIN

@interface WSCollectionView : UICollectionView
@property (nonatomic,strong) WSHeaderView *headerView;
@end

NS_ASSUME_NONNULL_END
