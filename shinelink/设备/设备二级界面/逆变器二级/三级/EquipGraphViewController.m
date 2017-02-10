//
//  EquipGraphViewController.m
//  ShinePhone
//
//  Created by LinKai on 15/5/25.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "EquipGraphViewController.h"
#import "Line2View.h"
#import "EditGraphView.h"

#import "KongZhiNi.h"
#import "datailD2ViewController.h"

static const NSTimeInterval secondsPerDay = 24 * 60 * 60;

@interface EquipGraphViewController () <UIPickerViewDelegate, UIPickerViewDataSource,EditGraphViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *timeDisplayView;
@property (nonatomic, strong) UIButton *dayButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UIButton *yearButton;
@property (nonatomic, strong) UIButton *totalButton;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *currentMonth;
@property (nonatomic, strong) NSString *currentYear;

@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) NSMutableDictionary *monthDict;
@property (nonatomic, strong) NSMutableDictionary *yearDict;
@property (nonatomic, strong) NSMutableDictionary *totalDict;

@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSDateFormatter *monthFormatter;
@property (nonatomic, strong) NSDateFormatter *yearFormatter;
@property (nonatomic, strong) NSDateFormatter *onlyMonthFormatter;

@property (nonatomic, strong) NSMutableArray *yearsArr;
@property (nonatomic, strong) NSMutableArray *monthArr;

@property (nonatomic, strong) UIDatePicker *dayPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;
@property (nonatomic, strong) UIPickerView *yearPicker;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) Line2View *line2View;
@property(nonatomic,strong)EditGraphView *editGraph;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *timeDataArray;
@property (nonatomic, strong) NSMutableArray *dateDataArray;
@property (nonatomic, strong) NSString *timePickerType;

@property (nonatomic, strong) UILabel *upAlert;
@property (nonatomic, strong) UIImageView *upImage;
@end

@implementation EquipGraphViewController

