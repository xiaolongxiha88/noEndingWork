//
//  StateView.h
//  ShinePhone
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateView : UIView
- (instancetype)initWithFrame:(CGRect)frame Image1Str:(NSString *)image1Str Image2Str:(NSString *)image2Str TopLineColor:(UIColor *)linecolor TextColor:(UIColor *)color Title:(NSString *)title Text1:(NSString *)text1 Text2:(NSString *)text2;
@end
