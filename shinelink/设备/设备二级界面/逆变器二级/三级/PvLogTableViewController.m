//
//  PvLogTableViewController.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "PvLogTableViewController.h"
#import "pvLogTableViewCell.h"
#import "addServerViewController.h"
#import "HtmlCommon.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface PvLogTableViewController ()
@property(nonatomic,strong)NSMutableArray *SNTextArray;
@property(nonatomic,strong)NSMutableArray *typtTextArray;
@property(nonatomic,strong)NSMutableArray *eventTextArray;
@property(nonatomic,strong)NSMutableArray *LogTextArray;
@property(nonatomic,strong)NSMutableArray *contentTextArray;
@property(nonatomic,strong)NSMutableArray *timeTextArray;
@property (nonatomic, strong)  UIImageView *AlertView ;
@property (nonatomic, strong)  NSString *languageValue ;
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@end

@implementation PvLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    self.tableView.separatorColor=[UIColor grayColor];
    
    if ([_type isEqualToString:@"mixId"]) {    
        [self netLog2];
    }else{
          [self netLog];
    }
  

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

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


-(void)netLog{
      self.SNTextArray=[NSMutableArray array];
     self.typtTextArray=[NSMutableArray array];
     self.eventTextArray=[NSMutableArray array];
    self.LogTextArray =[NSMutableArray array];
    self.contentTextArray=[NSMutableArray array];
        self.timeTextArray=[NSMutableArray array];
    
//_PvSn=@"SAMP524004";
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{_type:_PvSn,@"pageNum":@"1", @"pageSize":@"30"} paramarsSite:_address sucessBlock:^(id content) {
        [self hideProgressView];
            NSLog(@"getInverterAlarm: %@", content);
        if (content) {
          
             NSMutableArray *allArray=[NSMutableArray arrayWithArray:content];
            
            
            if(allArray.count==0){
                
                if (!_AlertView) {
                    if ([_languageValue isEqualToString:@"0"]) {
                        _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                        _AlertView.image=[UIImage imageNamed:@"datalog_cn2.png"];
                        [self.view addSubview:_AlertView];
                    }else{
                        _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                        _AlertView.image=[UIImage imageNamed:@"datalog_en2.png"];
                        [self.view addSubview:_AlertView];
                    }
                }
                
            }

            for(int i=0;i<allArray.count;i++){
                
                if (_AlertView) {
                    [_AlertView removeFromSuperview];
                    _AlertView=nil;
                }
                
                NSString *SN=[NSString stringWithFormat:@"%@",content[i][@"deviceSerialNum"]];
                NSString *TY=[NSString stringWithFormat:@"%@",content[i][@"deviceType"]];
                NSString *EV=[NSString stringWithFormat:@"%@",content[i][@"eventId"]];
                 NSString *LOG=[NSString stringWithFormat:@"%@",content[i][@"eventName"]];
                NSString *time=[NSString stringWithFormat:@"%@",content[i][@"occurTime"]];
                NSString *CO=[NSString stringWithFormat:@"%@",content[i][@"eventName"]];
                
                [self.SNTextArray addObject:SN];
                [self.typtTextArray addObject:TY];
                [self.eventTextArray addObject:EV];
                [self.LogTextArray addObject:LOG];
                [self.contentTextArray addObject:CO];
                 [self.timeTextArray addObject:time];
                
                if (_SNTextArray.count==allArray.count) {
                    [self getAFQ];
                    [self.tableView reloadData];
                }
               
            }

        }
    } failure:^(NSError *error) {
        [self hideProgressView];
     
    }];

}


