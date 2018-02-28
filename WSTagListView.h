//
//  WSTagListView.h
//  自定义tagView
//
//  Created by wangsheng on 2018/2/28.
//  Copyright © 2018年 wangsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSTagListViewDelegate <NSObject>

@optional
- (void)WSTagListViewDidSelectedAtIndex:(NSInteger)index;
- (UIFont *)WSTagListViewTagTitleFontAtIndex:(NSInteger)index;
- (UIColor *)WSTagListViewTagTitleColorAtIndex:(NSInteger)index;
- (UIColor *)WSTagListViewTagBackGroundColorAtIndex:(NSInteger)index;
@end

@interface WSTagListView : UIView
@property (nonatomic,strong)NSArray *tagList;
@property (nonatomic,weak)id<WSTagListViewDelegate> delegate;
- (CGFloat)heightOfTagViewForTagList:(NSArray *)tagList;
@end
