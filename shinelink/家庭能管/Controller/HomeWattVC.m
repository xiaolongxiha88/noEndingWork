//
//  HomeWattVC.m
//  ShinePhone
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "HomeWattVC.h"
#import "StateView.h"
#import "EquipmentView.h"
#import "ChooseEquipmentVC.h"
@interface HomeWattVC ()

@end

@implementation HomeWattVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"瓦特之家";
    self.navigationController.navigationBarHidden =NO;
    [self.navigationController.navigationBar setBarTintColor:MainColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setContentSize:CGSizeMake(kScreenWidth, 2*kScreenHeight)];
    self.view = scrollView;
    self.view.backgroundColor = colorGary;

    [self creatViews];

}
- (void)creatViews{
    //产生电量底图
    UIView *usePowerView = [[UIView alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 105*HEIGHT_SIZE)];
    usePowerView.backgroundColor = [UIColor whiteColor];

    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, usePowerView.xmg_width, 2)];
    topLine.backgroundColor = COLOR(0, 156, 255, 0.5);
    [usePowerView addSubview:topLine];

    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(usePowerView.xmg_centerX-0.5, 28, 1, 59*HEIGHT_SIZE)];
    line.backgroundColor = COLOR(225, 234, 242, 1);
    [usePowerView addSubview:line];


    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 12, 11, 13)];
    headImageView.image = [UIImage imageNamed:@"ele"];

    [usePowerView addSubview:headImageView];

    UIImageView *moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(usePowerView.xmg_width-16, 14, 5, 10)];
    moreImageView.image = [UIImage imageNamed:@"shrink_more"];
    [usePowerView addSubview:moreImageView];

    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.xmg_x+headImageView.xmg_width+10, 11, 93*NOW_SIZE, 14)];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = [UIFont systemFontOfSize:14];
    titleLB.textColor = COLOR(10, 159, 254, 1);
    titleLB.text = @"产生电量(kWh)";
    [usePowerView addSubview:titleLB];

    UILabel *dayEnergyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, usePowerView.xmg_width/2, 17*HEIGHT_SIZE)];
    dayEnergyLB.textAlignment = NSTextAlignmentCenter;
    dayEnergyLB.font = [UIFont systemFontOfSize:22];
    dayEnergyLB.textColor = COLOR(6, 158, 254, 1);
    dayEnergyLB.text = @"203.6";
    [usePowerView addSubview:dayEnergyLB];

    UILabel *dayLB = [[UILabel alloc] initWithFrame:CGRectMake(0, dayEnergyLB.xmg_y+dayEnergyLB.xmg_height+15, usePowerView.xmg_width/2, 13*HEIGHT_SIZE)];
    dayLB.textAlignment = NSTextAlignmentCenter;
    dayLB.font = [UIFont systemFontOfSize:14];
    dayLB.textColor = COLOR(102, 102, 102, 1);
    dayLB.text = @"今日";
    [usePowerView addSubview:dayLB];

    UILabel *monthEnergyLB = [[UILabel alloc] initWithFrame:CGRectMake(usePowerView.xmg_width/2, 38, usePowerView.xmg_width/2, 17*HEIGHT_SIZE)];
    monthEnergyLB.textAlignment = NSTextAlignmentCenter;
    monthEnergyLB.font = [UIFont systemFontOfSize:22];
    monthEnergyLB.textColor = COLOR(6, 158, 254, 1);
    monthEnergyLB.text = @"5403.3";
    [usePowerView addSubview:monthEnergyLB];
    UILabel *monthLB = [[UILabel alloc] initWithFrame:CGRectMake(usePowerView.xmg_width/2, monthEnergyLB.xmg_y+monthEnergyLB.xmg_height+15, usePowerView.xmg_width/2, 13*HEIGHT_SIZE)];
    monthLB.textAlignment = NSTextAlignmentCenter;
    monthLB.font = [UIFont systemFontOfSize:14];
    monthLB.textColor = COLOR(102, 102, 102, 1);
    monthLB.text = @"当月";
    [usePowerView addSubview:monthLB];
    ViewBorderRadius(usePowerView, 5, 0, [UIColor clearColor]);
    [self.view addSubview:usePowerView];
