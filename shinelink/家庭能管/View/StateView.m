//
//  StateView.m
//  ShinePhone
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "StateView.h"

@implementation StateView

- (instancetype)initWithFrame:(CGRect)frame Image1Str:(NSString *)image1Str Image2Str:(NSString *)image2Str TopLineColor:(UIColor *)linecolor TextColor:(UIColor *)color Title:(NSString *)title Text1:(NSString *)text1 Text2:(NSString *)text2{
//    StateView *usePowerView = [[UIView alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 105*HEIGHT_SIZE)];
    self = [super initWithFrame:frame];

    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.xmg_width, 2)];
    topLine.backgroundColor = linecolor;
    [self addSubview:topLine];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(self.xmg_width/2-0.5, 28, 1, 59*HEIGHT_SIZE)];
    line.backgroundColor = COLOR(225, 234, 242, 1);
    [self addSubview:line];
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 11, 13)];
    headImageView.image = [UIImage imageNamed:image1Str];
    
    [self addSubview:headImageView];
    
    UIImageView *moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.xmg_width-16, 14, 5, 10)];
    moreImageView.image = [UIImage imageNamed:image2Str];
    [self addSubview:moreImageView];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.xmg_x+headImageView.xmg_width+10, 11, 100*NOW_SIZE, 14)];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    titleLB.textColor = color;
    titleLB.text = title;
    [self addSubview:titleLB];
    
    UILabel *dayEnergyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, self.xmg_width/2, 17*HEIGHT_SIZE)];
    dayEnergyLB.textAlignment = NSTextAlignmentCenter;
    dayEnergyLB.font = [UIFont systemFontOfSize:22*HEIGHT_SIZE];
//    dayEnergyLB.textColor = COLOR(6, 158, 254, 1);
    dayEnergyLB.textColor = color;

    dayEnergyLB.text = text1;
    [self addSubview:dayEnergyLB];
    
    UILabel *dayLB = [[UILabel alloc] initWithFrame:CGRectMake(0, dayEnergyLB.xmg_y+dayEnergyLB.xmg_height+15, self.xmg_width/2, 13*HEIGHT_SIZE)];
    dayLB.textAlignment = NSTextAlignmentCenter;
    dayLB.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    dayLB.textColor = COLOR(102, 102, 102, 1);
    dayLB.text = @"今日";
    [self addSubview:dayLB];
    
    UILabel *monthEnergyLB = [[UILabel alloc] initWithFrame:CGRectMake(self.xmg_width/2, 38, self.xmg_width/2, 17*HEIGHT_SIZE)];
    monthEnergyLB.textAlignment = NSTextAlignmentCenter;
    monthEnergyLB.font = [UIFont systemFontOfSize:22*HEIGHT_SIZE];
//    monthEnergyLB.textColor = COLOR(6, 158, 254, 1);
    monthEnergyLB.textColor = color;
    monthEnergyLB.text = text2;
    [self addSubview:monthEnergyLB];
    UILabel *monthLB = [[UILabel alloc] initWithFrame:CGRectMake(self.xmg_width/2, monthEnergyLB.xmg_y+monthEnergyLB.xmg_height+15, self.xmg_width/2, 13*HEIGHT_SIZE)];
    monthLB.textAlignment = NSTextAlignmentCenter;
    monthLB.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    monthLB.textColor = COLOR(102, 102, 102, 1);
    monthLB.text = @"当月";
    [self addSubview:monthLB];
    ViewBorderRadius(self, 5, 0, [UIColor clearColor]);
    return self;
}

@end
