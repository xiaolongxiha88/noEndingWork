//
//  ChooseButton.m
//  ShinePhone
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "ChooseButton.h"

@implementation ChooseButton
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title withImage:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [self setTitleColor:COLOR(102, 102, 102, 1) forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    self.backgroundColor = [UIColor whiteColor];
    ViewBorderRadius(self, 5, 0, [UIColor clearColor]);
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.tintColor = [UIColor clearColor];

    CGRect btnFrame = self.bounds;

    UIImageView *imageView = self.imageView;
    int imageWidth = 41*NOW_SIZE;
    int imageHegith = 39*HEIGHT_SIZE;
    self.imageView.bounds = CGRectMake(0, 0, imageWidth, imageHegith);
    

    UILabel *label = self.titleLabel;
    label.textAlignment = NSTextAlignmentCenter;

    imageView.xmg_x = btnFrame.origin.x + (btnFrame.size.width - imageView.xmg_size.width)/2.f;
    imageView.xmg_y = (btnFrame.size.height - imageView.xmg_size.width - label.font.lineHeight)/2.f;

    label.frame = CGRectMake(btnFrame.origin.x, CGRectGetMaxY(imageView.frame) + 5, btnFrame.size.width, label.font.lineHeight);
}
@end
