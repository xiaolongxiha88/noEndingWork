//
//  orderFirst.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderFirst.h"
#import "orderCellOne.h"
#import "orderCellTwo.h"
#import "orderCellThree.h"
#import "Model.h"
#import "ShinePhone-Swift.h"
#import "orderSetView.h"
#import "orderCell03.h"

static NSString *cellOne = @"cellOne";
static NSString *cellTwo = @"cellTwo";
static NSString *cellThree = @"cellThree";
static NSString *cellFour = @"cellFour";

@interface orderFirst ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    float H2;
    float H1;
    float allH;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *titleStatusArray;
@property(nonatomic,strong)NSMutableArray *isShowArray;
@property(nonatomic,strong)NSArray *picArray;
@property(nonatomic,strong)NSArray *picArray1;

@property(nonatomic,strong)NSDictionary *allValueDic;

@property(nonatomic,strong)NSString *contentString;

@property(nonatomic,strong)NSString *statusString;

@property(nonatomic,assign)BOOL isDetailNetNow;

@end

@implementation orderFirst{
    NSArray<Model*> *_modelList;
}

-(void)viewWillAppear:(BOOL)animated{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regetNet) name:@"regetNet" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
      [[NSNotificationCenter defaultCenter] removeObserver:self name:@"regetNet" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    H2=self.navigationController.navigationBar.frame.size.height;
    H1=[[UIApplication sharedApplication] statusBarFrame].size.height;
   
    
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"搜索设备" style:UIBarButtonItemStylePlain target:self action:@selector(goToDevice)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
        [self initUI];
    
    [self finishSet];
}

-(void)goToDevice{

    ossDeviceFirst *rootView = [[ossDeviceFirst alloc]init];
    [self.navigationController pushViewController:rootView animated:YES];
    
}

-(void)initData{
    _statusString=[NSString stringWithFormat:@"%@",_allValueDic[@"status"]];
    
    if ([_statusString isEqualToString:@"2"]) {
    _titleArray=[NSArray arrayWithObjects:@"待接收",@"服务中",@"待回访",@"待完成", nil];
    }else if ([_statusString isEqualToString:@"3"]) {
        _titleArray=[NSArray arrayWithObjects:@"已接收",@"服务中",@"待回访",@"待完成", nil];
    }else if ([_statusString isEqualToString:@"4"]) {
        _titleArray=[NSArray arrayWithObjects:@"已接收",@"已服务",@"待回访",@"待完成", nil];
    }else if ([_statusString isEqualToString:@"5"]) {
        _titleArray=[NSArray arrayWithObjects:@"已接收",@"已服务",@"已回访",@"已完成", nil];
    }
    if ([_statusString isEqualToString:@"4"] || [_statusString isEqualToString:@"5"]) {
        NSString *questionPIC=[NSString stringWithFormat:@"%@",_allValueDic[@"fieldService"]];
        _picArray = [questionPIC componentsSeparatedByString:@"_"];
//        NSString *questionPIC1=[NSString stringWithFormat:@"%@",_allValueDic[@"otherServices"]];
//        _picArray1 = [questionPIC1 componentsSeparatedByString:@"_"];
    }
  
 
    NSMutableArray<Model *> *arrM = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (int i=0; i<_titleArray.count; i++) {
        Model *model = [[Model alloc] initWithDict:_titleArray[i]];
        if ([_statusString isEqualToString:@"2"]) {
            if (i==0) {
                model.isShowMoreText=YES;
            }else{
             model.isShowMoreText=NO;
            }
        }else if ([_statusString isEqualToString:@"3"]){
            if (i==1) {
                model.isShowMoreText=YES;
            }else{
                model.isShowMoreText=NO;
            }
        }else if ([_statusString isEqualToString:@"4"]){
            if (i==2) {
                model.isShowMoreText=YES;
            }else{
                model.isShowMoreText=NO;
            }
        }else if ([_statusString isEqualToString:@"5"]){
            if (i==3) {
                model.isShowMoreText=YES;
            }else{
                model.isShowMoreText=NO;
            }
        }
        
        [arrM addObject:model];
    }
    _modelList = arrM.copy;

    if (_tableView) {
        [_tableView removeFromSuperview];
        _tableView=nil;
        
    //    [_tableView reloadData];
        
          [self initUI];
           [self initHeadView];
    }else{
          [self initUI];
       [self initHeadView];
    }
    
  
}