- (void)viewWillAppear:(BOOL)animated {

    _type=@"1";
  self.navigationController.navigationBarHidden=NO;
    self.view.backgroundColor=MainColor;
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化PickerView 数据源
- (void)initData {
    self.yearsArr = [NSMutableArray array];
    for (int i = 1900; i<2100; i++) {
        [self.yearsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    self.monthArr = [NSMutableArray array];
    for (int i = 1; i<13; i++) {
        [self.monthArr addObject:[NSString stringWithFormat:@"%02d", i]];
    }
}

-(void)goDown{
    datailD2ViewController *go=[[datailD2ViewController alloc]init];
    go.SnID=_SnID;
    go.dateDataArray=[NSMutableArray arrayWithArray:_dateDataArray];
    go.timeDataArray=[NSMutableArray arrayWithArray:_timeDataArray];
    go.timePickerType=_timePickerType;
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;//可更改为其他方式
    transition.subtype = kCATransitionFromTop;//可更改为其他方式
    transition.duration = 0.6f;
     [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    if ([_timePickerType isEqualToString:@"1"]) {
         [self.navigationController pushViewController:go animated:YES];
    }
   
}

- (void)initUI {
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scrollView.scrollEnabled=YES;
        _scrollView.pagingEnabled = YES;
      self.scrollView.clipsToBounds = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,3*SCREEN_Height);
       [self.view addSubview:_scrollView];
    
//    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,SCREEN_Height-20*HEIGHT_SIZE,40*NOW_SIZE,SCREEN_Height)];
//     self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//    _pageControl.numberOfPages =2;
//    _pageControl.currentPage=0;
//      [self.view addSubview:self.pageControl];
 
    UISwipeGestureRecognizer *upMove=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goDown)];
     upMove.direction=UISwipeGestureRecognizerDirectionUp;
    [_scrollView addGestureRecognizer:upMove];
    
    
    self.dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dayButton.frame = CGRectMake(0 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*HEIGHT_SIZE);
    
    [self.dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [self.dayButton setTitle:root_DAY forState:UIControlStateNormal];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
    [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.dayButton.tag = 1000;
     _dayButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
 
 self.dayButton.selected = YES;
    [self.dayButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.dayButton];
    
    self.monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.monthButton.frame = CGRectMake(1 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*HEIGHT_SIZE);
    [self.monthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.monthButton.tag = 1001;
     _monthButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [self.monthButton setTitle:root_MONTH forState:UIControlStateNormal];
    [self.monthButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.monthButton];
    
    self.yearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yearButton.frame = CGRectMake(2 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*HEIGHT_SIZE);
    [self.yearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
    [self.yearButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.yearButton.tag = 1002;
    _yearButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [self.yearButton setTitle:root_YEAR forState:UIControlStateNormal];
    [self.yearButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.yearButton];
    
    self.totalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalButton.frame = CGRectMake(3 * SCREEN_Width/4, 0, SCREEN_Width/4, 40*HEIGHT_SIZE);
    [self.totalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateNormal];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateHighlighted];
    [self.totalButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*HEIGHT_SIZE)] forState:UIControlStateSelected];
    self.totalButton.tag = 1003;
    _totalButton.titleLabel.font=[UIFont systemFontOfSize: 16*HEIGHT_SIZE];
    [self.totalButton setTitle:root_TOTAL forState:UIControlStateNormal];
    [self.totalButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.totalButton];
    
    
    //
    self.timeDisplayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 + 40*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE)];
    self.timeDisplayView.backgroundColor = COLOR(87, 208, 250, 1);
    [_scrollView addSubview:self.timeDisplayView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_Width - 120*NOW_SIZE)/2, 4*HEIGHT_SIZE, 120*NOW_SIZE, 30*HEIGHT_SIZE - 8*HEIGHT_SIZE)];
   // bgImageView.backgroundColor=COLOR(123, 239, 227, 1);
   bgImageView.image = IMAGE(@"rili.png");
    bgImageView.userInteractionEnabled = YES;
    [self.timeDisplayView addSubview:bgImageView];
    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastButton.frame = CGRectMake(0, 0, 22*HEIGHT_SIZE, 22*HEIGHT_SIZE);
    [self.lastButton setImage:IMAGE(@"shang.png") forState:UIControlStateNormal];
    //self.lastButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.lastButton.tag = 1004;
    [self.lastButton addTarget:self action:@selector(lastDate:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.lastButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(CGRectGetWidth(bgImageView.frame) - 22*NOW_SIZE, 0, 22*HEIGHT_SIZE, 22*HEIGHT_SIZE);
    [self.nextButton setImage:IMAGE(@"xia.png") forState:UIControlStateNormal];
    //self.nextButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
    self.nextButton.tag = 1005;
    [self.nextButton addTarget:self action:@selector(nextDate:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.nextButton];
    
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
    self.monthFormatter = [[NSDateFormatter alloc] init];
    [self.monthFormatter setDateFormat:@"yyyy-MM"];
    self.yearFormatter = [[NSDateFormatter alloc] init];
    [self.yearFormatter setDateFormat:@"yyyy"];
    self.onlyMonthFormatter = [[NSDateFormatter alloc] init];
    [self.onlyMonthFormatter setDateFormat:@"MM"];
    
    self.datePickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.datePickerButton.frame = CGRectMake(22*NOW_SIZE, 0, CGRectGetWidth(bgImageView.frame) - 44*NOW_SIZE, 22*HEIGHT_SIZE);
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
    self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.datePickerButton setTitleColor:COLOR(7, 64, 52, 1) forState:UIControlStateNormal];
    self.datePickerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:10*HEIGHT_SIZE];
    [self.datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:self.datePickerButton];
    
    [self showProgressView];
    
    NSDictionary *dicGo=[NSDictionary new];
    if ([_dicType isEqualToString:@"2"]) {
       dicGo=@{@"plantId":_dictInfo[@"equipId"],@"date":self.currentDay} ;
    }else{
  dicGo=@{@"id":_dictInfo[@"equipId"],@"type":@"1", @"date":self.currentDay} ;
    }
  [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:_dictInfo[@"daySite"] sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"dayDate:%@",content);
        if (content) {
             if ([_dicType isEqualToString:@"2"]) {
                 if ([content[@"back"][@"success"] boolValue] == true) {
                     self.dayDict = [NSMutableDictionary dictionaryWithDictionary:content[@"back"][@"data"]];
                 }
             }else{
             NSMutableDictionary *dayDict0=[NSMutableDictionary new];
            if (content[@"invPacData"]) {
                [dayDict0 addEntriesFromDictionary:[content objectForKey:@"invPacData"]];
                // NSMutableDictionary *dayDict0=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
            }else{
                [dayDict0 addEntriesFromDictionary:content];
            }
            self.dayDict=[NSMutableDictionary new];
            for (NSString *key in dayDict0) {
                NSRange rang = NSMakeRange(11, 5);
                NSString *key0=[key substringWithRange:rang];
                NSString *value0=dayDict0[key];
                [_dayDict setValue:value0 forKey:key0];
            }
             }
            
            self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeDisplayView.frame), SCREEN_Width, SCREEN_Height - self.tabBarController.tabBar.frame.size.height - CGRectGetMaxY(self.timeDisplayView.frame)-50*HEIGHT_SIZE)];
            self.line2View.flag=@"1";
               self.line2View.frameType=@"2";
            [_scrollView addSubview:self.line2View];
          //  _dateDataArray=[NSMutableArray arrayWithArray:[_dayDict allValues]];
           // _timeDataArray=[NSMutableArray arrayWithArray:[_dayDict allKeys]];
            
            NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
            NSComparator sort = ^(NSString *obj1, NSString *obj2){
                NSRange range = NSMakeRange(0, obj1.length);
                return [obj1 compare:obj2 options:comparisonOptions range:range];
            };
            _timeDataArray = [NSMutableArray arrayWithArray:[_dayDict.allKeys sortedArrayUsingComparator:sort]];
            _dateDataArray = [NSMutableArray array];
            for (NSString *key in _timeDataArray) {
                [_dateDataArray addObject:_dayDict[key]];
            }
            _timePickerType=@"1";
            [self.line2View refreshLineChartViewWithDataDict: self.dayDict];
            
            self.line2View.energyTitleLabel.text = root_Today_Energy;
            self.line2View.unitLabel.text = root_Powre;
            
           _upImage= [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/2-10*HEIGHT_SIZE, CGRectGetMaxY(self.line2View.frame)+0*HEIGHT_SIZE, 20*HEIGHT_SIZE, 12*HEIGHT_SIZE )];
                  _upImage.image = IMAGE(@"upGo.png");
             [_upImage.layer addAnimation:[self opacityForever_Animation:2] forKey:nil];
            [_scrollView addSubview:_upImage];
            
            _upAlert=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width/2-100*HEIGHT_SIZE, CGRectGetMaxY(self.line2View.frame)+12*HEIGHT_SIZE, 200*NOW_SIZE, 20*HEIGHT_SIZE)];
            _upAlert.text=root_shanghua_chakan_shuju;
            _upAlert.textAlignment=NSTextAlignmentCenter;
            _upAlert.textColor=[UIColor whiteColor];
            _upAlert.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
             [_upAlert.layer addAnimation:[self opacityForever_Animation:2] forKey:nil];
            [_scrollView addSubview:_upAlert];
            
            _selectButton=[[UIButton alloc]initWithFrame:CGRectMake(90*NOW_SIZE, 50*HEIGHT_SIZE, 230*NOW_SIZE, 30*HEIGHT_SIZE)];
            [_selectButton setTitle:_dict[@"1"] forState:0];
            [_selectButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
            _selectButton.backgroundColor = COLOR(39, 183, 99, 1);
            _selectButton.layer.cornerRadius = 5*HEIGHT_SIZE;
            _selectButton.clipsToBounds = YES;
            [_line2View addSubview:_selectButton];
            _scrollView.contentSize=CGSizeMake(SCREEN_Width, CGRectGetMaxY(_line2View.frame)+20*HEIGHT_SIZE);
            
            UIImageView *selectView = [[UIImageView alloc] initWithFrame:CGRectMake(230*NOW_SIZE-25*HEIGHT_SIZE, 9*HEIGHT_SIZE, 15*HEIGHT_SIZE, 12*HEIGHT_SIZE)];
            // bgImageView.backgroundColor=COLOR(123, 239, 227, 1);
            selectView.image = IMAGE(@"triangular2.png");
            [self.selectButton addSubview:selectView];
            
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
    }];
    
}





