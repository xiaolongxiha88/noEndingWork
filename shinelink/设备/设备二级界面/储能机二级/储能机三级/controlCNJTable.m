//
//  controlCNJTable.m
//  shinelink
//
//  Created by sky on 16/4/19.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "controlCNJTable.h"
#import "ControlCNJ.h"
#import "RKAlertView.h"
#import "SPF5000Control.h"
#import "MixControl.h"


#define AlertContent @"Growatt"

@interface controlCNJTable ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *password;
 @property (nonatomic, assign) BOOL isRememberPassword;

@property (nonatomic, strong) NSDictionary *getOldDic;

@end

@implementation controlCNJTable


-(void)viewWillAppear:(BOOL)animated{
    if([_typeNum isEqualToString:@"3"]){         //MIX设置
  
        [self getOldSetValue];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=MainColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor=[UIColor whiteColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    _isRememberPassword=NO;
    
    [self getPassword];
    
    self.dataArray =[NSMutableArray arrayWithObjects:root_CNJ_kaiguan,root_CNJ_SOC,root_CNJ_shijian,root_CNJ_fangdian_kaiguan,root_CNJ_fangdian_shijian,root_CNJ_SP,root_chongdian_shineng,root_chongdian_shijianduan,root_chongdian_dianchi_soc,nil];

    if([_typeNum isEqualToString:@"1"]){
      self.dataArray =[NSMutableArray arrayWithObjects:root_5000Control_129,root_5000Control_130,root_5000Control_131,root_5000Control_132,root_5000Control_133,root_5000Control_134,root_5000Control_135,root_5000Control_136,root_5000Control_137,root_5000Control_138,root_5000Control_139,root_5000Control_140,root_5000Control_141,root_5000Control_142,root_5000Control_143,nil];
    }else  if([_typeNum isEqualToString:@"3"]){         //MIX设置
         self.dataArray =[NSMutableArray arrayWithObjects:root_MIX_210,root_MIX_209,root_NBQ_kaiguan,root_device_249,root_NBQ_youxiao_gonglv,root_NBQ_wuxiao_gonglv,root_NBQ_PF,root_NBQ_shijian,root_device_250,root_device_251,root_device_252,root_device_253,root_device_254,root_MIX_492,nil];
        if ([_controlType isEqualToString:@"2"]) {
               self.dataArray =[NSMutableArray arrayWithObjects:root_MIX_210,root_MIX_209,root_NBQ_kaiguan,root_device_249,root_NBQ_youxiao_gonglv,root_NBQ_wuxiao_gonglv,root_NBQ_PF,root_NBQ_shijian,root_device_250,root_device_251,root_device_252,root_device_253,root_device_254,root_MIX_492,@"高级设置",nil];
        }
        
      //  [self getOldSetValue];
    }
    

    
}




-(void)getOldSetValue{
    NSDictionary *dicGo=@{@"serialNum":_CnjSn,@"kind":@"0"};
    _getOldDic=[NSDictionary new];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:@"/newMixApi.do?op=getMixSetParams" sucessBlock:^(id content) {
        NSLog(@"/newMixApi.do?op=getMixSetParams: %@", content);
        NSString *result=[NSString stringWithFormat:@"%@",content[@"result"]];
        if ([result intValue]==1) {
            NSDictionary *objDic=[NSDictionary dictionaryWithDictionary:content[@"obj"]];
            if ([objDic.allKeys containsObject:@"mixBean"]) {
           _getOldDic=[NSDictionary dictionaryWithDictionary:objDic[@"mixBean"]];
            }

        }else{
            
        }
        
    } failure:^(NSError *error) {
   
    }];
    
}


-(void)getPassword{

   NSDateFormatter *dataFormatter= [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dataFormatter stringFromDate:[NSDate date]];
    
    NSString *typeString=@"2";
    if([_typeNum isEqualToString:@"3"]){
        typeString=@"3";
    }
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"type":typeString,@"stringTime":time} paramarsSite:@"/newLoginAPI.do?op=getSetPass" sucessBlock:^(id content) {
 
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
     
        NSLog(@"getUserServerUrl: %@", content1);
        if (content1 != [NSNull null]) {
            _password=content1[@"msg"];

         
        }
        
    } failure:^(NSError *error) {
  
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_Device_479 message:nil delegate:self cancelButtonTitle:root_OK otherButtonTitles:nil];
//        [alertView show];
        
    }];
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
      cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    cell.textLabel.adjustsFontSizeToFitWidth=YES;
    cell.textLabel.text=_dataArray[indexPath.row];
     cell.backgroundColor=MainColor;
    cell.tintColor = [UIColor whiteColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50*NOW_SIZE;
    
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_password isEqualToString:@""] || _password==nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:root_Device_479 message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alertView show];
    }
    
    if([_typeNum isEqualToString:@"1"]){
        [self goSPF5000:indexPath];
    }else if([_typeNum isEqualToString:@"3"]){
        [self goMIX:indexPath];
    }else{
     [self goSP2000And3000:indexPath];
    }
    

}


