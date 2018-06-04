//
//  Header.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "UserInfo.h"
#import "BaseRequest.h"
#import "MBProgressHUD.h"
#import "RootViewController.h"
#import "CoreDataManager.h"
#import "SafeObject.h"

#define ManagerObjectModelFileName @"deviceCore" //数据库名字

//#define _NAME
//#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_NAME]]
#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:([_NAME hasSuffix:@".png"])?(_NAME):([_NAME stringByAppendingString:@".png"])]]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define NOW_SIZE [UIScreen mainScreen].bounds.size.width/320


#define NavigationbarHeight  self.navigationController.navigationBar.frame.size.height
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define LineWidth  [UIScreen mainScreen].bounds.size.height*0.5/560

#define MainColor COLOR(0, 156, 255, 1)
//#define MainColor COLOR(17, 183, 243, 1)

#define mainColor [UIColor colorWithRed:0/255.0f green:156/255.0f blue:255/255.0f alpha:1]
//#define mainColor [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1]

#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define colorGary COLOR(221, 221, 221, 1)
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define KNOTIFICATION_LOGINCHANGE                      @"loginStateChange"
 #define Get_Net_time  25.f
 #define TCP_hide_time  0.2f

 #define Head_Url_more  @"http://cdn.growatt.com/publish"


 #define Demo_Name  @"guest"
 #define Demo_password  @"123456"


#define HEAD_URL_Demo  @"http://server.growatt.com"
#define HEAD_URL_Demo_CN  @"http://server-cn.growatt.com"
#define HEAD_URL  [UserInfo defaultUserInfo].server
#define OSS_HEAD_URL_Demo  @"http://oss1.growatt.com"
#define OSS_HEAD_URL  [UserInfo defaultUserInfo].OSSserver
#define OSS_HEAD_URL_Demo_2  @"http://oss.growatt.com"

//#define OSS_HEAD_URL_Demo  @"http://47.91.176.158"
//#define OSS_HEAD_URL  @"http://47.91.176.158"
//#define OSS_HEAD_URL_Demo_2  @"http://47.91.176.158"
//demo for server

//#define HEAD_URL   @"http://test.growatt.com"
//#define HEAD_URL_Demo  @"http://test.growatt.com"
//#define HEAD_URL_Demo_CN  @"http://test.growatt.com"

#define is_Test @"isTest"
//
//#define HEAD_URL   @"http://192.168.3.214:8081/ShineServer_2016"
//#define HEAD_URL_Demo  @"http://192.168.3.214:8081/ShineServer_2016"
//#define HEAD_URL_Demo_CN  @"http://192.168.3.214:8081/ShineServer_2016"
//#define OSS_HEAD_URL_Demo  @"http://192.168.3.214:8080/ShineOSS"
//#define OSS_HEAD_URL @"http://192.168.3.214:8080/ShineOSS"
//#define OSS_HEAD_URL_Demo_2  @"http://192.168.3.214:8080/ShineOSS"
//
//#define HEAD_URL   @"http://192.168.3.35:8081"
//#define HEAD_URL_Demo  @"http://192.168.3.35:8081"
//#define HEAD_URL_Demo_CN  @"http://192.168.3.35:8081"

//#define HEAD_URL   @"http://ftp.growatt.com"
//#define HEAD_URL_Demo  @"http://ftp.growatt.com"
//#define HEAD_URL_Demo_CN  @"http://ftp.growatt.com"


#define tcp_IP  @"192.168.10.100"
#define tcp_port  5280




#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define deviceSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Is_Iphone_X (Is_Iphone && ScreenHeight == 812.0)
#define NaviHeight Is_Iphone_X ? 88 : 64
#define TabbarHeight Is_Iphone_X ? 83 : 49
#define BottomHeight Is_Iphone_X ? 34 : 0

#define HEIGHT_SIZE1  ([UIScreen mainScreen].bounds.size.height/560)
#define HEIGHT_SIZE2  ([UIScreen mainScreen].bounds.size.height/812)

//#define HEIGHT_SIZE  ([UIScreen mainScreen].bounds.size.height/560)
#define HEIGHT_SIZE (Is_Iphone_X ? HEIGHT_SIZE2 : HEIGHT_SIZE1)
#define iphonexH 200*HEIGHT_SIZE


#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//设置 view 圆角和边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#endif /* Header_h */


//获取String长度
//NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:16*HEIGHT_SIZE] forKey:NSFontAttributeName];
//CGSize size = [root_demo_test boundingRectWithSize:CGSizeMake(MAXFLOAT, 40*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;



