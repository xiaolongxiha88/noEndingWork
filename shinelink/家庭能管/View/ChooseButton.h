//
//  ChooseButton.h
//  ShinePhone
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseButton : UIButton
- (instancetype)chooseButtonWithTitle:(NSString *)title withImage:(NSString *)imageStr andFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title withImage:(NSString *)imageStr;
@end