-(void)initUI{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,100*HEIGHT_SIZE )];
        _headView.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_headView];
    }

    
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0, SCREEN_Width,SCREEN_Height-(NaviHeight))];
        _tableView.contentSize=CGSizeMake(SCREEN_Width, 2400*HEIGHT_SIZE);
        _tableView.delegate = self;
        _tableView.dataSource = self;
         _tableView.tableHeaderView=_headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
            [self.tableView registerClass:[orderCellOne class] forCellReuseIdentifier:cellOne];
          [self.tableView registerClass:[orderCellTwo class] forCellReuseIdentifier:cellTwo];
         [self.tableView registerClass:[orderCellThree class] forCellReuseIdentifier:cellThree];
          [self.tableView registerClass:[orderCell03 class] forCellReuseIdentifier:cellFour];
        [self.view addSubview:_tableView];
    }
    
    
}


-(void)initHeadView{
    
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,100*HEIGHT_SIZE )];
        _headView.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_headView];
    }
    
//    _headView = [[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width,100*HEIGHT_SIZE )];
//    _headView.backgroundColor =[UIColor clearColor];
//    [self.view addSubview:_headView];

    float titleLabelH1=30*HEIGHT_SIZE; float firstW1=10*HEIGHT_SIZE;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstW1, 0, SCREEN_Width-(2*firstW1), titleLabelH1)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text=[NSString stringWithFormat:@"%@",_allValueDic[@"title"]];
    titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_headView addSubview:titleLabel];
    
    float ImageW1=16*HEIGHT_SIZE;
    UIImageView *titleImage= [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, titleLabelH1+1*HEIGHT_SIZE, ImageW1, ImageW1)];
    titleImage.image=IMAGE(@"workorder_icon.png");
    [_headView addSubview:titleImage];
    
    float titleLabelH2=20*HEIGHT_SIZE;float headW=SCREEN_Width-(2*firstW1);
    UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1+ImageW1+5*NOW_SIZE, titleLabelH1,headW, titleLabelH2)];
    titleLabel2.textColor = COLOR(51, 51, 51, 1);
    titleLabel2.text=@"基本信息";
    titleLabel2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_headView addSubview:titleLabel2];
    
    NSArray *headName=[NSArray arrayWithObjects:@"所属地区",@"类型", nil];
    NSArray *serviceType=[NSArray arrayWithObjects:@"",@"现场维修",@"安装调试", @"培训",@"巡检",@"其他",@"整改",nil];
    int k=[[NSString stringWithFormat:@"%@",_allValueDic[@"serviceType"]] intValue];
    
