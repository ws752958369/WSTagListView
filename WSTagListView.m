//
//  WSTagListView.m
//  自定义tagView
//
//  Created by wangsheng on 2018/2/28.
//  Copyright © 2018年 wangsheng. All rights reserved.
//

#import "WSTagListView.h"

@implementation WSTagListView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setTagList:(NSArray *)tagList
{
    _tagList = tagList;
    if (tagList && tagList.count>0) {
        CGFloat marginLeft = 15;
        CGFloat marginTop = 15;
        CGFloat itemHeight = 26;
        CGFloat marginX = 10;
        CGFloat marginY = 10;
        UIButton *markButton = nil;//记录每一个button
        for (int i=0; i<tagList.count; i++) {
            
            NSString *title = [tagList objectAtIndex:i];
            CGFloat itemWidth = [self calculateString:title]+20;
            UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if (!markButton) {
                tagButton.frame = CGRectMake(marginLeft, marginTop, itemWidth, itemHeight);
            }else{
                if (CGRectGetMaxX(markButton.frame)+marginX+itemWidth+marginLeft>self.bounds.size.width) {
                    tagButton.frame = CGRectMake(marginLeft, CGRectGetMaxY(markButton.frame)+marginY, itemWidth, itemHeight);
                }else{
                    tagButton.frame = CGRectMake(CGRectGetMaxX(markButton.frame)+marginX, markButton.frame.origin.y, itemWidth, itemHeight);
                }
            }
            tagButton.backgroundColor = [UIColor grayColor];
            tagButton.titleLabel.font = [UIFont systemFontOfSize:12];
            tagButton.layer.cornerRadius = 13;
            tagButton.layer.masksToBounds = YES;
            tagButton.tag = i;
            [tagButton setTitle:title forState:UIControlStateNormal];
            [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [tagButton addTarget:self action:@selector(tagButtonSeleced:) forControlEvents:UIControlEventTouchUpInside];
            if (self.delegate && [self.delegate respondsToSelector:@selector(WSTagListViewTagTitleFontAtIndex:)]) {
                UIFont *font = [self.delegate WSTagListViewTagTitleFontAtIndex:i];
                [tagButton.titleLabel setFont:font];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(WSTagListViewTagTitleColorAtIndex:)]) {
                UIColor *titleColor = [self.delegate WSTagListViewTagTitleColorAtIndex:i];
                [tagButton setTitleColor:titleColor forState:UIControlStateNormal];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(WSTagListViewTagBackGroundColorAtIndex:)]) {
                UIColor *tagColor = [self.delegate WSTagListViewTagBackGroundColorAtIndex:i];
                tagButton.backgroundColor = tagColor;
            }
            [self addSubview:tagButton];
            
            markButton = tagButton;
        }
        
        CGRect rect = self.frame;
        rect.size.height = markButton.frame.origin.y + markButton.frame.size.height + marginTop;
        self.frame = rect;
    }
}

- (void)tagButtonSeleced:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(WSTagListViewDidSelectedAtIndex:)]) {
        [self.delegate WSTagListViewDidSelectedAtIndex:sender.tag];
    }
}

-(CGFloat)heightOfTagViewForTagList:(NSArray *)tagList
{
    if (tagList && tagList.count>0) {
        CGFloat marginLeft = 15;
        CGFloat marginTop = 15;
        CGFloat itemHeight = 26;
        CGFloat marginX = 10;
        CGFloat marginY = 10;
        UIButton *markButton = nil;//记录每一个button
        for (int i=0; i<self.tagList.count; i++) {
            
            NSString *title = [tagList objectAtIndex:i];
            CGFloat itemWidth = [self calculateString:title]+20;
            UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
            if (!markButton) {
                tagButton.frame = CGRectMake(marginLeft, marginTop, itemWidth, itemHeight);
            }else{
                if (CGRectGetMaxX(markButton.frame)+marginX+itemWidth+marginLeft>self.bounds.size.width) {
                    tagButton.frame = CGRectMake(marginLeft, CGRectGetMaxY(markButton.frame)+marginY, itemWidth, itemHeight);
                }else{
                    tagButton.frame = CGRectMake(CGRectGetMaxX(markButton.frame)+marginX, markButton.frame.origin.y, itemWidth, itemHeight);
                }
            }
            
            markButton = tagButton;
        }
        
        return (markButton.frame.origin.y + markButton.frame.size.height + marginTop);
    }
    return 0;
}

- (CGFloat)calculateString:(NSString *)title
{
    CGFloat width = 0;
     UIFont *defaultFont = [UIFont systemFontOfSize:12];
    if (self.delegate && [self.delegate respondsToSelector:@selector(WSTagListViewTagTitleFontAtIndex:)]) {
        defaultFont = [self.delegate WSTagListViewTagTitleFontAtIndex:0];
    }
    width = [title boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:defaultFont} context:nil].size.width;
    return width;
}

@end