-(void)goSP2000And3000:(NSIndexPath *)indexPath{
    ControlCNJ  *go=[[ControlCNJ alloc]init];
    go.type=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    go.CnjSN=_CnjSn;
    
    if ([_controlType isEqualToString:@"2"]) {
        go.controlType=_controlType;
        [self.navigationController pushViewController:go animated:YES];
    }else{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
            [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
            return;
        }else{
            
            if ((indexPath.row==0)||(indexPath.row==1)||(indexPath.row==3)||(indexPath.row==5)||(indexPath.row==7)||(indexPath.row==6)||(indexPath.row==9)||(indexPath.row==8)) {
                if(_isRememberPassword){
                    [self.navigationController pushViewController:go animated:YES];
                }else{
                    [RKAlertView showAlertPlainTextWithTitle:root_Alet_user message:root_kongzhi_Alert cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
                        NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
                        NSString *alert1=[alertView textFieldAtIndex:0].text;
                        
                        if ([alert1 isEqualToString:_password]) {
                                       _isRememberPassword=YES;
                            [self.navigationController pushViewController:go animated:YES];
                        }else{
                            [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_kongzhi_mima confirmTitle:root_OK confrimBlock:^{
                                
                            }];
                            
                        }
                        
                    } cancelBlock:^{
                        NSLog(@"取消了");
                    }];
                }
           
                
                
            }else  if ((indexPath.row==2)||(indexPath.row==4)) {
                
                [self.navigationController pushViewController:go animated:YES];
            }
            
            
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

        }
    }
    
}




-(void)goSPF5000:(NSIndexPath *)indexPath{
    SPF5000Control  *go=[[SPF5000Control alloc]init];
    go.type=(int)indexPath.row;
    go.titleString=_dataArray[indexPath.row];
    go.CnjSN=_CnjSn;
    

    if ([_controlType isEqualToString:@"2"]) {
        go.controlType=_controlType;
        [self.navigationController pushViewController:go animated:YES];
    }else{
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
            [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
            return;
        }else{
            if(_isRememberPassword){
                    [self.navigationController pushViewController:go animated:YES];
            }else{
                [RKAlertView showAlertPlainTextWithTitle:root_Alet_user message:root_kongzhi_Alert cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
                    NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
                    NSString *alert1=[alertView textFieldAtIndex:0].text;
                    
                    
                    if ([alert1 isEqualToString:_password]) {
                        _isRememberPassword=YES;
                        [self.navigationController pushViewController:go animated:YES];
                    }else{
                        [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_kongzhi_mima confirmTitle:root_OK confrimBlock:^{
                            
                        }];
                        
                    }
                    
                } cancelBlock:^{
                    NSLog(@"取消了");
                }];
            }


            
        }
    
    }
   

}


-(void)goMIX:(NSIndexPath *)indexPath{
    MixControl  *go=[[MixControl alloc]init];
    go.titleString=_dataArray[indexPath.row];
    go.CnjSN=_CnjSn;
    go.setType=(int)indexPath.row;
    go.getOldDic=[NSDictionary dictionaryWithDictionary:_getOldDic];
    
    if ([_controlType isEqualToString:@"2"]) {
        go.controlType=_controlType;
        go.serverId=_serverId;
        [self.navigationController pushViewController:go animated:YES];
    }else{
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
            [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
            return;
        }else{
            if(_isRememberPassword){
            
                [self.navigationController pushViewController:go animated:YES];
            }else{
                [RKAlertView showAlertPlainTextWithTitle:root_Alet_user message:root_kongzhi_Alert cancelTitle:root_cancel confirmTitle:root_OK alertViewStyle:UIAlertViewStylePlainTextInput confrimBlock:^(UIAlertView *alertView) {
                    NSLog(@"确认了输入：%@",[alertView textFieldAtIndex:0].text);
                    NSString *alert1=[alertView textFieldAtIndex:0].text;
                    
                    
                    if ([alert1 isEqualToString:_password]) {
                               _isRememberPassword=YES;
                        [self.navigationController pushViewController:go animated:YES];
                    }else{
                        [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_kongzhi_mima confirmTitle:root_OK confrimBlock:^{
                            
                        }];
                        
                    }
                    
                } cancelBlock:^{
                    NSLog(@"取消了");
                }];
            }
            
      
            
        }
        
    }
    
    
}



@end
