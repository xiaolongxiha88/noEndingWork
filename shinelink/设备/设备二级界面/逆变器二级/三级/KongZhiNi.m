//
//  KongZhiNi.m
//  shinelink
//
//  Created by sky on 16/3/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "KongZhiNi.h"
#import "ASValueTrackingSlider.h"
@interface KongZhiNi ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) ASValueTrackingSlider *slider;
@property (nonatomic, strong) ASValueTrackingSlider *slider1;
@property (nonatomic, strong) ASValueTrackingSlider *slider2;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *paramId;
@property (nonatomic, strong) NSString *commandValue;
@property (nonatomic, strong) NSString *commandValue1;
@property (nonatomic, strong) UIAlertView *Alert1;
@property (nonatomic, strong) UIAlertView *Alert2;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)UITextField *textField3;
@property (nonatomic, strong)UITextField *textField4;

@end

@implementation KongZhiNi

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDic=[NSMutableDictionary new];
     self.view.backgroundColor=MainColor;

    [self initUI];
    
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
      float buttonSize=80*NOW_SIZE;
    
    if([_type isEqualToString:@"0"]){
    UILabel *buttonLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width/2-100*NOW_SIZE)/2, 60*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
    buttonLable.text=root_CNJ_kaiji;
    buttonLable.textAlignment=NSTextAlignmentCenter;
    buttonLable.textColor=[UIColor whiteColor];
    buttonLable.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        buttonLable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:buttonLable];
    
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width/2-buttonSize)/2, 85*HEIGHT_SIZE, buttonSize,buttonSize)];
        firstB.tag=2001;
    [firstB setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(control) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:firstB];
        
        UILabel *buttonLable0=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width/2-100*NOW_SIZE)/2+SCREEN_Width/2, 60*HEIGHT_SIZE, 100*NOW_SIZE,20*HEIGHT_SIZE )];
        buttonLable0.text=root_CNJ_guanji;
        buttonLable0.textAlignment=NSTextAlignmentCenter;
        buttonLable0.textColor=[UIColor whiteColor];
        buttonLable0.font = [UIFont systemFontOfSize:18*HEIGHT_SIZE];
        [_scrollView addSubview:buttonLable0];
        
        UIButton *firstB0=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width/2-buttonSize)/2+SCREEN_Width/2, 85*HEIGHT_SIZE, buttonSize,buttonSize)];
        firstB0.tag=2002;
        [firstB0 setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
        [firstB0 addTarget:self action:@selector(controlOff) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:firstB0];
    }
    
        if([_type isEqualToString:@"1"]){
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 65*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable.text=root_NBQ_youxiao_gonglv;
    PVLable.textAlignment=NSTextAlignmentLeft;
    PVLable.textColor=[UIColor whiteColor];
    PVLable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            PVLable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PVLable];
    _slider=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, SCREEN_Width-40*NOW_SIZE, 40*HEIGHT_SIZE)];
   _slider.maximumValue = 100;
    [_scrollView addSubview:_slider];
    UILabel *PVLable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*HEIGHT_SIZE+20*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable1.text=@"0";
    PVLable1.textAlignment=NSTextAlignmentLeft;
    PVLable1.textColor=[UIColor whiteColor];
    PVLable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable1];
    UILabel *PVLable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-31*NOW_SIZE,  85*HEIGHT_SIZE+20*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PVLable2.text=@"100";
    PVLable2.textAlignment=NSTextAlignmentLeft;
    PVLable2.textColor=[UIColor whiteColor];
    PVLable2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PVLable2];
        }
            
          if([_type isEqualToString:@"2"]){
    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 65*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PV1Lable.text=root_NBQ_wuxiao_gonglv;
    PV1Lable.textAlignment=NSTextAlignmentLeft;
    PV1Lable.textColor=[UIColor whiteColor];
    PV1Lable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
                  PV1Lable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PV1Lable];
    _slider1=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, SCREEN_Width-40*NOW_SIZE, 40*HEIGHT_SIZE)];
    _slider1.maximumValue = 100;
    [_scrollView addSubview:_slider1];
    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*HEIGHT_SIZE+20*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PV1Lable1.text=@"0";
    PV1Lable1.textAlignment=NSTextAlignmentLeft;
    PV1Lable1.textColor=[UIColor whiteColor];
    PV1Lable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PV1Lable1];
    UILabel *PV1Lable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-31*NOW_SIZE,  85*HEIGHT_SIZE+20*HEIGHT_SIZE+55*HEIGHT_SIZE, 150*NOW_SIZE,20*HEIGHT_SIZE )];
    PV1Lable2.text=@"100";
    PV1Lable2.textAlignment=NSTextAlignmentLeft;
    PV1Lable2.textColor=[UIColor whiteColor];
    PV1Lable2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView addSubview:PV1Lable2];
          }
    
    
    if([_type isEqualToString:@"3"]){
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 65*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
        NSString *PV2textValue=[NSString stringWithFormat:@"%@(-0.8~-1/0.8~1)",root_NBQ_PF];
        PV2Lable.text=PV2textValue;
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=[UIColor whiteColor];
    PV2Lable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
             PV2Lable.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PV2Lable];
        
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, 180*NOW_SIZE, 40*HEIGHT_SIZE)];
        _textField2.layer.borderWidth=1;
        _textField2.layer.cornerRadius=5;
        _textField2.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField2.textColor = [UIColor whiteColor];
        _textField2.tintColor = [UIColor whiteColor];
        _textField2.textAlignment=NSTextAlignmentCenter;
        _textField2.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField2];
        

    }
    
    if([_type isEqualToString:@"4"]){
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-250*NOW_SIZE)/2,  65*HEIGHT_SIZE, 250*NOW_SIZE,30*HEIGHT_SIZE )];
    PVData.text=root_NBQ_shijian;
    PVData.textAlignment=NSTextAlignmentCenter;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            PVData.adjustsFontSizeToFitWidth=YES;
    [_scrollView addSubview:PVData];

    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    
        _commandValue= self.currentDay;
        _paramId=@"pf_sys_year";
        
    _datePickerButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, 180*NOW_SIZE, 30*HEIGHT_SIZE)];
        _datePickerButton.layer.borderWidth=1;
        _datePickerButton.layer.cornerRadius=5;
        _datePickerButton.layer.borderColor=[UIColor whiteColor].CGColor;
    [_datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [_datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _datePickerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16*HEIGHT_SIZE];
    [_datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_datePickerButton];
    }
    
    if([_type isEqualToString:@"5"] || [_type isEqualToString:@"6"]){
        
        UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-250*NOW_SIZE)/2,  65*HEIGHT_SIZE, 250*NOW_SIZE,30*HEIGHT_SIZE )];
        if ([_type isEqualToString:@"5"]) {
             PVData.text=root_NBQ_shidian_dianya;
        }else{
         PVData.text=root_shezhi_shidian_dianya_xiaxian;
        }
       
        PVData.textAlignment=NSTextAlignmentCenter;
        PVData.textColor=[UIColor whiteColor];
        PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
          PVData.adjustsFontSizeToFitWidth=YES;
        [_scrollView addSubview:PVData];
    
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_Width-180*NOW_SIZE)/2, 85*HEIGHT_SIZE+30*HEIGHT_SIZE, 180*NOW_SIZE, 40*HEIGHT_SIZE)];
        _textField1.layer.borderWidth=1;
        _textField1.layer.cornerRadius=5;
        _textField1.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField1.textColor = [UIColor whiteColor];
        _textField1.tintColor = [UIColor whiteColor];
         _textField1.textAlignment=NSTextAlignmentCenter;
        _textField1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField1];
    
    }
    
    if([_type isEqualToString:@"7"]){
        NSArray *ossLableName=[NSArray arrayWithObjects:@"寄存器:",@"值:", nil];
        for (int i=0; i<ossLableName.count; i++) {
            UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE,  40*HEIGHT_SIZE+50*HEIGHT_SIZE*i, 100*NOW_SIZE,30*HEIGHT_SIZE )];
            PVData.text=ossLableName[i];
            PVData.textAlignment=NSTextAlignmentRight;
            PVData.textColor=[UIColor whiteColor];
            PVData.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
            PVData.adjustsFontSizeToFitWidth=YES;
            [_scrollView addSubview:PVData];
        }
   
        _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(112*NOW_SIZE, 40*HEIGHT_SIZE, 150*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField3.layer.borderWidth=1;
        _textField3.layer.cornerRadius=5;
        _textField3.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField3.textColor = [UIColor whiteColor];
        _textField3.tintColor = [UIColor whiteColor];
        _textField3.textAlignment=NSTextAlignmentCenter;
        _textField3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField3];
        
        _textField4 = [[UITextField alloc] initWithFrame:CGRectMake(112*NOW_SIZE, 90*HEIGHT_SIZE, 150*NOW_SIZE, 30*HEIGHT_SIZE)];
        _textField4.layer.borderWidth=1;
        _textField4.layer.cornerRadius=5;
        _textField4.layer.borderColor=[UIColor whiteColor].CGColor;
        _textField4.textColor = [UIColor whiteColor];
        _textField4.tintColor = [UIColor whiteColor];
        _textField4.textAlignment=NSTextAlignmentCenter;
        _textField4.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_scrollView addSubview:_textField4];
        
    }
    
    if(![_type isEqualToString:@"0"]){
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,200*HEIGHT_SIZE, 200*NOW_SIZE, 40*HEIGHT_SIZE);
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
          goBut.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
        if ([_controlType isEqualToString:@"2"]) {
           [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
        }else{
           [goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
        }
 
        [_scrollView addSubview:goBut];
    }
}

