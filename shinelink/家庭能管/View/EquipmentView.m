//
//  EquipmentView.m
//  ShinePhone
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "EquipmentView.h"
#define useColor COLOR(61, 220, 110, 1)
#define unUseColor COLOR(221, 221, 221, 1)
@implementation EquipmentView

- (instancetype)initWithFrame:(CGRect)frame ImageStr:(NSString *)imageStr Name:(NSString *)name Dosage:(NSString *)dosage Status:(int)status{
//    UIView *equipmentView = [[UIView alloc] initWithFrame:CGRectMake(15, costView.xmg_y+costView.xmg_height+8, (kScreenWidth-9-30)/2, 80*HEIGHT_SIZE)];
    self = [super initWithFrame:frame];

    self.backgroundColor = [UIColor whiteColor];
    ViewBorderRadius(self, 5, 0, [UIColor clearColor]);
    UIImageView *equipmentTypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 20, 40*NOW_SIZE, 39*HEIGHT_SIZE)];
    equipmentTypeImgView.image = [UIImage imageNamed:imageStr];
    [self addSubview:equipmentTypeImgView];
    
    UILabel *equipmentNameLB = [[UILabel alloc] initWithFrame:CGRectMake(equipmentTypeImgView.xmg_x+equipmentTypeImgView.xmg_width+11, 14, 200, 14)];
    equipmentNameLB.textAlignment = NSTextAlignmentLeft;
    equipmentNameLB.textColor = COLOR(102, 102, 102, 1);
    equipmentNameLB.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    equipmentNameLB.text = name;
    [self addSubview:equipmentNameLB];
    
    UILabel *expendLB = [[UILabel alloc] initWithFrame:CGRectMake(equipmentNameLB.xmg_x, equipmentNameLB.xmg_y+equipmentNameLB.xmg_height+13, 200, 24*HEIGHT_SIZE)];
    expendLB.numberOfLines = 0;
    expendLB.textAlignment = NSTextAlignmentLeft;
    expendLB.font = [UIFont systemFontOfSize:10*HEIGHT_SIZE];
    expendLB.textColor = COLOR(153, 153, 153, 1);
    expendLB.text = [NSString stringWithFormat:@"日消耗:\n%@kWh",dosage];
    [self addSubview:expendLB];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(self.xmg_width-8-7, 7, 7, 7)];
    
    statusView.backgroundColor = (status = 0)?unUseColor:useColor;
    ViewBorderRadius(statusView, 3.5, 0, [UIColor clearColor]);
    
    [self addSubview:statusView];
    return self;
}

@end