-(void)netLog2{
    self.SNTextArray=[NSMutableArray array];
    self.typtTextArray=[NSMutableArray array];
    self.eventTextArray=[NSMutableArray array];
    self.LogTextArray =[NSMutableArray array];
    self.contentTextArray=[NSMutableArray array];
    self.timeTextArray=[NSMutableArray array];
    
  //  _PvSn=@"wsk0000001";
    
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{_type:_PvSn,@"pageNum":@"1", @"pageSize":@"30"} paramarsSite:_address sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getInverterAlarm: %@", content);
        if (content) {
            
             NSMutableArray *allArray=[NSMutableArray new];
            
            if ([content[@"result"] intValue]==1) {
                    allArray=[NSMutableArray arrayWithArray:content[@"obj"]];
                
            }
        
            
            
            if(allArray.count==0){
                
                if (!_AlertView) {
                    if ([_languageValue isEqualToString:@"0"]) {
                        _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                        _AlertView.image=[UIImage imageNamed:@"datalog_cn2.png"];
                        [self.view addSubview:_AlertView];
                    }else{
                        _AlertView=[[UIImageView alloc]initWithFrame:CGRectMake(0.1* SCREEN_Width, 100*HEIGHT_SIZE,0.8* SCREEN_Width, 0.294* SCREEN_Width)];
                        _AlertView.image=[UIImage imageNamed:@"datalog_en2.png"];
                        [self.view addSubview:_AlertView];
                    }
                }
                
            }
            
            for(int i=0;i<allArray.count;i++){
                
                if (_AlertView) {
                    [_AlertView removeFromSuperview];
                    _AlertView=nil;
                }
                
                NSString *SN=[NSString stringWithFormat:@"%@",allArray[i][@"deviceSerialNum"]];
                NSString *TY=[NSString stringWithFormat:@"%@",allArray[i][@"deviceType"]];
                NSString *EV=[NSString stringWithFormat:@"%@",allArray[i][@"eventId"]];
                NSString *LOG=[NSString stringWithFormat:@"%@",allArray[i][@"eventName"]];
                NSString *time=[NSString stringWithFormat:@"%@",allArray[i][@"occurTime"]];
                NSString *CO=[NSString stringWithFormat:@"%@",allArray[i][@"eventName"]];
                
                [self.SNTextArray addObject:SN];
                [self.typtTextArray addObject:TY];
                [self.eventTextArray addObject:EV];
                [self.LogTextArray addObject:LOG];
                [self.contentTextArray addObject:CO];
                [self.timeTextArray addObject:time];
                
                if (_SNTextArray.count==allArray.count) {
                    [self getAFQ];
                    [self.tableView reloadData];
                }
                
            }
            
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(void)getAFQ{

    NSDictionary *dicGo=@{@"type":@"0",@"language":_languageValue} ;
    
    [self showProgressView];
    _idArray=[NSMutableArray array];
     _titleArray=[NSMutableArray array];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:@"/questionAPI.do?op=getUsQuestionListByType" sucessBlock:^(id content) {
        NSLog(@"getUsQuestionListByType: %@", content);
        [self hideProgressView];
        if (content) {
            
            NSMutableArray *allDic=[NSMutableArray arrayWithArray:content[@"obj"]];
            for (int i=0; i<allDic.count; i++) {
                [_idArray addObject:allDic[i][@"id"]];
                [_titleArray addObject:allDic[i][@"title"]];
            }
     
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];


}

- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

    
    return _SNTextArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect fcRect = [self.contentTextArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
    return 125*HEIGHT_SIZE+fcRect.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    pvLogTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[pvLogTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.SNText.text=[NSString stringWithFormat:@"%@%@",root_NBQ_xunliehao,_SNTextArray[indexPath.row]];
      cell.typtText.text=[NSString stringWithFormat:@"%@%@",root_NBQ_leixing,_typtTextArray[indexPath.row]];
      cell.eventText.text=[NSString stringWithFormat:@"%@%@",root_NBQ_shijianhao,_eventTextArray[indexPath.row]];
      cell.LogText.text=[NSString stringWithFormat:@"%@%@",root_NBQ_biaoshi,_LogTextArray[indexPath.row]];
    cell.timeLabel.text=self.timeTextArray[indexPath.row];
    cell.contentLabel.text=self.contentTextArray[indexPath.row];
    cell.content=self.contentTextArray[indexPath.row];
   
    
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*NOW_SIZE, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *HEIGHT_SIZE]} context:nil];
    cell.contentLabel.frame =CGRectMake(10*NOW_SIZE, 45*HEIGHT_SIZE, 300*NOW_SIZE, fcRect.size.height);
    cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-210*NOW_SIZE, 105*HEIGHT_SIZE+fcRect.size.height,200*NOW_SIZE, 20*HEIGHT_SIZE );
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  

    
    if ([_type isEqualToString:@"inverterId"]) {
        HtmlCommon *go=[[HtmlCommon alloc]init];
        
        if ([_languageValue isEqualToString:@"0"]) {
            NSString *errorName=@"错误代码";
            for (int i=0; i<_titleArray.count; i++) {
                NSString *titleName=[NSString stringWithFormat:@"%@",_titleArray[i]];
                if ([titleName containsString:errorName]) {
                    go.idString=_idArray[i];
                    [self.navigationController pushViewController:go animated:NO];
                }
            }
            
        }else{
            NSString *eventId=_eventTextArray[indexPath.row];
            NSString *errorName;
            
            if ([eventId isEqualToString:@"31"]) {
                errorName=@"AC F";    //AC F Outrange
            }else if ([eventId isEqualToString:@"25"]){
                errorName=@"onnection"; // No AC Connection
            }else if ([eventId isEqualToString:@"27"]){
                errorName=@"esidual";//Residual I High
            }else if ([eventId isEqualToString:@"26"]){
                errorName=@"solation"; //PV Isolation Low
            }else if ([eventId isEqualToString:@"32"]){
                errorName=@"odule";//Module Hot
            }else if ([eventId isEqualToString:@"28"]){
                errorName=@"DCI";//Output High DCI
            }else if ([eventId isEqualToString:@"30"]){
                errorName=@"AC V";//AC V Outrange
            }
            
            if (errorName==nil || errorName==NULL||([errorName isEqual:@""] )) {
                go.idString=@"24";
                [self.navigationController pushViewController:go animated:NO];
            }else{
                for (int i=0; i<_titleArray.count; i++) {
                    NSString *titleName=[NSString stringWithFormat:@"%@",_titleArray[i]];
                    if ([titleName containsString:errorName]) {
                        go.idString=_idArray[i];
                        [self.navigationController pushViewController:go animated:NO];
                    }
                }
            }
            
        }
        
    }else{
    
            addServerViewController *addGo=[[addServerViewController alloc]init];
            if ([_type isEqualToString:@"inverterId"]) {
                addGo.typeNum=@"1";
            }else if ([_type isEqualToString:@"storageId"]){
               addGo.typeNum=@"2";
            }
            addGo.SnString=_SNTextArray[indexPath.row];
            addGo.titleString=self.contentTextArray[indexPath.row];
             [self.navigationController pushViewController:addGo animated:NO];
    
    }
    
    

   
    

}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