#pragma mark - 获取、保存曲线图数据
- (void)requestDayDatasWithDayString:(NSString *)datString {
   //@"id":_dictInfo[@"equipId"]
    NSDictionary *dicGo=[NSDictionary new];
    if ([_dicType isEqualToString:@"2"]) {
        dicGo=@{@"plantId":_dictInfo[@"equipId"],@"date":self.currentDay} ;
    }else{
        dicGo=@{@"id":_dictInfo[@"equipId"],@"type":_type, @"date":self.currentDay} ;
    }
    
        [self showProgressView];
        [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:_dictInfo[@"daySite"] sucessBlock:^(id content) {
             NSLog(@"day: %@", content);
            [self hideProgressView];
             NSMutableDictionary *dayDict0=[NSMutableDictionary new];
            if (content) {
                
                if (content[@"invPacData"]) {
                    [dayDict0 addEntriesFromDictionary:[content objectForKey:@"invPacData"]];
                   // NSMutableDictionary *dayDict0=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
                }else{
                    [dayDict0 addEntriesFromDictionary:content];
                }
                   self.dayDict=[NSMutableDictionary new];
                for (NSString *key in dayDict0) {
                    NSRange rang = NSMakeRange(11, 5);
                    NSString *key0=[key substringWithRange:rang];
                    NSString *value0=dayDict0[key];
                    [_dayDict setValue:value0 forKey:key0];
                }
                NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
                NSComparator sort = ^(NSString *obj1, NSString *obj2){
                    NSRange range = NSMakeRange(0, obj1.length);
                    return [obj1 compare:obj2 options:comparisonOptions range:range];
                };
                _timeDataArray = [NSMutableArray arrayWithArray:[_dayDict.allKeys sortedArrayUsingComparator:sort]];
                _dateDataArray = [NSMutableArray array];
                for (NSString *key in _timeDataArray) {
                    [_dateDataArray addObject:_dayDict[key]];
                }
                _timePickerType=@"1";
                
                  [_scrollView addSubview:_upImage];
                   [_scrollView addSubview:_upAlert];
                [self.line2View refreshLineChartViewWithDataDict:_dayDict];
            }
            
        } failure:^(NSError *error) {
            [self hideProgressView];
        }];
//    }
}

