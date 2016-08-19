//
//  ViewController.m
//  YdwLeftSelectView
//
//  Created by ydw on 16/8/19.
//  Copyright © 2016年 ydw. All rights reserved.
//

#import "ViewController.h"
#import "YdwLeftSelectView.h"

@interface ViewController ()<YdwLeftSelectViewDelegate>
/**
 *  左侧选项卡
 */
@property (nonatomic, strong)YdwLeftSelectView *ydwLeftSelectV;

@property (nonatomic, strong)UILabel *rightLab;

@property (nonatomic, strong)NSArray *addressArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rightLab];
    [self.view addSubview:self.ydwLeftSelectV];
    
    
}
#pragma mark -- YdwLeftSelectViewDelegate
-(void)YdwLeftSelect:(YdwLeftSelectView *)leftView changeDifferentContentWithTag:(NSInteger)tag
{
    /** 点击相应选项触发的代理 */
    NSLog(@"点击了第%ld个",tag+1 -1000);
    self.rightLab.text = self.addressArr[tag-1000];
}
-(YdwLeftSelectView *)ydwLeftSelectV
{
    if (!_ydwLeftSelectV) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _ydwLeftSelectV = [[YdwLeftSelectView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.height - 20)];
        _ydwLeftSelectV.backgroundColor = [UIColor whiteColor];
        self.addressArr = @[@"上海",@"松江",@"浦东",@"闵行",@"徐汇",@"长宁",@"普陀",@"静安",@"卢湾",@"黄埔",@"闸北",@"虹口",@"杨浦",@"宝山",@"嘉定",@"青浦",@"金山",@"奉贤",@"南汇",@"崇明",@"上海周边"];
        [_ydwLeftSelectV setUpStatusButtonWithTitlt:self.addressArr NormalColor:[UIColor blackColor] SelectedColor:[UIColor orangeColor] LineColor:[UIColor redColor]];
        _ydwLeftSelectV.delagate = self;
    }
    return _ydwLeftSelectV;
}
-(UILabel *)rightLab
{
    if (!_rightLab) {
        _rightLab = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 3 + 100, 250, 80, 30)];
        _rightLab.textAlignment = NSTextAlignmentCenter;
        _rightLab.textColor = [UIColor redColor];
        _rightLab.font = [UIFont boldSystemFontOfSize:20];
        _rightLab.text = @"上海";
    }
    return _rightLab;
}

@end
