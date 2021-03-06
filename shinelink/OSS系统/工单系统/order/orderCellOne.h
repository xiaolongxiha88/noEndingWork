//
//  orderCellOne.h
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Model;

@interface orderCellOne : UITableViewCell<UITextViewDelegate>


@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,strong)UIView *View3;
@property(nonatomic,strong)UIView *View5;

@property(nonatomic, strong) Model *model;

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *titleImage;

@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic,strong)UITextField* textfield;

@property(nonatomic, assign) BOOL isShowMoreText;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic)CGFloat cellFirstH;
@property(nonatomic,strong)NSString *statusString;
@property(nonatomic,strong)NSString *orderID;
@property(nonatomic,strong)NSDictionary *allValueDic;
@property (nonatomic, strong) NSMutableArray *picArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property(nonatomic,strong)NSString *goTimeString;
@property(nonatomic,strong)NSString *remarkString;

@property(nonatomic,strong)UITextView* textfield2;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);

@property(nonatomic,strong) UIButton *goBut;

/**
 默认高度
 
 @param model 模型
 @return 默认高度
 */
+ (CGFloat)defaultHeight;

/**
 展开高度
 
 @param model 模型
 @return 展开高度
 */
//+ (CGFloat)moreHeight:(CGFloat) navigationH status:(NSString*)status;
+ (CGFloat)moreHeight:(CGFloat) navigationH status:(NSString*)status remarkH:(CGFloat) remarkH;


@end
