//
//  EquipmentView.h
//  ShinePhone
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipmentView : UIView
- (instancetype)initWithFrame:(CGRect)frame ImageStr:(NSString *)imageStr Name:(NSString *)name Dosage:(NSString *)dosage Status:(int)status;
@end
