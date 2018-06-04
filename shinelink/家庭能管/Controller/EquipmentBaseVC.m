//
//  EquipmentBaseVC.m
//  ShinePhone
//
//  Created by mac on 2018/6/2.
//  Copyright © 2018年 qwl. All rights reserved.
//

#import "EquipmentBaseVC.h"

@interface EquipmentBaseVC ()

@end

@implementation EquipmentBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorGary;
    [self creatViews];
}
- (void)creatViews{
//    bottom_bg
    CGFloat height = NaviHeight;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight-74*HEIGHT_SIZE-height, kScreenWidth, 74*HEIGHT_SIZE)];
    
    bgImgView.image = IMAGE(@"bottom_bg");
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(70, 39*HEIGHT_SIZE, 20*NOW_SIZE, 19*HEIGHT_SIZE);
    [setBtn setBackgroundImage:IMAGE(@"set.png") forState:UIControlStateNormal];
    [bgImgView addSubview:setBtn];
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(kScreenWidth/2-39*NOW_SIZE/2, 10*HEIGHT_SIZE, 39*NOW_SIZE, 39*HEIGHT_SIZE+14*HEIGHT_SIZE);
    [openBtn setImage:IMAGE(@"switch_open") forState:UIControlStateNormal];
    [openBtn setTitle:@"开启" forState:UIControlStateNormal];
    [openBtn setTitleColor:COLOR(0, 156, 255, 1) forState:UIControlStateNormal];
//    [self initButton:openBtn];
    [bgImgView addSubview:openBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(kScreenWidth-70-20*NOW_SIZE, 39*HEIGHT_SIZE, 20*NOW_SIZE, 19*HEIGHT_SIZE);
    [deleteBtn setBackgroundImage:IMAGE(@"delete") forState:UIControlStateNormal];
    [bgImgView addSubview:deleteBtn];
    
    [self.view addSubview:bgImgView];
}
-(void)initButton:(UIButton*)btn{
    float  spacing = 4;//图片和文字的上下间距
    CGSize imageSize = CGSizeMake(btn.imageView.xmg_width, btn.imageView.xmg_width);// btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