//    NSString *test0=[NSString stringWithFormat:@"%@",_allValueDic[@"serviceType11"]];
//    NSString *test=_allValueDic[@"serviceType11"];
//    NSMutableArray *aaa=[NSMutableArray array];
//    [aaa addObject:test0];
//        [aaa addObject:test];
    
    NSString *kName;
    if (k<serviceType.count) {
            kName=serviceType[k];
    }
    
       int groupNameInt=[[NSString stringWithFormat:@"%@",_allValueDic[@"groupId"]] intValue];
        NSArray *intAdrressType=[NSArray arrayWithObjects:@"",@"中国",@"欧洲", @"亚洲",@"泰国",@"美洲",@"非洲",@"澳洲",@"英国",nil];

       NSString *INTAdrress;
    if (groupNameInt<serviceType.count) {
        INTAdrress=intAdrressType[groupNameInt];
    }else{
        INTAdrress=@"其他";
    }
    NSArray *headValue=[NSArray arrayWithObjects:INTAdrress,kName, nil];
    for (int i=0; i<headName.count; i++) {
        UILabel *titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1+(headW/2)*i, titleLabelH1+titleLabelH2,headW/2, titleLabelH2)];
        titleLabel3.textColor = COLOR(102, 102, 102, 1);
        titleLabel3.textAlignment=NSTextAlignmentLeft;
        NSString *name=[NSString stringWithFormat:@"%@:%@",headName[i],headValue[i]];
        titleLabel3.text=name;
        titleLabel3.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_headView addSubview:titleLabel3];
    }
    
    
    UILabel *titleLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(firstW1, titleLabelH1+titleLabelH2*2,headW, titleLabelH2)];
    titleLabel4.textColor = COLOR(102, 102, 102, 1);
    titleLabel4.textAlignment=NSTextAlignmentLeft;
    NSString *name1=[NSString stringWithFormat:@"%@:%@",@"联系方式",[NSString stringWithFormat:@"%@",_allValueDic[@"contact"]]];
    titleLabel4.text=name1;
    titleLabel4.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_headView addSubview:titleLabel4];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [name1 boundingRectWithSize:CGSizeMake(headW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UIView *V0 = [[UIView alloc]initWithFrame:CGRectMake(firstW1+size.width+20*NOW_SIZE,titleLabelH1+titleLabelH2*2, 30*NOW_SIZE,titleLabelH2)];
    V0.backgroundColor =[UIColor clearColor];
    UITapGestureRecognizer *labelTap1;
    V0.userInteractionEnabled=YES;
    labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPhone)];
    [V0 addGestureRecognizer:labelTap1];
    [_headView addSubview:V0];
    
    float imageH=14*HEIGHT_SIZE;
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,3*HEIGHT_SIZE, imageH,imageH)];
    image2.userInteractionEnabled=YES;
    image2.image=IMAGE(@"phone.png");
    
    [V0 addSubview:image2];
    
    
    
}