//    StateView *userPowerView = [[StateView alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 105*HEIGHT_SIZE) Image1Str:@"ele" Image2Str:@"shrink_more" TopLineColor:COLOR(0, 156, 255, 0.5) TextColor:COLOR(10, 159, 254, 1) Title:@"产生电量(kWh)" Text1:@"203.6" Text2:@"5403.3"];
//    [self.view addSubview:usePowerView];
    
    StateView *costView = [[StateView alloc] initWithFrame:CGRectMake(15, usePowerView.xmg_y+usePowerView.xmg_height+8, kScreenWidth-30, 105*HEIGHT_SIZE) Image1Str:@"fees" Image2Str:@"shrink_more" TopLineColor:COLOR(226, 175, 0, 0.5) TextColor:COLOR(226, 175, 0, 0.5) Title:@"产生电费(元)" Text1:@"325.6" Text2:@"6553.5"];
    [self.view addSubview:costView];
    
//    UIView *equipmentView = [[UIView alloc] initWithFrame:CGRectMake(15, costView.xmg_y+costView.xmg_height+8, (kScreenWidth-9-30)/2, 80*HEIGHT_SIZE)];
//    equipmentView.backgroundColor = [UIColor whiteColor];
//    ViewBorderRadius(equipmentView, 5, 0, [UIColor clearColor]);
//    UIImageView *equipmentTypeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 20, 40*NOW_SIZE, 39*HEIGHT_SIZE)];
//    equipmentTypeImgView.image = [UIImage imageNamed:@"Charging"];
//    [equipmentView addSubview:equipmentTypeImgView];
//
//    UILabel *equipmentNameLB = [[UILabel alloc] initWithFrame:CGRectMake(equipmentTypeImgView.xmg_x+equipmentTypeImgView.xmg_width+11, 14, 200, 14)];
//    equipmentNameLB.textAlignment = NSTextAlignmentLeft;
//    equipmentNameLB.textColor = COLOR(102, 102, 102, 1);
//    equipmentNameLB.font = [UIFont systemFontOfSize:14];
//    equipmentNameLB.text = @"充电桩";
//    [equipmentView addSubview:equipmentNameLB];
//
//    UILabel *expendLB = [[UILabel alloc] initWithFrame:CGRectMake(equipmentNameLB.xmg_x, equipmentNameLB.xmg_y+equipmentNameLB.xmg_height+13, 200, 24)];
//    expendLB.numberOfLines = 0;
//    expendLB.textAlignment = NSTextAlignmentLeft;
//    expendLB.font = [UIFont systemFontOfSize:10];
//    expendLB.textColor = COLOR(153, 153, 153, 1);
//    expendLB.text = [NSString stringWithFormat:@"日消耗:\n%@kWh",@"361.1"];
//    [equipmentView addSubview:expendLB];
//
//    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(equipmentView.xmg_width-8-7, 7, 7, 7)];
//    statusView.backgroundColor = COLOR(61, 220, 110, 1);
//    ViewBorderRadius(statusView, 3.5, 0, [UIColor clearColor]);
//
//    [equipmentView addSubview:statusView];
//    [self.view addSubview:equipmentView];
    NSArray *nameArr = @[@"充电桩",@"温控器",@"插座",@"ShineBoost",@"空调"];
    NSArray *imageArr = @[@"Charging",@"thermostat",@"socket",@"shineboost",@"air_conditioning"];
    UIView *lastView;
    for (NSInteger i = 0; i<5; i++) {
        EquipmentView *equView = [[EquipmentView alloc] initWithFrame:CGRectMake(15+(kScreenWidth-9-30+15)/2*(i%2), (80*HEIGHT_SIZE+8)*(i/2)+8+costView.xmg_y+costView.xmg_height, (kScreenWidth-9-30)/2, 80*HEIGHT_SIZE) ImageStr:imageArr[i] Name:nameArr[i] Dosage:@"361.1" Status:1];
        lastView = equView;
        [self.view addSubview:equView];

    }
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(lastView.xmg_x+lastView.xmg_width+9, lastView.xmg_y, (kScreenWidth-39)/2, 80*HEIGHT_SIZE);
    addBtn.backgroundColor = COLOR(150, 213, 253, 1);
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    ViewBorderRadius(addBtn, 5, 0, [UIColor clearColor]);
    [addBtn addTarget:self action:@selector(chooseEquipmentClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}
#pragma mark---添加设备
- (void)chooseEquipmentClick{
    ChooseEquipmentVC *chooseVC = [[ChooseEquipmentVC alloc] init];
    [self.navigationController pushViewController:chooseVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
