//
//  homeDeviceViewController.m
//  shinelink
//
//  Created by sky on 16/3/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "homeDeviceViewController.h"
#import "newLine.h"
@interface homeDeviceViewController ()
@property (nonatomic, strong) newLine *line2View;
@end

@implementation homeDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //  self.title = _titleString;
    self.title = [NSString stringWithFormat:@"%@(Demo)",_titleString];
    
    self.line2View = [[newLine alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,280*HEIGHT_SIZE )];
    [self.view addSubview:self.line2View];
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
    
    //NSString *newStr = [_MinString stringByReplacingOccurrencesOfString:@"kWh" withString:@""];
    [dict setObject:@"10" forKey:root_energy_dianbinxiang];
    [dict setObject:@"21" forKey:root_energy_weibolu];
    [dict setObject:@"25" forKey:root_energy_xiyiji];
    [dict setObject:@"100" forKey:root_energy_kongtiao];
    [dict setObject:@"22" forKey:root_energy_reshuiqi];
    [dict setObject:@"81" forKey:root_energy_weibolu];
    
    [self.line2View showPieChartWithDataDict:dict];
    
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
