//
//  ChooseEquipmentVC.m
//  ShinePhone
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "ChooseEquipmentVC.h"
#import "ChooseButton.h"
@interface ChooseEquipmentVC ()

@end

@implementation ChooseEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择设备";
    self.view.backgroundColor = colorGary;
    [self creatViews];
}
- (void)creatViews{
    NSArray *nameArr = @[@"充电桩",@"温控器",@"插座",@"ShineBoost",@"空调"];
    NSArray *imageArr = @[@"Charging",@"thermostat",@"socket",@"shineboost",@"air_conditioning"];
    for (NSInteger i = 0; i <5; i++) {
        ChooseButton *button = [[ChooseButton alloc] initWithFrame:CGRectMake(15+(kScreenWidth-9-30+15)/2*(i%2), (80*HEIGHT_SIZE+8)*(i/2)+8, (kScreenWidth-9-30)/2, 80*HEIGHT_SIZE) Title:nameArr[i] withImage:imageArr[i]];
        [self.view addSubview:button];
    }
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