-(void)finishSet{

    _isDetailNetNow=YES;
    [self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:OSS_HEAD_URL paramars:@{@"orderId":_orderID} paramarsSite:@"/api/v2/order/detail" sucessBlock:^(id content) {
           [self hideProgressView];
        _isDetailNetNow=NO;
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"/api/v2/order/detail: %@", content1);
      
        if (content1) {
               NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            
     if ([firstDic[@"result"] intValue]==1) {
         if ([firstDic[@"obj"] isKindOfClass:[NSDictionary class]]) {
             _allValueDic=[NSDictionary dictionaryWithDictionary:firstDic[@"obj"]];
             if (_allValueDic.count>3) {
                 [self initData];
             }
         }
       
     }else{
      [self showToastViewWithTitle:firstDic[@"msg"]];
         [self.navigationController popViewControllerAnimated:YES];
     }
        }
    } failure:^(NSError *error) {
         _isDetailNetNow=NO;
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
           [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}





-(void)getPhone{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_allValueDic[@"contact"] message:root_dadianhua delegate:self cancelButtonTitle:root_cancel otherButtonTitles:root_OK, nil];
    alertView.tag = 1002;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex) {
        if (alertView.tag == 1002) {
            NSString *strUrl = [_allValueDic[@"contact"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *allString = [NSString stringWithFormat:@"tel://%@",strUrl];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
          
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelList.count;
}

-(void)regetNet{
 
            [self finishSet];
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        orderCellOne *cell = [tableView dequeueReusableCellWithIdentifier:cellOne forIndexPath:indexPath];
            Model *model = _modelList[indexPath.row];
        cell.model = model;
        cell.orderID=_orderID;
        cell.statusString=_statusString;
        cell.allValueDic=[NSDictionary dictionaryWithDictionary:_allValueDic];
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
           return cell;
    }else if (indexPath.row==1) {
        orderCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellTwo forIndexPath:indexPath];
        Model *model = _modelList[indexPath.row];
        cell.model = model;
        cell.orderID=_orderID;
        cell.statusString=_statusString;
        cell.allValueDic=[NSDictionary dictionaryWithDictionary:_allValueDic];
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
         orderSetView *testView=[[orderSetView alloc]init];
        testView.getSetValue = ^(NSDictionary *setDic){
            cell.setValueDic=[NSDictionary dictionaryWithDictionary:setDic];
        };
        cell.goToSetBlock = ^(){
         
            testView.setType=[[NSString stringWithFormat:@"%@",_allValueDic[@"serviceType"]] intValue];
            if (![_statusString isEqualToString:@"3"]){
               // NSString *serviceReportString=_allValueDic[@"serviceReport"];
               // NSDictionary *setDic=[self dictionaryWithJsonString:serviceReportString];
                
                if ([_allValueDic[@"serviceReport"] isKindOfClass:[NSDictionary class]]) {
                     testView.setValueDic=[NSMutableDictionary dictionaryWithDictionary:_allValueDic[@"serviceReport"]];
                }
               
            }
            testView.statusString=_statusString;
            [self.navigationController pushViewController:testView animated:YES];
        };
        
        return cell;
    }else if (indexPath.row==2) {
        orderCellThree *cell = [tableView dequeueReusableCellWithIdentifier:cellThree forIndexPath:indexPath];
        Model *model = _modelList[indexPath.row];
        cell.model = model;
        cell.orderID=_orderID;
        cell.statusString=_statusString;
        cell.allValueDic=[NSDictionary dictionaryWithDictionary:_allValueDic];
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        return cell;
    }else if (indexPath.row==3) {
        orderCell03 *cell = [tableView dequeueReusableCellWithIdentifier:cellFour forIndexPath:indexPath];  
        Model *model = _modelList[indexPath.row];
        cell.model = model;
        cell.orderID=_orderID;
        cell.statusString=_statusString;
        cell.picArray=[NSArray arrayWithArray:_picArray];
           // cell.picArray1=[NSArray arrayWithArray:_picArray1];
        cell.allValueDic=[NSDictionary dictionaryWithDictionary:_allValueDic];
        [cell setShowMoreBlock:^(UITableViewCell *currentCell) {
            NSIndexPath *reloadIndexPath = [self.tableView indexPathForCell:currentCell];
            [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    
        return cell;
    }else{
    
        return nil;
    }

    
 
}

// MARK: - 返回cell高度的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


      Model *model = _modelList[indexPath.row];
    
     float firstW=25*NOW_SIZE; CGFloat H=H1+H2;
    NSString*remarkH=_allValueDic[@"remarks"];
    if (indexPath.row==3){
        remarkH=_allValueDic[@"recommended"];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
    CGSize size = [remarkH boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
       float remarkLabelH;float lableH=30*HEIGHT_SIZE;
    if (lableH>(size.height+10*HEIGHT_SIZE)) {
        remarkLabelH=lableH;
    }else{
        remarkLabelH=size.height+10*HEIGHT_SIZE;
    }
    
    if (model.isShowMoreText){
        if (indexPath.row==0) {
             return [orderCellOne moreHeight:H status:_statusString remarkH:remarkLabelH];
        }else if (indexPath.row==1){
       
                return [orderCellTwo moreHeight:H status:_statusString remarkH:remarkLabelH];
        }else if (indexPath.row==2){
           
            
             return [orderCellThree moreHeight:remarkLabelH];
              
        }else if (indexPath.row==3){
              NSString*remarkH2=_allValueDic[@"returnNote"];
              CGSize size2 = [remarkH2 boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            remarkLabelH=remarkLabelH+size2.height;
            return [orderCellThree moreHeight:remarkLabelH];
            
        }else{
            return 1*HEIGHT_SIZE;
        }
       
    } else{
        if (indexPath.row==0) {
           return [orderCellOne defaultHeight];
        }else if (indexPath.row==1){
          return [orderCellTwo defaultHeight];
        }else if (indexPath.row==2){
          return [orderCellThree defaultHeight];
        }else if (indexPath.row==3){
            return [orderCellThree defaultHeight];
        }else{
            return 1*HEIGHT_SIZE;
        }
    }
    
}



-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