- (void)requestMonthDatasWithMonthString:(NSString *)monthString {

    NSDictionary *dicGo=[NSDictionary new];
    if ([_dicType isEqualToString:@"2"]) {
        dicGo=@{@"plantId":_dictInfo[@"equipId"],@"date":monthString} ;
    }else{
        dicGo=@{@"id":_dictInfo[@"equipId"],@"type":_type, @"date":monthString} ;
    }
        [self showProgressView];
        [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:_dictInfo[@"monthSite"] sucessBlock:^(id content) {
            NSLog(@"month: %@", content);
            [self hideProgressView];
            if (content) {
                self.monthDict = [NSMutableDictionary dictionaryWithDictionary:content];
             //   _dateDataArray=[NSMutableArray arrayWithArray:[_monthDict allValues]];
           //     _timeDataArray=[NSMutableArray arrayWithArray:[_monthDict allKeys]];
                
                NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
                NSComparator sort = ^(NSString *obj1, NSString *obj2){
                    NSRange range = NSMakeRange(0, obj1.length);
                    return [obj1 compare:obj2 options:comparisonOptions range:range];
                };
                _timeDataArray = [NSMutableArray arrayWithArray:[_monthDict.allKeys sortedArrayUsingComparator:sort]];
                _dateDataArray = [NSMutableArray array];
                for (NSString *key in _timeDataArray) {
                    [_dateDataArray addObject:_monthDict[key]];
                }
                _timePickerType=@"2";
                
                [_upAlert removeFromSuperview];
                   [_upImage removeFromSuperview];
                
                [self.line2View refreshBarChartViewWithDataDict:content chartType:2];
            }
            
        } failure:^(NSError *error) {
            [self hideProgressView];
        }];
//    }
}

- (void)requestYearDatasWithYearString:(NSString *)yearString {
    NSDictionary *dicGo=[NSDictionary new];
    if ([_dicType isEqualToString:@"2"]) {
        dicGo=@{@"plantId":_dictInfo[@"equipId"],@"date":yearString} ;
    }else{
        dicGo=@{@"id":_dictInfo[@"equipId"],@"type":_type, @"date":yearString} ;
    }
        [self showProgressView];
        [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:_dictInfo[@"yearSite"] sucessBlock:^(id content) {
            NSLog(@"year: %@", content);
            [self hideProgressView];
            if (content) {
                self.yearDict = [NSMutableDictionary dictionaryWithDictionary:content];
                [_upAlert removeFromSuperview];
                [_upImage removeFromSuperview];
                
                [self.line2View refreshBarChartViewWithDataDict:content chartType:3];
            }
            
        } failure:^(NSError *error) {
            [self hideProgressView];
        }];
//    }
}

