//
//  Common2ViewController.m
//  shinelink
//
//  Created by sky on 16/5/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "Common2ViewController.h"

@interface Common2ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextView *detail2;

@end

@implementation Common2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self netCom2];
}

-(void)netCom2{
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSString *_languageValue ;
    
    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
        _languageValue=@"0";
    }else if ([currentLanguage hasPrefix:@"en"]) {
        _languageValue=@"1";
    }else{
        _languageValue=@"2";
    }

    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_idString,@"language":_languageValue} paramarsSite:@"/questionAPI.do?op=getUsualQuestionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getUsualQuestionInfo=: %@", content);
        
        if(content){
            _contentString=content[@"content"];
            
             [self initUI];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,SCREEN_Height);
    [self.view addSubview:_scrollView];

//    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 16*HEIGHT_SIZE, 80*NOW_SIZE,28*HEIGHT_SIZE )];
//    PV1Lable.text=root_ME_biaoti;
//    PV1Lable.textAlignment=NSTextAlignmentCenter;
//    PV1Lable.textColor=[UIColor blackColor];
//    PV1Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
//    [_scrollView addSubview:PV1Lable];
    
    UIView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 42*HEIGHT_SIZE, 310*NOW_SIZE,LineWidth )];
    image1.backgroundColor=mainColor;
    [_scrollView addSubview:image1];
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 16*HEIGHT_SIZE, 300*NOW_SIZE,28*HEIGHT_SIZE )];
        PV2Lable.text=_titleString;
    PV2Lable.textAlignment=NSTextAlignmentCenter;
    PV2Lable.textColor=[UIColor blackColor];
    PV2Lable.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView addSubview:PV2Lable];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 50*HEIGHT_SIZE, 310*NOW_SIZE,400*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"kuang3.jpg");
    [_scrollView addSubview:image2];
    
    _detail2=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,55*HEIGHT_SIZE, 300*NOW_SIZE,380*HEIGHT_SIZE)];
    _detail2.text=_contentString;
    _detail2.editable=NO;
    _detail2.textAlignment=NSTextAlignmentLeft;
    _detail2.textColor=COLOR(60, 60, 60, 1);
    _detail2.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView addSubview:_detail2];
    
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