-(void)finishSet{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }

    
    if(_slider){
    NSString *S1=[NSString stringWithFormat:@"%.0f",_slider.value];
        _commandValue=[NSString stringWithString:S1];
        _paramId=@"pv_active_p_rate";
    }else if (_slider1){
    NSString *S2=[NSString stringWithFormat:@"%.0f",_slider1.value];
         _commandValue=[NSString stringWithString:S2];
         _paramId=@"pv_reactive_p_rate";
    }else if (_slider2){
    NSString *S3=[NSString stringWithFormat:@"%.2f",_slider2.value];
         _commandValue=[NSString stringWithString:S3];
         _paramId=@"pv_power_factor";
    }
    
    if (_textField1) {
        NSString *textValue= [NSString stringWithFormat:@"%.1f",[[_textField1 text] floatValue]];
        
        _commandValue=textValue;
        if ([_type isEqualToString:@"5"]) {
          _paramId=@"pv_grid_voltage_high";
        }else if ([_type isEqualToString:@"6"]){
             _paramId=@"pv_grid_voltage_low";
        }
      
    }
    
    if (_textField2) {
        NSString *textValue= [NSString stringWithFormat:@"%.2f",[[_textField2 text] floatValue]];
        
        _commandValue=textValue;
        
        _paramId=@"pv_power_factor";
    }
    
     [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"serialNum":_PvSn,@"paramId":_paramId,@"command_1":_commandValue,@"command_2":@""} paramarsSite:@"/newTcpsetAPI.do?op=inverterSet" sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"inverterSet: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                
            }else if ([content1[@"msg"] integerValue] ==502) {
                [self showAlertViewWithTitle:nil message:root_CNJ_fuwuqi_cuowu cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==503) {
                [self showAlertViewWithTitle:nil message:root_CNJ_buzaixian cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==504) {
                [self showAlertViewWithTitle:nil message:root_CNJ_xuliehao_kong cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==505) {
                [self showAlertViewWithTitle:nil message:root_CNJ_caijiqi_buzai cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==506) {
                [self showAlertViewWithTitle:nil message:root_CNJ_leixing_buzai cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==507) {
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_kong cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==508) {
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_buzai_fanwei cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==509) {
                [self showAlertViewWithTitle:nil message:root_CNJ_shijian_budui cancelButtonTitle:root_Yes];
            }else if ([content1[@"msg"] integerValue] ==701) {
                [self showAlertViewWithTitle:nil message:root_meiyou_quanxian cancelButtonTitle:root_Yes];
            }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_chenggong cancelButtonTitle:root_Yes];
                 [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError *error) {
          [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];
    
}


-(void)finishSet1{

   _commandValue1=@"";
 
    
    if(_slider){
        NSString *S1=[NSString stringWithFormat:@"%.0f",_slider.value];
        _commandValue=[NSString stringWithString:S1];
        _paramId=@"pv_active_p_rate";
    }else if (_slider1){
        NSString *S2=[NSString stringWithFormat:@"%.0f",_slider1.value];
        _commandValue=[NSString stringWithString:S2];
        _paramId=@"pv_reactive_p_rate";
    }else if (_slider2){
        NSString *S3=[NSString stringWithFormat:@"%.2f",_slider2.value];
        _commandValue=[NSString stringWithString:S3];
        _paramId=@"pv_power_factor";
    }
    
    if (_textField1) {
        NSString *textValue= [NSString stringWithFormat:@"%.1f",[[_textField1 text] floatValue]];
        
        _commandValue=textValue;
        if ([_type isEqualToString:@"5"]) {
            _paramId=@"pv_grid_voltage_high";
        }else if ([_type isEqualToString:@"6"]){
            _paramId=@"pv_grid_voltage_low";
        }
        
    }
    
    if (_textField2) {
        NSString *textValue= [NSString stringWithFormat:@"%.2f",[[_textField2 text] floatValue]];
        
        _commandValue=textValue;
        
        _paramId=@"pv_power_factor";
    }
    
    if (_textField3) {
        NSString *textValue= [NSString stringWithFormat:@"%d",[[_textField3 text] intValue]];
        _commandValue=textValue;
        NSString *textValue1= [NSString stringWithFormat:@"%d",[[_textField4 text] intValue]];
        _commandValue1=textValue1;
        
        _paramId=@"set_any_reg";
    }
    
    if (_commandValue==nil || _commandValue==NULL||([_commandValue isEqual:@""] )){
         [self showToastViewWithTitle:@"请填写设置参数"];
        return;
    }
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"inverterSn":_PvSn,@"paramId":_paramId,@"param_1":_commandValue,@"param_2":_commandValue1} paramarsSite:@"/api/v1/deviceSet/set/inverter" sucessBlock:^(id content) {
        //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"inverterSet: %@", content1);
        [self hideProgressView];
        
        if (content1) {
            if ([content1[@"result"] integerValue] != 1) {
                if ([content1[@"result"] integerValue] ==0) {
                    [self showAlertViewWithTitle:nil message:root_xitong_cuoWu cancelButtonTitle:root_Yes];
                    
                }else if ([content1[@"result"] integerValue] ==2) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_fuwuqi_cuowu cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==3) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_buzaixian cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==4) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_xuliehao_kong cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==5) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_caijiqi_buzai cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==6) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_leixing_buzai cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==7) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_canshu_kong cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==8) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_canshu_buzai_fanwei cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==9) {
                    [self showAlertViewWithTitle:nil message:root_CNJ_shijian_budui cancelButtonTitle:root_Yes];
                }else if ([content1[@"result"] integerValue] ==12) {
                    [self showAlertViewWithTitle:nil message:@"远程设置错误" cancelButtonTitle:root_Yes];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showAlertViewWithTitle:nil message:root_CNJ_canshu_chenggong cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSError *error) {
           [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
     
    }];
    
}


