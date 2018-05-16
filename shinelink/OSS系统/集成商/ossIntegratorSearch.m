//
//  ossIntegratorSearch.m
//  ShinePhone
//
//  Created by sky on 2018/5/16.
//  Copyright © 2018年 sky. All rights reserved.
//

#import "ossIntegratorSearch.h"
#import "ZJBLStoreShopTypeAlert.h"

@interface ossIntegratorSearch ()

@property (nonatomic, strong) NSArray *unitNameArray;
@property (nonatomic, strong) NSArray *unitTypeArray;
@property (nonatomic, strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign)float HH;
@property (nonatomic, assign)float H_All;

@end

@implementation ossIntegratorSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
       _textFieldMutableArray=[NSMutableArray new];
    
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight)];
        _scrollView.scrollEnabled=YES;
        _scrollView.userInteractionEnabled=YES;
        [self.view addSubview:_scrollView];
    }
  
    _HH=40*HEIGHT_SIZE;
    [self initSearchType];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

-(void)initSearchType{
    if (_searchType==1) {
        [self initDeviceUI];
    }
}

-(void)initDeviceUI{
    _H_All=0;
    NSArray* nameArray=@[@"逆变器",@"所有",@"所有安装商",@"城市"];
     NSArray* typeArray=@[@"2",@"2",@"2",@"1"];
    float w_k=15*NOW_SIZE;
    float WW=ScreenWidth/2.0;
    for (int i=0; i<nameArray.count; i++) {
        int H_i=i/2;
         int W_i=i%2;
        CGRect Rect=CGRectMake(w_k+W_i*WW, 0+_HH*H_i, WW-2*w_k, _HH);
        
        [self getSelectUI:Rect name:nameArray[i] type:[typeArray[i] integerValue] tagNum:2000+i firstView:_scrollView];
        
    }
    
    _H_All=((nameArray.count/2)+(nameArray.count%2))*_HH;
    
    [self getSelectTwoUI:_H_All name:@"序列号" name2:@"输入序列号" tagNum:3000 firstView:_scrollView];
    
}



-(void)getSelectUI:(CGRect)frameSize name:(NSString*)name type:(NSInteger)type tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{

    float WK1=5*NOW_SIZE;
    float W_image1=8*HEIGHT_SIZE;
    float H_image1=6*HEIGHT_SIZE;

    if (type==1) {
        UITextField *text1 = [[UITextField alloc] initWithFrame:frameSize];
        text1.textColor =  COLOR(51, 51, 51, 1);
        text1.tintColor =  COLOR(51, 51, 51, 1);
        text1.tag=tagNum+100;
        text1.adjustsFontSizeToFitWidth=YES;
         text1.textAlignment=NSTextAlignmentCenter;
        text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        text1.placeholder = name;
        [text1 setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [text1 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
        
        [firstView addSubview:text1];
        
        [_textFieldMutableArray addObject:text1];
    }else{
        UIView *V0= [[UIView alloc]initWithFrame:frameSize];
        V0.backgroundColor = [UIColor clearColor];
        V0.userInteractionEnabled=YES;
        V0.tag=tagNum;
        UITapGestureRecognizer *labelTap1;
        labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
        [V0 addGestureRecognizer:labelTap1];
        [firstView addSubview:V0];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,frameSize.size.width-W_image1-WK1, frameSize.size.height)];
        lable1.textColor = COLOR(51, 51, 51, 1);
        lable1.tag=tagNum+100;
        lable1.text=name;
        lable1.adjustsFontSizeToFitWidth=YES;
        lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.userInteractionEnabled=YES;
        [V0 addSubview:lable1];
        
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(frameSize.size.width-W_image1, (frameSize.size.height-H_image1)/2, W_image1,H_image1 )];
        image2.userInteractionEnabled=YES;
        image2.image=IMAGE(@"upOSS.png");
        [V0 addSubview:image2];
    }
    
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(frameSize.origin.x,frameSize.origin.y+frameSize.size.height-1*HEIGHT_SIZE, frameSize.size.width,1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
}