- (void)requestTotalDatas {
    NSDictionary *dicGo=[NSDictionary new];
    if ([_dicType isEqualToString:@"2"]) {
        dicGo=@{@"plantId":_dictInfo[@"equipId"]} ;
    }else{
        dicGo=@{@"id":_dictInfo[@"equipId"],@"type":_type,} ;
    }
        [self showProgressView];
        [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:dicGo paramarsSite:_dictInfo[@"allSite"] sucessBlock:^(id content) {
            [self hideProgressView];
               NSLog(@"totalData: %@", content);
            if (content) {
                self.yearDict = [NSMutableDictionary dictionaryWithDictionary:content];
                [_upAlert removeFromSuperview];
                [_upImage removeFromSuperview];
                
                [self.line2View refreshBarChartViewWithDataDict:content chartType:4];
            }
            
        } failure:^(NSError *error) {
            [self hideProgressView];
        }];
//    }
}

#pragma mark - 上一个时间  下一个时间  按钮事件
//上一个时间
- (void)lastDate:(UIButton *)sender {
    //日
    if (self.dayButton.selected) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *yesterday = [currentDayDate dateByAddingTimeInterval: -secondsPerDay];
        
        self.currentDay = [self.dayFormatter stringFromDate:yesterday];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self.dayDict removeAllObjects];
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    //月
    if (self.monthButton.selected) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i > 0 && j > 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j-1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        if (i > 0 && j == 0) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i-1], _monthArr[_monthArr.count - 1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    //年
    if (self.yearButton.selected) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i > 0) {
                    self.currentYear = _yearsArr[i-1];
                    [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                    [self.yearDict removeAllObjects];
                    [self requestYearDatasWithYearString:self.currentYear];
                }
                break;
            }
        }
    }
}

//下一个时间
- (void)nextDate:(UIButton *)sender {
    //日
    if (self.dayButton.selected) {
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        NSDate *tomorrow = [currentDayDate dateByAddingTimeInterval: secondsPerDay];
        
        self.currentDay = [self.dayFormatter stringFromDate:tomorrow];
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        [self.dayDict removeAllObjects];
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    //月
    if (self.monthButton.selected) {
        NSDate *currentYearDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentYearDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentYearDate];
        
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                
                for (int j = 0; j<self.monthArr.count; j++) {
                    if ([_monthArr[j] integerValue] == [currentMonthStr integerValue]) {
                        if (i < _yearsArr.count && j < _monthArr.count-1) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i], _monthArr[j+1]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        if (i < _yearsArr.count && j == _monthArr.count-1) {
                            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[i+1], _monthArr[0]];
                            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
                            [self.monthDict removeAllObjects];
                            [self requestMonthDatasWithMonthString:self.currentMonth];
                        }
                        
                        break;
                    }
                }
                
                break;
            }
        }
    }
    
    //年
    if (self.yearButton.selected) {
        for (int i = 0; i<self.yearsArr.count; i++) {
            if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                if (i < _yearsArr.count) {
                    self.currentYear = _yearsArr[i+1];
                    [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
                    [self.yearDict removeAllObjects];
                    [self requestYearDatasWithYearString:self.currentYear];
                }
                break;
            }
        }
    }
}


