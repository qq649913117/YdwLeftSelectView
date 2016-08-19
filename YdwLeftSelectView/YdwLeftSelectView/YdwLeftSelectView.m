//
//  YdwLeftSelectView.m
//  XiaoKaPai
//
//  Created by ydw on 16/7/23.
//  Copyright © 2016年 ydw. All rights reserved.
//

#import "YdwLeftSelectView.h"
#define  XKScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define  XKScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define SelectBtnHeight 44

@interface YdwLeftSelectView()
/**
 *  侧滑线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 *  当前点击下标
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 *  存放btns
 */
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end
@implementation YdwLeftSelectView

-(void)setUpStatusButtonWithTitlt:(NSArray *)titleArray NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor LineColor:(UIColor *)lineColor
{
    /**
     *  此处判断是为了能让左侧scrollView可以有拉拽效果（bounce = yes）
     *  因为内容尺寸小于scrollView尺寸时拉拽效果无
     */
    if (titleArray.count * SelectBtnHeight > self.frame.size.height) {
        self.bgScrollView.contentSize = CGSizeMake(XKScreenWidth / 3, titleArray.count * SelectBtnHeight);
    }
    else
    {
        self.bgScrollView.contentSize = CGSizeMake(XKScreenWidth / 3, self.frame.size.height+1);
    }
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(1.5, i*SelectBtnHeight, self.frame.size.width-1.5, SelectBtnHeight);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        btn.tag = i+1000;
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btntouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor colorWithRed:0.917 green:0.961 blue:1.000 alpha:1.000];
        }
        [self.buttonArray addObject:btn];
        
    }
    self.currentIndex = 1000;
    self.lineView.frame = CGRectMake(0, 0, 1.5, SelectBtnHeight);
    self.lineView.backgroundColor = lineColor;
}

-(void)changeStateofBtnWithTag:(NSInteger)tag
{
    self.currentIndex = tag;
    //点击后btn的背景颜色变白色
    UIButton *selectBtn = self.buttonArray[tag-1000];
    selectBtn.selected = YES;
    selectBtn.backgroundColor = [UIColor colorWithRed:0.917 green:0.961 blue:1.000 alpha:1.000];
    
    //关闭所有未被点击的btn的select
    for (NSInteger i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex - 1000) {
            UIButton *btn = self.buttonArray[i];
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
    
    //让线条移动
    [UIView animateWithDuration:0 animations:^{
        CGRect lineRect = self.lineView.frame;
        lineRect.origin.y = SelectBtnHeight * (tag-1000);
        self.lineView.frame = lineRect;
    }];
}
-(void)btntouch:(UIButton *)btn
{
    
    if (btn.tag == self.currentIndex) {
        return;
    }
    [self changeStateofBtnWithTag:btn.tag];
    
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(YdwLeftSelect:changeDifferentContentWithTag:)]) {
        [self.delagate YdwLeftSelect:self changeDifferentContentWithTag:btn.tag];
    }
}
#pragma mark - 懒加载
-(UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bgScrollView.backgroundColor = [UIColor lightGrayColor];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.bounces = YES;
        [self addSubview:_bgScrollView];
        
    }
    return _bgScrollView;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self.bgScrollView addSubview:_lineView];
    }
    return _lineView;
}
-(NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end