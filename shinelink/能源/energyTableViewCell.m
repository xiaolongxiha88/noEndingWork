//
//  energyTableViewCell.m
//  shinelink
//
//  Created by sky on 16/3/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyTableViewCell.h"
#define labelWidth  65*NOW_SIZE
#define labelWidth1  55*NOW_SIZE
#define labelHeight  20*HEIGHT_SIZE
#define fontSize  11*HEIGHT_SIZE
#define labelColor  grayColor

@implementation energyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 55*HEIGHT_SIZE, 55*HEIGHT_SIZE)];
        
        [self.contentView addSubview:_coverImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE, 0, 250*NOW_SIZE, 50*HEIGHT_SIZE)];
        
        self.titleLabel.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 25*HEIGHT_SIZE, 20*NOW_SIZE, 15*HEIGHT_SIZE)];
        arrowView.image = IMAGE(@"frag4.png");
        [self.contentView addSubview:arrowView];
        
//        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-60*NOW_SIZE, 12*HEIGHT_SIZE, 40*NOW_SIZE, 30*HEIGHT_SIZE)];
//        self.detail.text = root_xianQing;
//        self.detail.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
//        self.detail.textAlignment = NSTextAlignmentLeft;
//        self.detail.textColor = [UIColor labelColor];
//        [self.contentView addSubview:_detail];
        
        
//        self.state = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5, 40*HEIGHT_SIZE, labelWidth1+10*NOW_SIZE, labelHeight)];
//        
//        self.state.font=[UIFont systemFontOfSize:fontSize];
//        self.state.textAlignment = NSTextAlignmentRight;
//        self.state.textColor = [UIColor labelColor];
//        [self.contentView addSubview:_state];
        
        float width2=SCREEN_Width-(55*HEIGHT_SIZE+10*NOW_SIZE);
        self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake( 55*HEIGHT_SIZE+10*NOW_SIZE, 40*HEIGHT_SIZE, width2/2, labelHeight)];
        self.stateValue.font=[UIFont systemFontOfSize:fontSize];
        self.stateValue.textAlignment = NSTextAlignmentCenter;
        self.stateValue.textColor = [UIColor labelColor];
        [self.contentView addSubview:_stateValue];
        
     
        
      
        
//        self.electric = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5+2*labelWidth-5*NOW_SIZE, 40*HEIGHT_SIZE, labelWidth1+15*NOW_SIZE, labelHeight)];
//        
//        self.electric.font=[UIFont systemFontOfSize:fontSize];
//        self.electric.textAlignment = NSTextAlignmentRight;
//        self.electric.textColor = [UIColor labelColor];
//        [self.contentView addSubview:_electric];
        
        self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE+width2/2, 40*HEIGHT_SIZE, width2/2, labelHeight)];
        
        self.electricValue.font=[UIFont systemFontOfSize:fontSize];
        self.electricValue.textAlignment = NSTextAlignmentCenter;
        self.electricValue.textColor = [UIColor labelColor];
        [self.contentView addSubview:_electricValue];
        
        
        UIView *V0=[[UIView alloc] initWithFrame:CGRectMake(0, 65*HEIGHT_SIZE-LineWidth, SCREEN_Width, LineWidth)];
        V0.backgroundColor=colorGary;
        [self.contentView addSubview:V0];
        
        
        
    }
    
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
