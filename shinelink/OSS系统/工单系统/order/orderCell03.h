//
//  orderCell03.h
//  ShinePhone
//
//  Created by sky on 2017/12/28.
//  Copyright © 2017年 sky. All rights reserved.
//
@class Model;

#import <UIKit/UIKit.h>

@interface orderCell03 : UITableViewCell

@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,strong)UIView *View3;

@property(nonatomic, strong) Model *model;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *titleImage;
@property(nonatomic,strong) UILabel *remarkLabel;

@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic, assign) BOOL isShowMoreText;

@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic)CGFloat cellFirstH;
@property(nonatomic,strong)NSString *statusString;
@property(nonatomic,strong)NSString *orderID;
@property(nonatomic,strong)NSDictionary *allValueDic;
@property(nonatomic,strong)NSArray *picArray;
@property(nonatomic,strong)NSArray *picArray1;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property(nonatomic,strong)NSString *goTimeString;
@property(nonatomic,strong)NSString *remarkString;

@property(nonatomic,strong)UITextView* textfield2;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);



/**
 @return 默认高度
 */
+ (CGFloat)defaultHeight;

/**
 展开高度
 
 @param model 模型
 @return 展开高度
 */
+ (CGFloat)moreHeight:(CGFloat )navigationH;



@end
