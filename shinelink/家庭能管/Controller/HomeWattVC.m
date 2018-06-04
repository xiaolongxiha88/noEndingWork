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
    
    StateView *usePowerView = [[StateView alloc] initWithFrame:CGRectMake(15, 8, kScreenWidth-30, 105*HEIGHT_SIZE) Image1Str:@"ele" Image2Str:@"shrink_more" TopLineColor:COLOR(0, 156, 255, 0.5) TextColor:COLOR(10, 159, 254, 1) Title:@"产生电量(kWh)" Text1:@"203.6" Text2:@"5403.3"];
    [self.view addSubview:usePowerView];
    
    StateView *costView = [[StateView alloc] initWithFrame:CGRectMake(15, usePowerView.xmg_y+usePowerView.xmg_height+8, kScreenWidth-30, 105*HEIGHT_SIZE) Image1Str:@"fees" Image2Str:@"shrink_more" TopLineColor:COLOR(226, 175, 0, 0.5) TextColor:COLOR(226, 175, 0, 0.5) Title:@"产生电费(元)" Text1:@"325.6" Text2:@"6553.5"];
    [self.view addSubview:costView];

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