#pragma mark - 日、月、年、总  按钮事件
- (void)buttonDidClicked:(UIButton *)sender {
    [self.monthPicker removeFromSuperview];
    [self.yearPicker removeFromSuperview];
    [self.dayPicker removeFromSuperview];
    [self.toolBar removeFromSuperview];
    
    if (sender.tag == 1000) {
        //日
        self.dayButton.selected = YES;
        self.monthButton.selected = NO;
        self.yearButton.selected = NO;
        self.totalButton.selected = NO;
        if (_dict[@"1"]) {
            [_line2View addSubview:_selectButton];
            [_selectButton setTitle:_dict[@"1"] forState:0];
            self.line2View.energyTitleLabel.text = root_Today_Energy;
            self.line2View.unitLabel.text = root_Powre;
        }else{
            [_selectButton removeFromSuperview];
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, -216*HEIGHT_SIZE - 64*HEIGHT_SIZE- 70*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, -216*HEIGHT_SIZE - 64*HEIGHT_SIZE - 70*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
            }];
        }
        if (!self.currentDay) {
            self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
        
        [self requestDayDatasWithDayString:self.currentDay];
    }
    
    if (sender.tag == 1001) {
        //月
        self.dayButton.selected = NO;
        self.monthButton.selected = YES;
        self.yearButton.selected = NO;
        self.totalButton.selected = NO;
        if (_dictMonth[@"1"]) {
            [_selectButton setTitle:_dictMonth[@"1"] forState:0];
        }else{
            [_selectButton removeFromSuperview];
        }
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0, -216*HEIGHT_SIZE - 64*HEIGHT_SIZE - 70*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, -216*HEIGHT_SIZE - 64*HEIGHT_SIZE - 70*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
            }];
        }
        
        if (!self.currentMonth) {
            self.currentMonth = [_monthFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
        
        [self requestMonthDatasWithMonthString:self.currentMonth];
    }
    
    if (sender.tag == 1002) {
        //年
        self.dayButton.selected = NO;
        self.monthButton.selected = NO;
        self.yearButton.selected = YES;
        self.totalButton.selected = NO;
        if (_dictYear[@"1"]) {
            [_selectButton setTitle:_dictYear[@"1"] forState:0];
        }else{
            [_selectButton removeFromSuperview];
        }
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 1;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0, -216*HEIGHT_SIZE - 64*HEIGHT_SIZE - 70*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
            }];
        }
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
            }];
        }
        
        if (!self.currentYear) {
            self.currentYear = [_yearFormatter stringFromDate:[NSDate date]];
        }
        [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
        
        [self requestYearDatasWithYearString:self.currentYear];
    }
    
    if (sender.tag == 1003) {
        //总体
        self.dayButton.selected = NO;
        self.monthButton.selected = NO;
        self.yearButton.selected = NO;
        self.totalButton.selected = YES;
        if (_dictAll[@"1"]) {
            [_selectButton setTitle:_dictAll[@"1"] forState:0];
        }else{
            [_selectButton removeFromSuperview];
        }
        [UIView animateWithDuration:0.3f animations:^{
            self.timeDisplayView.alpha = 0;
        }];
        
        if (self.dayPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.frame = CGRectMake(0,( -216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        if (self.monthPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        if (self.yearPicker) {
            [UIView animateWithDuration:0.3f animations:^{
                self.yearPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
        
        [self requestTotalDatas];
    }
}

#pragma mark - datePickerButton点击事件 选择时间
- (void)pickDate {
    self.lastButton.enabled = NO;
    self.nextButton.enabled = NO;
    
    if (self.dayButton.selected) {
        //选择日
        NSDate *currentDayDate = [self.dayFormatter dateFromString:self.currentDay];
        
        if (!self.dayPicker) {
            self.dayPicker = [[UIDatePicker alloc] init];
            self.dayPicker.backgroundColor = [UIColor whiteColor];
            self.dayPicker.datePickerMode = UIDatePickerModeDate;
            self.dayPicker.date = currentDayDate;
            self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.dayPicker];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.date = currentDayDate;
                self.dayPicker.alpha = 1;
                self.dayPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.dayPicker];
            }];
        }
    }
    
    if (self.monthButton.selected) {
        //选择月
        NSDate *currentMonthDate = [self.monthFormatter dateFromString:self.currentMonth];
        NSString *currentYearStr = [self.yearFormatter stringFromDate:currentMonthDate];
        NSString *currentMonthStr = [self.onlyMonthFormatter stringFromDate:currentMonthDate];
        
        if (!self.monthPicker) {
            self.monthPicker = [[UIPickerView alloc] init];
            self.monthPicker.backgroundColor = [UIColor whiteColor];
            self.monthPicker.delegate = self;
            self.monthPicker.dataSource = self;
            self.monthPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.monthPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
            for (int i = 0; i<self.monthArr.count; i++) {
                if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                    [self.monthPicker selectRow:i inComponent:1 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [currentYearStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                for (int i = 0; i<self.monthArr.count; i++) {
                    if ([_monthArr[i] integerValue] == [currentMonthStr integerValue]) {
                        [self.monthPicker selectRow:i inComponent:1 animated:NO];
                        break;
                    }
                }
                self.monthPicker.alpha = 1;
                self.monthPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.monthPicker];
            }];
        }
    }
    
    if (self.yearButton.selected) {
        //选择年
        if (!self.yearPicker) {
            self.yearPicker = [[UIPickerView alloc] init];
            self.yearPicker.backgroundColor = [UIColor whiteColor];
            self.yearPicker.delegate = self;
            self.yearPicker.dataSource = self;
            self.yearPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            [self.view addSubview:self.yearPicker];
            
            for (int i = 0; i<self.yearsArr.count; i++) {
                if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                    [self.yearPicker selectRow:i inComponent:0 animated:NO];
                    break;
                }
            }
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                for (int i = 0; i<self.yearsArr.count; i++) {
                    if ([_yearsArr[i] integerValue] == [self.currentYear integerValue]) {
                        [self.yearPicker selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
                self.yearPicker.alpha = 1;
                self.yearPicker.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                [self.view addSubview:self.yearPicker];
            }];
        }
    }
    
    if (!self.totalButton.selected) {
        if (self.toolBar) {
            [UIView animateWithDuration:0.3f animations:^{
                self.toolBar.alpha = 1;
                self.toolBar.frame = CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE);
                [self.view addSubview:_toolBar];
            }];
        } else {
            self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 70*HEIGHT_SIZE + 0*HEIGHT_SIZE + 216*HEIGHT_SIZE, SCREEN_Width, 30*HEIGHT_SIZE)];
            self.toolBar.barStyle = UIBarStyleDefault;
            self.toolBar.barTintColor = MainColor;
            [self.view addSubview:self.toolBar];
            
            UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:root_finish style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
            [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14*HEIGHT_SIZE],NSFontAttributeName, nil] forState:UIControlStateNormal];
            doneButton.tintColor = [UIColor whiteColor];
            self.toolBar.items = @[spaceButton, doneButton];
        }
    }
}