-(void)pickDate{
   // float buttonSize=70*HEIGHT_SIZE;
  _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-300*HEIGHT_SIZE, SCREEN_Width, 300*HEIGHT_SIZE)];
    _date.backgroundColor=[UIColor whiteColor];
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.view addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-300*HEIGHT_SIZE-44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = MainColor;
        [self.view addSubview:self.toolBar];
        
          UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
         UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
         doneButton.tintColor=[UIColor whiteColor];
        
//           [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
//        
//        doneButton.tintColor = [UIColor whiteColor];
        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
   }
    
}


-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];

}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
   
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
     _commandValue= self.currentDay;
      _paramId=@"pf_sys_year";
    if ([_controlType isEqualToString:@"2"]) {
        [self finishSet1];
    }else{
        [self finishSet];
    }
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}

-(void)control{

    _Alert1 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_NBQ_shifou_kaiqi delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    
    [_Alert1 show];
  
}

-(void)controlOff{

   _Alert2 = [[UIAlertView alloc] initWithTitle:root_ALET message:root_NBQ_shifou_guanbi delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    [_Alert2 show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else if (buttonIndex==1){
        if (_Alert1) {
            _commandValue=@"0101";
            _paramId=@"pv_on_off";
            if ([_controlType isEqualToString:@"2"]) {
              [self finishSet1];
            }else{
              [self finishSet];
            }
          
        }else if (_Alert2){
           _commandValue=@"0000";
            _paramId=@"pv_on_off";
            if ([_controlType isEqualToString:@"2"]) {
                [self finishSet1];
            }else{
                [self finishSet];
            }

        }
     
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
