//
//  HtmlCommon.m
//  ShineLink
//
//  Created by sky on 16/8/10.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "HtmlCommon.h"
#import "LWLoadingView.h"
#import "addServerViewController.h"
#import "UIImageView+AFNetworking.h"


@interface HtmlCommon ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    UIView *bgView;
    UIImageView *imgView;
    UIScrollView *borderView;
}
@property (nonatomic,strong) UIWebView* webView;
@property (nonatomic,strong) NSString* HtmlContent;

@end

@implementation HtmlCommon

- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor = [UIColor whiteColor];
   // self.navigationController.navigationBar.hidden=YES;
    
    self.view.userInteractionEnabled=NO;
      [self showProgressView];
    [self getNet];
    
    
}

-(void)getNet{

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
       // [self hideProgressView];
        NSLog(@"getUsualQuestionInfo=: %@", content);
        
        if(content){
           
            _HtmlContent=content[@"content"];
            
            [self initUI];
        }else{
        [self hideProgressView];
              self.view.userInteractionEnabled=YES;
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
         self.view.userInteractionEnabled=YES;
        
    }];


}

-(void)initUI{
    float Height1=460;
    
    NSString *serviceBool=[[NSUserDefaults standardUserDefaults]objectForKey:@"serviceBool"];
    
    //serviceBool=@"0";
    
    if ([serviceBool isEqualToString:@"1"]) {
     self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, Height1*HEIGHT_SIZE)];
    }else{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    
    
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
//    _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//    _webView.scalesPageToFit=YES;
//    _webView.multipleTouchEnabled=YES;
//    _webView.userInteractionEnabled=YES;
    
    
//_HtmlContent=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"view" ofType:@"html"] encoding:NSUTF8StringEncoding error:NULL];
//    _HtmlContent=@"http://chat.growatt.com/ChatRoom/chatPhone/custom";
//    NSURL *URL=[NSURL URLWithString:_HtmlContent];
//    [self.webView loadHTMLString:nil baseURL:URL];
    
[self.webView loadHTMLString:_HtmlContent baseURL:nil];
    
    
 if ([serviceBool isEqualToString:@"1"]) {
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (Height1)*HEIGHT_SIZE, SCREEN_Width,5*HEIGHT_SIZE)];
    lineView.backgroundColor=COLOR(228, 235, 245, 1);
     [self.view addSubview:lineView];
    
    NSString *PV2LableContent=root_haimei_jiejue_wenti;
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, 150*NOW_SIZE,30*HEIGHT_SIZE)];
    PV2Lable.text=PV2LableContent;
    PV2Lable.backgroundColor=[UIColor whiteColor];
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=COLOR(113, 113, 113, 1);
    PV2Lable.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
     PV2Lable.adjustsFontSizeToFitWidth=YES;
    NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:16*HEIGHT_SIZE],};
    CGSize textSize1 = [PV2LableContent boundingRectWithSize:CGSizeMake(180*NOW_SIZE,30*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
    [PV2Lable setFrame:CGRectMake(10*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, textSize1.width, 30*HEIGHT_SIZE)];
    [self.view addSubview:PV2Lable];
    
    
    NSString *lable3Content=root_xiang_kefu_tiwen;
    UILabel *Lable3=[[UILabel alloc]initWithFrame:CGRectMake(180*NOW_SIZE, (Height1+5)*HEIGHT_SIZE, 150*NOW_SIZE,30*HEIGHT_SIZE)];
    Lable3.text=lable3Content;
    Lable3.backgroundColor=[UIColor whiteColor];
    Lable3.textAlignment=NSTextAlignmentLeft;
    Lable3.textColor=MainColor;
    Lable3.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
       Lable3.adjustsFontSizeToFitWidth=YES;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16*HEIGHT_SIZE],};
    CGSize textSize = [lable3Content boundingRectWithSize:CGSizeMake(180*NOW_SIZE,30*HEIGHT_SIZE) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [Lable3 setFrame:CGRectMake(310*NOW_SIZE-textSize.width, (Height1+5)*HEIGHT_SIZE, textSize.width, 30*HEIGHT_SIZE)];
    
    Lable3.userInteractionEnabled=YES;
    UITapGestureRecognizer * addAnswer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAnswer)];
    [Lable3 addGestureRecognizer:addAnswer];
    [self.view addSubview:Lable3];
    
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(310*NOW_SIZE-textSize.width-22*HEIGHT_SIZE, (Height1+12)*HEIGHT_SIZE, 20*HEIGHT_SIZE,20*HEIGHT_SIZE )];
    image2.userInteractionEnabled = YES;
    UITapGestureRecognizer * addAnswer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addAnswer)];
    [image2 addGestureRecognizer:addAnswer1];
    image2.image = IMAGE(@"play_icon.png");
    [self.view addSubview:image2];

   }
    
    
}





