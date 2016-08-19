//
//  YdwLeftSelectView.h
//  XiaoKaPai
//
//  Created by ydw on 16/7/23.
//  Copyright © 2016年 ydw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YdwLeftSelectView;
/**
 *  点击左侧选项卡btn展示不同内容（代理）
 */
@protocol YdwLeftSelectViewDelegate <NSObject>
/**
 *  代理
 */
-(void)YdwLeftSelect:(YdwLeftSelectView *)leftView changeDifferentContentWithTag:(NSInteger)tag;

@end

@interface YdwLeftSelectView : UIView
/**
 *  装选项卡的容器scrollView
 */
@property (nonatomic, strong) UIScrollView *bgScrollView;
/**
 *  代理
 */
@property (nonatomic, weak) id<YdwLeftSelectViewDelegate> delagate;

-(void)setUpStatusButtonWithTitlt:(NSArray *)titleArray NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor LineColor:(UIColor *)lineColor;

@end
