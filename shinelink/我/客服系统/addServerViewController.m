//
//  addServerViewController.m
//  shinelink
//
//  Created by sky on 16/4/5.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "addServerViewController.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "OssMessageViewController.h"

@interface addServerViewController ()<UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *SNTextField;
@property (nonatomic, strong) UILabel* registLable;
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableDictionary *allDict;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) UILabel* QuestionLable;
@property(nonatomic,strong)UIView *imageViewAll;
@property(nonatomic,strong)UIImageView *imageV5;
@property (nonatomic, strong)  NSString *phoneOrEmail;

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) NSMutableArray *SNArray;
@property (nonatomic, strong) NSMutableArray *SnOnlyArray;
@property (nonatomic, strong) UITextField *phoneTextField;

@end

@implementation addServerViewController
{
    int picTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_ME_tijiao_wenti;
    picTime=0;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_ME_tijiao_wenti style:UIBarButtonItemStylePlain target:self action:@selector(finishDone)];
    rightItem.tag=10;
    self.navigationItem.rightBarButtonItem=rightItem;
    
      _phoneOrEmail=@"1";
    _picArray=[NSMutableArray array];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAlert) name:@"removeAlert" object:nil];
    
    [self initUI];
    [self getNetForSn];
}


-(void)getNetForSn{

    _SNArray=[NSMutableArray new];
        _SnOnlyArray=[NSMutableArray new];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *plantId=[ud objectForKey:@"plantID"];
    //[self showProgressView];
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"plantId":plantId,@"pageNum":@"1", @"pageSize":@"20"} paramarsSite:@"/newQualityAPI.do?op=getQualityInformation" sucessBlock:^(id content) {
        [self hideProgressView];
        
        if (content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            NSArray *jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"getQualityInformation==%@", jsonObj);
            NSArray *allArray=[NSArray arrayWithArray:jsonObj];
            for (int i=0; i<allArray.count; i++) {

                NSString *deviceType=allArray[i][@"deviceType"];
                NSString *deviceSN=allArray[i][@"deviceSN"];
                
                NSString *SnAll=[NSString stringWithFormat:@"%@--%@",deviceType,deviceSN];
                
                [_SNArray addObject:SnAll];
                [_SnOnlyArray addObject:deviceSN];
                
            }
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

}


