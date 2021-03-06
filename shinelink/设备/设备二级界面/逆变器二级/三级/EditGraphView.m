//
//  EditGraphView.m
//  ShinePhone
//
//  Created by ZML on 15/6/4.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "EditGraphView.h"

@implementation EditGraphView

- (instancetype)initWithFrame:(CGRect)frame dictionary:(NSDictionary *)dictionary{
    if (self = [super initWithFrame:frame]) {
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(frame.size.width - 64*NOW_SIZE, 44*HEIGHT_SIZE, 44*NOW_SIZE, 44*HEIGHT_SIZE);
        cancelButton.imageEdgeInsets = UIEdgeInsetsMake(7*NOW_SIZE, 7*HEIGHT_SIZE, 7*NOW_SIZE, 7*HEIGHT_SIZE);
        [cancelButton setImage:IMAGE(@"buttonCancle.png") forState:UIControlStateNormal];
        cancelButton.tag = 1050;
        [cancelButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        
        UIScrollView *bgImageView = [[UIScrollView alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 150*HEIGHT_SIZE, 220*NOW_SIZE, 200*HEIGHT_SIZE)];
        bgImageView.backgroundColor=[UIColor whiteColor];
        bgImageView.layer.borderWidth=1;
        bgImageView.layer.borderColor=MainColor.CGColor;
        bgImageView.layer.cornerRadius=5;
        [self addSubview:bgImageView];
        bgImageView.contentSize=CGSizeMake(220*NOW_SIZE, 50*dictionary.count*HEIGHT_SIZE);
        
        for (int i=0; i<dictionary.count; i++) {
            NSString *string=[NSString stringWithFormat:@"%d",i+1];
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
            addButton.frame = CGRectMake(0, i*50*HEIGHT_SIZE, CGRectGetWidth(bgImageView.frame), 50*HEIGHT_SIZE);
            
            NSString *str=@"str";
            if ([[dictionary[string] class] isEqual:[root_Yes class]] || [[dictionary[string] class] isEqual:[str class]] || [[NSString stringWithFormat:@"%@",[dictionary[string] class]] isEqualToString:@"__NSCFString"]) {
                [addButton setTitle:dictionary[string] forState:UIControlStateNormal];
            }else{
                [addButton setTitle:dictionary[string][1] forState:UIControlStateNormal];
            }
            
           // NSString *titleName=dictionary[string];
         //   [addButton setTitle:titleName forState:UIControlStateNormal];
            
            addButton.titleLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
            addButton.titleLabel.adjustsFontSizeToFitWidth=YES;
            [addButton setTitleColor:MainColor forState:UIControlStateNormal];
            [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            addButton.tag = 1051+i;
            [addButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:addButton];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, i*50*HEIGHT_SIZE+50*HEIGHT_SIZE-LineWidth, CGRectGetWidth(bgImageView.frame), LineWidth)];
            lineView.backgroundColor=colorGary;
              [bgImageView addSubview:lineView];
            
        }
    }
    return self;
}


- (void)buttonDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(menuDidSelectAtRow:)]) {
        [self.delegate menuDidSelectAtRow:(sender.tag - 1050)];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