-(void)getSelectTwoUI:(float)Y_H name:(NSString*)name name2:(NSString*)name2 tagNum:(NSInteger)tagNum firstView:(UIView*)firstView{
    float WK1=5*NOW_SIZE;
    float W_image1=8*HEIGHT_SIZE;
    float H_image1=6*HEIGHT_SIZE;
      float w_k=15*NOW_SIZE;
      float W1=ScreenWidth/2.0-2*w_k-WK1-W_image1;
    
    UIView *V0= [[UIView alloc]initWithFrame:CGRectMake(w_k, Y_H, W1+WK1+W_image1, _HH)];
    V0.backgroundColor = [UIColor clearColor];
    V0.userInteractionEnabled=YES;
    V0.tag=tagNum;
    UITapGestureRecognizer *labelTap1;
    labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectChioce:)];
    [V0 addGestureRecognizer:labelTap1];
    [firstView addSubview:V0];
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,W1, _HH)];
    lable1.textColor = COLOR(51, 51, 51, 1);
    lable1.tag=tagNum+100;
    lable1.text=name;
    lable1.adjustsFontSizeToFitWidth=YES;
    lable1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    lable1.textAlignment=NSTextAlignmentCenter;
    lable1.userInteractionEnabled=YES;
    [V0 addSubview:lable1];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(W1+WK1, (_HH-H_image1)/2, W_image1,H_image1 )];
    image2.userInteractionEnabled=YES;
    image2.image=IMAGE(@"upOSS.png");
    [V0 addSubview:image2];
    
        float WK2=30*NOW_SIZE;
    float W_left=w_k+W1+WK1+W_image1+WK2;
    UITextField *text1 = [[UITextField alloc] initWithFrame:CGRectMake(W_left, Y_H, ScreenWidth-w_k-W_left,_HH )];
    text1.textColor =  COLOR(51, 51, 51, 1);
    text1.tintColor =  COLOR(51, 51, 51, 1);
    text1.tag=tagNum+200;
    text1.adjustsFontSizeToFitWidth=YES;
    text1.textAlignment=NSTextAlignmentCenter;
    text1.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    text1.placeholder = name2;
    [text1 setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [text1 setValue:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
    
    [firstView addSubview:text1];
    
    [_textFieldMutableArray addObject:text1];
    
    UIView *V01 = [[UIView alloc]initWithFrame:CGRectMake(w_k,Y_H+_HH-1*HEIGHT_SIZE,ScreenWidth-w_k*2,1*HEIGHT_SIZE)];
    V01.backgroundColor = COLOR(222, 222, 222, 1);
    [firstView addSubview:V01];
    
}



-(void)selectChioce:(UITapGestureRecognizer*)tap{
    NSInteger Num=tap.view.tag;
    NSArray *nameArray;NSString *titleString;
    if (_searchType==1) {
        if (Num==2000 || Num==2001 || Num==2002) {
            if (Num==2000) {
                titleString=@"选择设备类型";
                nameArray=@[@"逆变器",@"储能机",@"混储一体机"];
            }else if (Num==2001) {
                 titleString=@"";
                nameArray=@[@"所有",@"已接入设备",@"未接入设备"];
            }else if (Num==2002) {
                nameArray=@[@"逆变器",@"储能机",@"混储一体机"];
            }
            [self chiceItem:titleString nameArray:nameArray Num:Num];
        }
   
    }
    
}


-(void)chiceItem:(NSString*)titleString nameArray:(NSArray*)nameArray Num:(NSInteger)Num{
    [ZJBLStoreShopTypeAlert showWithTitle:titleString titles:nameArray selectIndex:^(NSInteger selectIndex) {
      
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[self.view viewWithTag:Num+100];
        lable.text=selectValue;
        
    } showCloseButton:YES ];
    
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