-(void)initUI{
          float imageH=50*HEIGHT_SIZE;
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height-imageH)];
    _scrollView.backgroundColor=[UIColor clearColor];
    _scrollView.contentSize=CGSizeMake(SCREEN_Width, SCREEN_Height*1.2);
    _scrollView.userInteractionEnabled=YES;
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
      _labelArray=[[NSMutableArray alloc]initWithObjects:root_ME_biaoti, root_ME_wenti_leixing, root_NBQ_xunliehao,root_shoujihao,nil];
     NSMutableArray *alertArray=[[NSMutableArray alloc]initWithObjects:root_ME_biaoti_shuru, root_ME_wenti_leixing_xuanzhe, root_ME_xuliehao_shuru,root_Enter_phone_number,nil];
    
    float lableH=40*HEIGHT_SIZE;float Nsize=lableH+2*HEIGHT_SIZE;
    float lablaFontSize=12*HEIGHT_SIZE;
    for (int i=0; i<_labelArray.count; i++) {
   NSString *nameString=_labelArray[i];
        CGSize nameSize=[self getStringSize:lablaFontSize Wsize:MAXFLOAT Hsize:lableH stringName:nameString];
        
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0*HEIGHT_SIZE+Nsize*i, nameSize.width,lableH )];
        PV1Lable.text=nameString;
        PV1Lable.tag=4000+i;
        PV1Lable.textAlignment=NSTextAlignmentLeft;
        PV1Lable.textColor=COLOR(51, 51, 51, 1);
        PV1Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        [_scrollView addSubview:PV1Lable];
        
        if (i==1) {
            _registLable=[[UILabel alloc]initWithFrame:CGRectMake(12*NOW_SIZE+nameSize.width, 0*HEIGHT_SIZE+Nsize*i, SCREEN_Width-37*NOW_SIZE-nameSize.width,lableH )];
            _registLable.text=alertArray[i];
            _registLable.textAlignment=NSTextAlignmentLeft;
           _registLable.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable)];
            [_registLable addGestureRecognizer:labelTap];
            _registLable.textColor=COLOR(51, 51, 51, 1);
            _registLable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:_registLable];
            
            UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-15*NOW_SIZE-8*HEIGHT_SIZE, 13*HEIGHT_SIZE+Nsize*i, 6*HEIGHT_SIZE,14*HEIGHT_SIZE )];
            image1.userInteractionEnabled=YES;
            image1.image=IMAGE(@"select_icon.png");
             UITapGestureRecognizer *labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable)];
               [image1 addGestureRecognizer:labelTap1];
         [_scrollView addSubview:image1];

        }else{
            UITextField *textF=[[UITextField alloc]initWithFrame:CGRectMake(12*NOW_SIZE+nameSize.width, 0*HEIGHT_SIZE+Nsize*i, SCREEN_Width-22*NOW_SIZE-nameSize.width,lableH )];
            textF.textAlignment=NSTextAlignmentLeft;
            textF.placeholder = alertArray[i];
            textF.tintColor =COLOR(51, 51, 51, 1);
            textF.textColor=COLOR(51, 51, 51, 1);
            textF.tag=6000+i;
            [textF setValue:COLOR(153, 153, 153, 1) forKeyPath:@"_placeholderLabel.textColor"];
            [textF setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
            textF.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
            [_scrollView addSubview:textF];
            
            if(i==2){
             
                textF.frame=CGRectMake(12*NOW_SIZE+nameSize.width, 0*HEIGHT_SIZE+Nsize*i, SCREEN_Width-22*NOW_SIZE-nameSize.width-55*NOW_SIZE,lableH );
                UILabel *L2=[[UILabel alloc]initWithFrame:CGRectMake(textF.frame.origin.x+textF.frame.size.width, 0*HEIGHT_SIZE+Nsize*i, 55*NOW_SIZE,lableH )];
                L2.text=root_WO_dianji_huoqu;
                L2.textAlignment=NSTextAlignmentLeft;
                L2.userInteractionEnabled=YES;
                L2.adjustsFontSizeToFitWidth=YES;
                UITapGestureRecognizer *labelTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getSN)];
                [L2 addGestureRecognizer:labelTap2];
                L2.textColor=COLOR(51, 51, 51, 1);
                L2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
        
                if (_SNArray.count>0) {
                            [_scrollView addSubview:L2];
                }
            }
            
            if(i==3){
                textF.delegate=self;
                textF.frame=CGRectMake(12*NOW_SIZE+nameSize.width, 0*HEIGHT_SIZE+Nsize*i, SCREEN_Width-22*NOW_SIZE-nameSize.width-50*NOW_SIZE,lableH );
               NSString *TelNumber=[[NSUserDefaults standardUserDefaults] objectForKey:@"TelNumber"];
                if (TelNumber==nil || TelNumber==NULL||([TelNumber isEqualToString:@""] )){
                }else{
                    textF.text=TelNumber;
                }
                UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(textF.frame.origin.x+textF.frame.size.width, 0*HEIGHT_SIZE+Nsize*i, 55*NOW_SIZE,lableH )];
                UITapGestureRecognizer *labelTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo)];
                [lineV addGestureRecognizer:labelTap2];
                lineV.backgroundColor=[UIColor clearColor];
                [_scrollView addSubview:lineV];
                
                UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(37*NOW_SIZE, 13*HEIGHT_SIZE, 6*NOW_SIZE,14*HEIGHT_SIZE )];
                image2.userInteractionEnabled=YES;
                image2.image=IMAGE(@"select_icon.png");
                UITapGestureRecognizer *labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapInfo)];
                [image2 addGestureRecognizer:labelTap1];
                [lineV addSubview:image2];
                
            }
            
        }
        
        UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, lableH+Nsize*i, SCREEN_Width-20*NOW_SIZE, LineWidth)];
        lineV.backgroundColor=COLOR(222, 222, 222, 1);
        [_scrollView addSubview:lineV];
        
    }
    
    UIView *lineV3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, lableH+Nsize*4-10*HEIGHT_SIZE, SCREEN_Width-20*NOW_SIZE, LineWidth)];
    lineV3.backgroundColor=COLOR(222, 222, 222, 1);
    [_scrollView addSubview:lineV3];
    

    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(10*NOW_SIZE, Nsize*5, 300*NOW_SIZE,100*HEIGHT_SIZE )];
    _contentView.text=root_xiangguang_wenti_miaoshu;
    self.contentView.textColor = COLOR(153, 153, 153, 1);
    self.contentView.tintColor = COLOR(153, 153, 153, 1);
    _contentView.textAlignment=NSTextAlignmentLeft;
    _contentView.delegate=self;
    self.contentView.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:_contentView];
    
    UIView *lineV4=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, Nsize*5+100*HEIGHT_SIZE , SCREEN_Width-20*NOW_SIZE, LineWidth)];
    lineV4.backgroundColor=COLOR(222, 222, 222, 1);
    [_scrollView addSubview:lineV4];
    