-(void)addAnswer{
    addServerViewController *go=[[addServerViewController alloc]init];
     [self.navigationController pushViewController:go animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  //  [LWLoadingView showInView:self.view];
  
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[LWLoadingView hideInViwe:self.view];
    [self hideProgressView];
     self.view.userInteractionEnabled=YES;
    
    NSString *jsStr = @"function reSetImgFrame() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; i++) {\
    var img = imgs[i];   \
    img.width=%f; \
    img.removeAttribute('height');\
    } \
    var ps = document.getElementsByTagName('p'); \
    for(var i=0; i<ps.length;i++){ \
    ps[i].style.marginLeft='0px';\
    } \
    }";

//    NSString *jsStr2 = @"function reSetMarginFrame() { \
//    var ps = document.getElementsByTagName('p'); \
//    for(var i=0; i<ps.length;i++){ \
//    ps[i].style.marginLeft='0px';\
//    alert(1);\
//    } \
////    }; \
////    }";

  
    
    jsStr = [NSString stringWithFormat:jsStr, [UIScreen mainScreen].bounds.size.width];

    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    [webView stringByEvaluatingJavaScriptFromString:@"reSetImgFrame()"];
    
    
    
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
    [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    //    NSLog(@"requestString is %@",requestString);
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        //        NSLog(@"image url------%@", imageUrl);
        
        if (bgView) {
            //设置不隐藏，还原放大缩小，显示图片
            bgView.hidden = NO;
//            imgView.frame = CGRectMake(2*NOW_SIZE, 2*NOW_SIZE, SCREEN_Width-2*NOW_SIZE, 250*HEIGHT_SIZE-2*NOW_SIZE);
            [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:IMAGE(@"loading1.png")];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        else
            [self showBigImage:imageUrl];//创建视图并显示图片
        
        return NO;
    }
    return YES;
}


#pragma mark 显示大图片
-(void)showBigImage:(NSString *)imageUrl{
    //创建灰色透明背景，使其背后内容不可操作
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
//                                               green:0.3
//                                                blue:0.3
//                                               alpha:0.7]];
    [bgView setBackgroundColor:COLOR(212, 212, 212, 1)];
    [self.view addSubview:bgView];
    
    //创建边框视图
    borderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    //将图层的边框设置为圆脚
//    borderView.layer.cornerRadius = 8;
//    borderView.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
    borderView.layer.borderWidth = 1*NOW_SIZE;
    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
                                                    green:0.9
                                                     blue:0.9
                                                    alpha:0.7] CGColor];
    [borderView setCenter:bgView.center];
    [bgView addSubview:borderView];
    
    
    //设置实现缩放
    //设置代理scrollview的代理对象
    borderView.delegate=self;
    //设置最大伸缩比例
    borderView.maximumZoomScale=3.0;
    //设置最小伸缩比例
    borderView.minimumZoomScale=0.5;
    
//    //创建关闭按钮
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//   // closeBtn.backgroundColor = [UIColor redColor];
//    [closeBtn addTarget:self action:@selector(removeBigImage) forControlEvents:UIControlEventTouchUpInside];
//    [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-30*NOW_SIZE, borderView.frame.origin.y-25*HEIGHT_SIZE, 30*HEIGHT_SIZE, 30*HEIGHT_SIZE)];
//    [bgView addSubview:closeBtn];
    
    //创建显示图像视图
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(2*NOW_SIZE, 2*NOW_SIZE, CGRectGetWidth(borderView.frame)-2*NOW_SIZE, CGRectGetHeight(borderView.frame)-2*NOW_SIZE)];
    imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBigImage)];
    [imgView addGestureRecognizer:tap];
   
    [imgView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:IMAGE(@"loading1.png")];
    
  //  imgView.frame=CGRectMake(0, 0, imgView.image.size.width, imgView.image.size.height);
     imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    borderView.frame=CGRectMake(0, 0, imgView.frame.size.width,imgView.frame.size.height);
    borderView.contentSize=CGSizeMake(imgView.frame.size.width+100*NOW_SIZE,imgView.frame.size.height+100*HEIGHT_SIZE);
    
    [borderView addSubview:imgView];
    
    
    
    
    //_scrollview.contentSize=image.size;
    
    
   

    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}


//关闭按钮
-(void)removeBigImage
{
    bgView.hidden = YES;
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    //缩放:设置缩放比例
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}



-(void)viewDidDisappear:(BOOL)animated{
    [_webView removeFromSuperview];
    _webView=nil;
    
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
