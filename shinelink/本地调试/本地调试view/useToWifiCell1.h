//
//  useToWifiCell1.h
//  ShinePhone
//
//  Created by sky on 2017/10/19.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class usbModleOne;

@interface useToWifiCell1 : UITableViewCell

@property(nonatomic, strong) usbModleOne *model;
@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIView *titleView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *moreTextBtn;
@property(nonatomic,strong) NSString *titleString;
@property(nonatomic,strong) UIView *nameView;

@property(nonatomic,strong) NSArray *lable1Array;
@property(nonatomic,strong) NSArray *lable2Array;
@property(nonatomic,strong) NSArray *lable3Array;
@property(nonatomic,strong) NSArray *lable4Array;

@property(nonatomic,assign) int cellTypy;
@property(nonatomic,assign) NSInteger indexRow;

@property(nonatomic, copy) void(^showMoreBlock)(UITableViewCell *currentCell);


+ (CGFloat)defaultHeight;

/**
 展开高度
 
 @param model 模型
 @return 展开高度
 */
//+ (CGFloat)moreHeight:(CGFloat) navigationH status:(NSString*)status;
+ (CGFloat)moreHeight:(int)CellTyoe;


@end