//     float H2=self.navigationController.navigationBar.frame.size.height;
    float H1=[[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height;
    _imageViewAll = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_Height-imageH-H1, SCREEN_Width,imageH )];
    _imageViewAll.backgroundColor =COLOR(242, 242, 242, 1);
    _imageViewAll.userInteractionEnabled = YES;
    [self.view addSubview:_imageViewAll];
    
    UIView *VI = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-imageH-10*NOW_SIZE, 0*HEIGHT_SIZE, imageH,imageH )];
    VI.backgroundColor =[UIColor clearColor];
    VI.userInteractionEnabled = YES;
    UITapGestureRecognizer * forget1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto)];
    [VI addGestureRecognizer:forget1];
    [_imageViewAll addSubview:VI];
    
    UIImageView *image4=[[UIImageView alloc]initWithFrame:CGRectMake(18*NOW_SIZE, 15*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image4.userInteractionEnabled = YES;
    image4.image = IMAGE(@"pic_icon.png");
    [VI addSubview:image4];
    
    NSString *isValiPhone=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiPhone"];
    NSString *isValiEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiEmail"];
       NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"TelNumber"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:is_Test] isEqualToString:@"Y"]) {         //测试模块
        isValiPhone=@"1";
       phoneNum=@"18588241101";
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isValiPhone"];
    }
    
    if ([isValiPhone isEqualToString:@"1"]) {
            UITextField *text=[_scrollView viewWithTag:6003];
        text.text=phoneNum;
    }else{
        if ([isValiEmail isEqualToString:@"1"]) {
            NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
            UITextField *text=[_scrollView viewWithTag:6003];
            text.text=phoneNum;
            UILabel *lable=[_scrollView viewWithTag:4003];
            lable.text=root_youxiang;
            _phoneOrEmail=@"2";
        }else{
           [self showAlert];
        }
    }
 
    
}




- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([_contentView.text isEqualToString:root_xiangguang_wenti_miaoshu]) {
        
        _contentView.text = @"";
        self.contentView.textColor = COLOR(51, 51, 51, 1);
        self.contentView.tintColor = COLOR(51, 51, 51, 1);
        
    }
    
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_contentView.text.length<1) {
        _contentView.text = root_xiangguang_wenti_miaoshu;
        self.contentView.textColor = COLOR(153, 153, 153, 1);
        self.contentView.tintColor = COLOR(153, 153, 153, 1);
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString* text=textField.text;
    if (text==nil || text==NULL||([text isEqualToString:@""] )){
        
    }else{
       //  NSString *email=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
       //  NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"];
         NSString *isValiPhone=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiPhone"];
       NSString *isValiEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiEmail"];
    
        if ([_phoneOrEmail isEqualToString:@"1"]) {
            if ([isValiPhone isEqualToString:@"1"]) {
                [self removeAlert];
            }else{
                [self showAlert];
            }
        }else if ([_phoneOrEmail isEqualToString:@"2"]){
            if ([isValiEmail isEqualToString:@"1"]) {
                [self removeAlert];
            }else{
                [self showAlert];
            }
        }
        
    }

}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    UITextField *textF=[_scrollView viewWithTag:6000];
      UITextField *textF2=[_scrollView viewWithTag:6002];
       UITextField *textF3=[_scrollView viewWithTag:6003];
       UITextField *textF4=[_scrollView viewWithTag:6004];
     [textF resignFirstResponder];
     [textF2 resignFirstResponder];
     [textF3 resignFirstResponder];
     [textF4 resignFirstResponder];
    [_contentView resignFirstResponder];
    

   
}