#pragma mark 完成选择时间
- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.lastButton.enabled = YES;
    self.nextButton.enabled = YES;
    
    if (self.dayButton.selected) {
        if (self.dayPicker) {
            self.currentDay = [self.dayFormatter stringFromDate:self.dayPicker.date];
            [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
            
            [self.dayDict removeAllObjects];
            [self requestDayDatasWithDayString:self.currentDay];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0,( -216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.dayPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
            
        }
    }
    
    if (self.monthButton.selected) {
        if (self.monthPicker) {
            NSInteger rowYear = [_monthPicker selectedRowInComponent:0];
            NSInteger rowMonth = [_monthPicker selectedRowInComponent:1];
            self.currentMonth = [NSString stringWithFormat:@"%@-%@", _yearsArr[rowYear], _monthArr[rowMonth]];
            [self.datePickerButton setTitle:self.currentMonth forState:UIControlStateNormal];
            
            [self.monthDict removeAllObjects];
            [self requestMonthDatasWithMonthString:self.currentMonth];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE- 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.monthPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
    
    if (self.yearButton.selected) {
        if (self.yearPicker) {
            NSInteger rowYear = [_yearPicker selectedRowInComponent:0];
            self.currentYear = [NSString stringWithFormat:@"%@", _yearsArr[rowYear]];
            [self.datePickerButton setTitle:self.currentYear forState:UIControlStateNormal];
            
            [self.yearDict removeAllObjects];
            [self requestYearDatasWithYearString:self.currentYear];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.dayPicker.alpha = 0;
                self.toolBar.alpha = 0;
                self.yearPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
                self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
            } completion:^(BOOL finished) {
                [self.yearPicker removeFromSuperview];
                [self.toolBar removeFromSuperview];
            }];
        }
    }
}

#pragma mark - 取消选择时间
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dayPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.dayPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.dayPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.dayPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.monthPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.monthPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.monthPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.monthPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
    
    if (self.yearPicker) {
        [UIView animateWithDuration:0.3f animations:^{
            self.yearPicker.alpha = 0;
            self.toolBar.alpha = 0;
            self.yearPicker.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE, SCREEN_Width, 216*HEIGHT_SIZE);
            self.toolBar.frame = CGRectMake(0, (-216 - 64 - 70)*HEIGHT_SIZE - 44*HEIGHT_SIZE, SCREEN_Width, 44*HEIGHT_SIZE);
        } completion:^(BOOL finished) {
            [self.yearPicker removeFromSuperview];
            [self.toolBar removeFromSuperview];
            self.lastButton.enabled = YES;
            self.nextButton.enabled = YES;
        }];
    }
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == _monthPicker) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return _yearsArr.count;
        }
        return _monthArr.count;
    }
    return _yearsArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _monthPicker) {
        if (component == 0) {
            return [NSString stringWithFormat:@"%@", _yearsArr[row]];
        }
        return [NSString stringWithFormat:@"%@", _monthArr[row]];
    }
    return [NSString stringWithFormat:@"%@", _yearsArr[row]];
}



