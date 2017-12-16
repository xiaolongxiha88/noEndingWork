//
//  SPF5000Head.h
//  ShinePhone
//
//  Created by sky on 2017/8/17.
//  Copyright © 2017年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPF5000Head : UIView<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableDictionary *pcsDataDic;

@property (nonatomic, assign)  NSInteger animationNumber;
 @property (nonatomic, assign)  BOOL isStorageLost;

-(void)initUI;

@end