-(void)finishDone{
    

    
    UITextField *textF=[_scrollView viewWithTag:6000];
    UITextField *textF2=[_scrollView viewWithTag:6002];
    UITextField *textF3=[_scrollView viewWithTag:6003];
    UITextField *textF4=[_scrollView viewWithTag:6004];

    
    if ([_phoneOrEmail isEqualToString:@"1"]) {
        NSString *isValiPhone=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiPhone"];
        if (![isValiPhone isEqualToString:@"1"]) {
            [self showToastViewWithTitle:root_yanzheng_shouji];
            return;
        }
    }
    
    if ([_phoneOrEmail isEqualToString:@"2"]) {
        NSString *isValiEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiEmail"];
        if (![isValiEmail isEqualToString:@"1"]) {
            [self showToastViewWithTitle:root_yanzheng_youxiang];
            return;
        }
    }
    
      NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *picAll=[NSMutableArray arrayWithArray:_picArray];
[picAll removeObject:@"del"];
    for (int i=0; i<picAll.count; i++) {
         NSData *imageData = UIImageJPEGRepresentation(picAll[i], 0.5);
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
            [dataImageDict setObject:imageData forKey:imageName];
    }
    
    _allDict=[NSMutableDictionary dictionary];
    
    if ([[textF text] isEqual:@""]) {
        [self showToastViewWithTitle:root_ME_biaoti_shuru];
        return;
    }
    if (!_typeName) {
        [self showToastViewWithTitle:root_ME_wenti_leixing_xuanzhe];
        return;
    }
    if ([[textF2 text] isEqual:@""]) {
        [self showToastViewWithTitle:root_ME_xuliehao_shuru];
        return;
    }
    if( ([[textF3 text] isEqual:@""]) &&([[textF4 text] isEqual:@""])){
        [self showToastViewWithTitle:root_shuru_yizhong_lianxi_fangshi];
        return;
    }
  
    if ([[_contentView text] isEqual:@""]||[[_contentView text] isEqual:root_xiangguang_wenti_miaoshu]) {
        [self showToastViewWithTitle:root_ME_shuru_leirong];
        return;
    }
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    NSString *userName=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *counrtyName=[[NSUserDefaults standardUserDefaults] objectForKey:@"counrtyName"];

    NSString *serverAddress=[HEAD_URL substringFromIndex:7];
    [_allDict setObject:serverAddress forKey:@"serverUrl"];
      [_allDict setObject:counrtyName forKey:@"counrtyName"];
     [_allDict setObject:userName forKey:@"userName"];
    
    [_allDict setObject:[textF text] forKey:@"title"];
   [_allDict setObject:_typeNum forKey:@"questionType"];
    [_allDict setObject:[textF2 text] forKey:@"questionDevice"];
    [_allDict setObject:[_contentView text] forKey:@"content"];
       [_allDict setObject:userID forKey:@"userId"];
    if ([_phoneOrEmail isEqualToString:@"1"]) {
        [_allDict setObject:[textF3 text] forKey:@"phone"];
        [_allDict setObject:@"" forKey:@"email"];
    }else if ([_phoneOrEmail isEqualToString:@"2"]){
        [_allDict setObject:@"" forKey:@"phone"];
        [_allDict setObject:[textF3 text] forKey:@"email"];
    }
  
    //NSError *error;
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:OSS_HEAD_URL_Demo paramars:_allDict paramarsSite:@"/api/v2/question/add" dataImageDict:dataImageDict sucessBlock:^(id content) {
       
        [self hideProgressView];
        if (content) {
            id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"/api/v2/question/add==%@", content1);
            NSDictionary *firstDic=[NSDictionary dictionaryWithDictionary:content1];
            if ([firstDic[@"result"] intValue]==1) {
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_chenggong cancelButtonTitle:root_Yes];
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_shibai cancelButtonTitle:root_Yes];     
                [self.navigationController popViewControllerAnimated:NO];
            }
            }else{
                
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_shibai cancelButtonTitle:root_Yes];
                 [self.navigationController popViewControllerAnimated:NO];
            }
        }
     failure:^(NSError *error) {
               [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
   
    }];
    
}