-(void)buttonPressed{
    NSArray *array=[[NSArray alloc]initWithObjects:_dayButton, _monthButton, _yearButton, _totalButton, nil];
    NSArray *arrayDict=[[NSArray alloc]initWithObjects:_dict, _dictMonth, _dictYear, _dictAll, nil];
    for (int i=0; i<4; i++) {
        UIButton *button=array[i];
        if (button.selected) {
            _editGraph = [[EditGraphView alloc] initWithFrame:self.view.bounds dictionary:arrayDict[i]];
            break;
        }
    }
    _editGraph.delegate = self;
    _editGraph.tintColor = [UIColor blackColor];
    _editGraph.dynamic = NO;
    _editGraph.blurRadius = 10.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:_editGraph];
}



#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    if (row==0) {
        //取消菜单
        [_editGraph removeFromSuperview];
    }
    
    if (_dayButton.selected) {
        for (int i=0; i<_dict.count; i++) {
            if (row==i+1) {
                [_editGraph removeFromSuperview];
                NSString *string=[NSString stringWithFormat:@"%d",i+1];
                [_selectButton setTitle:_dict[string] forState:0];
                _type=string;
                [self requestDayDatasWithDayString:self.currentDay];
                if ([_dict[string] isEqualToString:root_INPUT_VOLTAGE]||
                    [_dict[string] isEqualToString:root_PV1_VOLTAGE]||
                    [_dict[string] isEqualToString:root_PV2_VOLTAGE]) {
                    _line2View.unitLabel.text=root_Voltage;
                }else if([_dict[string] isEqualToString:root_INPUT_CURRENT]||
                         [_dict[string] isEqualToString:root_PV1_ELEC_CURRENT]||
                         [_dict[string] isEqualToString:root_PV2_ELEC_CURRENT]){
                    _line2View.unitLabel.text=root_Electron_flow;
                }else if([_dict[string] isEqualToString:root_dianchi]||
                         [_dict[string] isEqualToString:root_dianchi]||
                         [_dict[string] isEqualToString:root_dianchi]){
                    _line2View.unitLabel.text=root_dianchi;
                }else{
                    _line2View.unitLabel.text=root_Powre;
                }

            }
      
        }
    }else if (_monthButton.selected){
        for (int i=0; i<_dictMonth.count; i++) {
            if (row==i+1) {
                [_editGraph removeFromSuperview];
                NSString *string=[NSString stringWithFormat:@"%d",i+1];
                [_selectButton setTitle:_dictMonth[string] forState:0];
                _type=string;
                [self requestMonthDatasWithMonthString:self.currentMonth];
            }
        }
    }else if (_yearButton.selected){
        for (int i=0; i<_dictYear.count; i++) {
            if (row==i+1) {
                [_editGraph removeFromSuperview];
                NSString *string=[NSString stringWithFormat:@"%d",i+1];
                [_selectButton setTitle:_dictYear[string] forState:0];
                _type=string;
                [self requestYearDatasWithYearString:self.currentYear];
            }
        }
    }else if (_totalButton.selected){
        for (int i=0; i<_dict.count; i++) {
            if (row==i+1) {
                [_editGraph removeFromSuperview];
                NSString *string=[NSString stringWithFormat:@"%d",i+1];
                [_selectButton setTitle:_dictAll[string] forState:0];
                _type=string;
                [self requestTotalDatas];
            }
        }
    }
}


-(CABasicAnimation *)opacityForever_Animation:(float)time{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}




@end