-(void)controlPhoto{
   // [_picArray removeObject:@"del"];
    
    if (_image1 &&_image2 &&_image3) {
          [self showAlertViewWithTitle:nil message:root_shangchuan_sanzhang_tupian cancelButtonTitle:root_Yes];
    }else{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    
    float size5=70*NOW_SIZE;
    
    float imageH=40*HEIGHT_SIZE;  float imageX=20*NOW_SIZE; float ButtonImage=16*HEIGHT_SIZE;
 float imageH0=9*HEIGHT_SIZE;
    
    
    if(!_image1){
        [_picArray insertObject:image atIndex:0];
        _image1=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*0, imageH0, imageH,imageH )];
        _image1.userInteractionEnabled = YES;
        _image1.image = image;
        _image1.tag=1+3000;
        [_imageViewAll addSubview:_image1];
        
        _button1= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*0+imageH-ButtonImage/2, imageH0-ButtonImage/2, ButtonImage,ButtonImage)];
        [_button1 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button1.tag=2000+1;
        [_button1 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button1];
        
    }else if(_image1 && !_image2){
        [_picArray insertObject:image atIndex:1];
        _image2=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*1, imageH0, imageH,imageH )];
        _image2.userInteractionEnabled = YES;
        _image2.image = image;
        _image2.tag=2+3000;
        [_imageViewAll addSubview:_image2];
        
        _button2= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*1+imageH-ButtonImage/2, imageH0-ButtonImage/2, ButtonImage,ButtonImage)];
        [_button2 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button2.tag=2000+2;
        // _button2.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button2];
        
    }else if(_image1 && _image2 && !_image3){
        [_picArray insertObject:image atIndex:2];
        _image3=[[UIImageView alloc]initWithFrame:CGRectMake(imageX+size5*2, imageH0, imageH,imageH )];
        _image3.userInteractionEnabled = YES;
        _image3.image = image;
        _image3.tag=3+3000;
        [_imageViewAll addSubview:_image3];
        
        _button3= [[UIButton alloc] initWithFrame:CGRectMake(imageX+size5*2+imageH-ButtonImage/2, imageH0-ButtonImage/2, ButtonImage,ButtonImage)];
        [_button3 setImage:IMAGE(@"cancel_icon111.png") forState:UIControlStateNormal];
        _button3.tag=2000+3;
        //  _button3.titleLabel.font=[UIFont systemFontOfSize: 10*HEIGHT_SIZE];
        [_button3 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_imageViewAll addSubview:_button3];
    }
    
    
    //  picTime++;
    
}

-(void)delPicture:(UIButton*)del{
    //NSLog(@"del.tag=%ld",del.tag);
    //int a=del.tag;
    UIButton  *a=del;
    NSString *replaceName=@"del";

    [_picArray replaceObjectAtIndex:a.tag-2001 withObject:replaceName];
    
    if ((a.tag-2000)==1) {
         [_image1 removeFromSuperview];
         [_button1 removeFromSuperview];
        _image1=nil;
        _button1=nil;
    }else  if ((a.tag-2000)==2) {
        [_image2 removeFromSuperview];
        [_button2 removeFromSuperview];
        _image2=nil;
        _button2=nil;
    }else  if ((a.tag-2000)==3) {
        [_image3 removeFromSuperview];
        [_button3 removeFromSuperview];
        _image3=nil;
        _button3=nil;
    }

}


-(void)getSN{
    
    if (_SNArray.count>0) {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    
    for (int i=0; i<_SNArray.count; i++) {
        [alertController addAction: [UIAlertAction actionWithTitle: _SNArray[i] style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            self.SNTextField.text=_SnOnlyArray[i];
//            self.SNTextField.textColor=[UIColor blackColor];
            UITextField *textF=[_scrollView viewWithTag:6002];
            textF.text=_SnOnlyArray[i];
  
        }]];
    }
     [self presentViewController: alertController animated: YES completion: nil];
    }
    
}

-(void)removeAlert{
    UITextField *A=[_scrollView viewWithTag:6003];
    
    if ([_phoneOrEmail isEqualToString:@"1"]) {
       NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"TelNumber"];
        A.text=phoneNum;
    }
    if ([_phoneOrEmail isEqualToString:@"2"]) {
        NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        A.text=phoneNum;
    }
    
    if (_imageV5) {
        [_imageV5 removeFromSuperview];
        _imageV5=nil;
    }
    
}


-(void)tapInfo{
    NSArray *infoArray=[NSArray arrayWithObjects:root_shoujihao,root_youxiang, nil];
    [ZJBLStoreShopTypeAlert showWithTitle:root_xuanzhe_lianxi_fangshi titles:infoArray selectIndex:^(NSInteger selectIndex) {
        if (_imageV5) {
            [_imageV5 removeFromSuperview];
            _imageV5=nil;
        }
        
        int A=selectIndex;
        _phoneOrEmail=[NSString stringWithFormat:@"%d",A+1];
        UITextField *text=[_scrollView viewWithTag:6003];
        if (selectIndex==0) {
            text.placeholder=root_Enter_phone_number;
        }else{
         text.placeholder=root_WO_shuru_youxiang;
        }
        
        NSString *isValiPhone=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiPhone"];
        NSString *isValiEmail=[[NSUserDefaults standardUserDefaults] objectForKey:@"isValiEmail"];
        
        if ([_phoneOrEmail isEqualToString:@"1"]) {
               UITextField *text=[_scrollView viewWithTag:6003];
            if ([isValiPhone isEqualToString:@"1"]) {
                NSString *phoneNum=[[NSUserDefaults standardUserDefaults] objectForKey:@"TelNumber"];
                text.text=phoneNum;
                
            }else{
                text.text=nil;
                  [self showAlert];
            }
            
        }
        
        if ([_phoneOrEmail isEqualToString:@"2"]) {
            UITextField *text=[_scrollView viewWithTag:6003];
            if ([isValiEmail isEqualToString:@"1"]) {
                NSString *email=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
                text.text=email;
            }else{
                text.text=nil;
                  [self showAlert];
            }
            
        }
        
        
        
        
        
    }selectValue:^(NSString *selectValue){
        UILabel *lable=[_scrollView viewWithTag:4003];
        lable.text=selectValue;
    
    } showCloseButton:YES ];
    
}


-(void)showAlert{
    if (_imageV5) {
        [_imageV5 removeFromSuperview];
        _imageV5=nil;
    }
    
    _imageV5=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 38*HEIGHT_SIZE+(42*HEIGHT_SIZE)*3, SCREEN_Width-20*NOW_SIZE, 40*HEIGHT_SIZE)];
    _imageV5.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToVerification)];
    [_imageV5 addGestureRecognizer:labelTap];
    _imageV5.image = IMAGE(@"pop_frame.png");
    [_scrollView addSubview:_imageV5];
    
    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(8*NOW_SIZE, 0*HEIGHT_SIZE, SCREEN_Width-36*NOW_SIZE,40*HEIGHT_SIZE )];
    PV1Lable.text=root_shouji_meiyou_yanzheng;
    if ([_phoneOrEmail isEqualToString:@"2"]) {
        PV1Lable.text=root_youxiang_meiyou_yanzheng;
    }
    PV1Lable.textAlignment=NSTextAlignmentCenter;
    PV1Lable.textColor=MainColor;
    PV1Lable.adjustsFontSizeToFitWidth=YES;
    PV1Lable.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_imageV5 addSubview:PV1Lable];
}


-(void)goToVerification{
    UITextField *phoneText=[_scrollView viewWithTag:6003];
    OssMessageViewController *OSSView=[[OssMessageViewController alloc]init];
    OSSView.firstPhoneNum=phoneText.text;
    OSSView.addQuestionType=_phoneOrEmail;
    [self.navigationController pushViewController:OSSView animated:NO];

    
    
}

-(void)tapLable{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_nibianqi_guzhan style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       _typeName=root_ME_nibianqi_guzhan;
        _typeNum=@"1";
        
          self.registLable.text=_typeName;
       
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_chunengji_guzhan style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      _typeName=root_ME_chunengji_guzhan;
         _typeNum=@"2";
          self.registLable.text=_typeName;
     
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_ruanjian_jianyi style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    _typeName=root_ME_ruanjian_jianyi;
          self.registLable.text=_typeName;
         _typeNum=@"3";
   
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_ruanjian_guzhan style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        _typeName=root_ME_ruanjian_guzhan;
         _typeNum=@"4";
          self.registLable.text=_typeName;

    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_qita_shebei_guzhan style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        _typeName=root_ME_qita_shebei_guzhan;
         _typeNum=@"5";
          self.registLable.text=_typeName;
   
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_qita_wenti style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        _typeName=root_ME_qita_wenti;
          _typeNum=@"6";
          self.registLable.text=_typeName;
 
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
  
    [self presentViewController: alertController animated: YES completion: nil];


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
