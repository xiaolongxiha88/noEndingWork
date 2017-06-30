//
//  orderCellOne.m
//  ShinePhone
//
//  Created by sky on 2017/6/29.
//  Copyright © 2017年 sky. All rights reserved.
//

#import "orderCellOne.h"
#import "Model.h"

@implementation orderCellOne

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        float viewW1=34*HEIGHT_SIZE;
        
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width,viewW1)];
        _titleView.backgroundColor =COLOR(242, 242, 242, 1);
        _titleView.userInteractionEnabled = YES;
        UITapGestureRecognizer * forget2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMoreText)];
        [_titleView addGestureRecognizer:forget2];
        [self.contentView addSubview:_titleView];
        
           float ImageW1=26*HEIGHT_SIZE;  float firstW1=5*HEIGHT_SIZE;
        _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(firstW1, (viewW1-ImageW1)/2, ImageW1, ImageW1)];
        _titleImage.image=IMAGE(@"yuan_2.png");
        [_titleView addSubview:_titleImage];
        
        float titleLabelH1=30*HEIGHT_SIZE;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstW1*2+ImageW1, (viewW1-titleLabelH1)/2, 150*NOW_SIZE, titleLabelH1)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
        [_titleView addSubview:_titleLabel];
   
         float buttonViewW=50*NOW_SIZE;
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_Width-buttonViewW, 0, buttonViewW,viewW1)];
        buttonView.backgroundColor =[UIColor clearColor];
        buttonView.userInteractionEnabled = YES;
        [_titleView addSubview:buttonView];
        
          float buttonW=12*NOW_SIZE;    float buttonH=8*HEIGHT_SIZE;
        if (!_moreTextBtn) {
            _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _moreTextBtn.selected=NO;
            [_moreTextBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            _moreTextBtn.frame = CGRectMake((buttonViewW-buttonW)/2, (viewW1-buttonH)/2, buttonW, buttonH);
            [buttonView addSubview:_moreTextBtn];
            [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
        }

        
         float View2H=4*NOW_SIZE;
        UIView *View2 = [[UIView alloc]initWithFrame:CGRectMake(0, viewW1, SCREEN_Width,View2H)];
        View2.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:View2];

        float scrollFirstH=viewW1+View2H;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollFirstH, SCREEN_Width, 0)];
        _scrollView.scrollEnabled=YES;
        [self.contentView addSubview:_scrollView];
        
        UIView *View3 = [[UIView alloc]initWithFrame:CGRectMake(firstW1+ImageW1/2, viewW1/2, 0.3*NOW_SIZE,SCREEN_Height)];
        View3.backgroundColor =COLOR(255, 204, 0, 1);
        [self.contentView addSubview:View3];
        
        self.dayFormatter = [[NSDateFormatter alloc] init];
        [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       NSString *dataString = [_dayFormatter stringFromDate:[NSDate date]];
        
        NSArray *lableNameArray=[NSArray arrayWithObjects:@"所属区域:",@"申请时间:",@"要求到达时间:", @"预约上门时间:", @"详细地址:", @"备注:", nil];
         NSArray *lableNameArray2=[NSArray arrayWithObjects:@"广州",@"2010-10-10",@"2010-10-10", dataString, nil];
        
        for (int i=0; i<lableNameArray.count; i++) {
             float lable1W=10*NOW_SIZE;  float lableH=30*HEIGHT_SIZE;    float numH=35*NOW_SIZE;  float firstW=25*NOW_SIZE;
            if (i!=5) {
                UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(firstW, 2*HEIGHT_SIZE+numH*i,lable1W, lableH)];
                lable1.textColor = COLOR(154, 154, 154, 1);
                if ((i==3)||(i==4)) {
                    lable1.textColor = [UIColor redColor];
                }
                lable1.text=@"*";
                lable1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
                [_scrollView addSubview:lable1];
            }
         
            
            NSString*lable2Name=lableNameArray[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14*HEIGHT_SIZE] forKey:NSFontAttributeName];
            CGSize size = [lable2Name boundingRectWithSize:CGSizeMake(SCREEN_Width-(2*firstW), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(firstW+lable1W, 0+numH*i,size.width, lableH)];
            lable2.textColor = COLOR(154, 154, 154, 1);
            if ((i==3)||(i==4)||(i==5)) {
                lable2.textColor =COLOR(51, 51, 51, 1);
            }
            lable2.text=lableNameArray[i];
            lable2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
            [_scrollView addSubview:lable2];
            
             float ImageW2=15*HEIGHT_SIZE;
                if ((i==1)||(i==2)||(i==3)) {
               
                UIImageView *image00 = [[UIImageView alloc]initWithFrame:CGRectMake(firstW+lable1W+size.width, (lableH-ImageW2)/2+numH*i,ImageW2, ImageW2)];
                image00.image=IMAGE(@"workoader_date1.png");
                if (i==3) {
                    image00.image=IMAGE(@"workoader_date2.png");
                }
                [_scrollView addSubview:image00];
            }
            
             float lable3W=firstW+lable1W+size.width+ImageW2+5*NOW_SIZE;
            if ((i==0)||(i==1)||(i==2)||(i==3)) {
                UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(lable3W, 0+numH*i,SCREEN_Width-(1*firstW)-lable3W, lableH)];
                lable3.textColor = COLOR(154, 154, 154, 1);
                if (i==3) {
                    lable3.textColor =COLOR(51, 51, 51, 1);
                    lable3.userInteractionEnabled=YES;
                    lable3.tag=2000;
                    UITapGestureRecognizer * forget3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickDate)];
                    [lable3 addGestureRecognizer:forget3];
                }
                lable3.text=lableNameArray2[i];
                lable3.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                [_scrollView addSubview:lable3];
            }
          
              if ((i==0)||(i==1)||(i==2)||(i==3)||(i==4)) {
                UIView *View4 = [[UIView alloc]initWithFrame:CGRectMake(firstW, numH*(i+1)-1*HEIGHT_SIZE, SCREEN_Width-(2*firstW),1*HEIGHT_SIZE)];
                View4.backgroundColor = COLOR(222, 222, 222, 1);
                [_scrollView addSubview:View4];
            }
           
            float textfieldW=firstW+lable1W+size.width+5*NOW_SIZE;
            float textW1=SCREEN_Width-firstW-(SCREEN_Width-(2*firstW));
            float textW=SCREEN_Width-textfieldW-textW1;
            if (i==4) {
                UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i,textW, lableH)];
                     textfield.placeholder = @"请输入客户地址";
                textfield.textColor = COLOR(51, 51, 51, 1);
                textfield.tintColor = COLOR(51, 51, 51, 1);
                [textfield setValue:COLOR(154, 154, 154, 1) forKeyPath:@"_placeholderLabel.textColor"];
                [textfield setValue:[UIFont systemFontOfSize:12*HEIGHT_SIZE] forKeyPath:@"_placeholderLabel.font"];
                textfield.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                [_scrollView addSubview:textfield];
            }

            NSString *textfieldString=@"dqwdqwdqwdqqwasdqdwqdqwdqd";
                CGSize size1= [textfieldString boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            if (i==5) {
                _textfield2 = [[UITextView alloc] initWithFrame:CGRectMake(textfieldW, 0+numH*i,textW, size1.height+5*HEIGHT_SIZE)];
               _textfield2.textColor=COLOR(51, 51, 51, 1);
                _textfield2.tintColor = COLOR(51, 51, 51, 1);
                _textfield2.text=textfieldString;
                _textfield2.delegate=self;
                _textfield2.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
                [_scrollView addSubview:_textfield2];
            }
            
        }
        
        
        
      
        
   
        
    }
    return self;
}


- (void)textViewDidChange:(UITextView *)textView {
    [self updateHeight:textView isInput:YES];
}


- (void)updateHeight:(UITextView *)textView isInput:(BOOL)isInput {
    
    CGFloat height =  textView.contentSize.height;

    
    
    if (height >=100*HEIGHT_SIZE) {
        height =100*HEIGHT_SIZE;
   
    }
    [UIView animateWithDuration:0.25f animations:^{
        
        float W=_textfield2.frame.size.width;
        float x=_textfield2.frame.origin.x;
        float y=_textfield2.frame.origin.y;
    
        
     _textfield2.frame=CGRectMake(x,y , W, height);
        
      
    }];
}



- (void)showMoreText{
    
   self.model.isShowMoreText = !self.model.isShowMoreText;


    if (self.showMoreBlock){
        self.showMoreBlock(self);
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.text = self.model.title;
    

       if (self.model.isShowMoreText){ // 展开状态
        // 计算文本高度
           float y=_scrollView.frame.origin.y;
     _scrollView.frame=CGRectMake(0, y, SCREEN_Width, SCREEN_Height);
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_up.png") forState:UIControlStateNormal];
    }else{ // 收缩状态
             float y=_scrollView.frame.origin.y;
   _scrollView.frame=CGRectMake(0, y, SCREEN_Width, 0);
        
        [_moreTextBtn setImage:IMAGE(@"oss_more_down.png") forState:UIControlStateNormal];
    }
}

// MARK: - 获取默认高度
+ (CGFloat)defaultHeight{
  
    return 38*HEIGHT_SIZE;
}

// MARK: - 获取展开后的高度
+ (CGFloat)moreHeight:(CGFloat) navigationH{
    
  
    float H=SCREEN_Height-90*HEIGHT_SIZE-(38*HEIGHT_SIZE*2)-navigationH;
    
    return H;
    
}



-(void)pickDate{
    // float buttonSize=70*HEIGHT_SIZE;
    _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, SCREEN_Height-360*HEIGHT_SIZE, SCREEN_Width, 250*HEIGHT_SIZE)];
   _date.backgroundColor=COLOR(242, 242, 242, 1);
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.contentView addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, SCREEN_Height-400*HEIGHT_SIZE-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE);
            [self.contentView addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_Height-360*HEIGHT_SIZE-40*HEIGHT_SIZE, SCREEN_Width, 40*HEIGHT_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = COLOR(17, 183, 243, 1);
        [self.contentView addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeToolBar)];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeSelectDate:)];
        
        UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
        
        spaceButton.tintColor=[UIColor whiteColor];
        doneButton.tintColor=[UIColor whiteColor];
        

        self.toolBar.items = @[spaceButton,flexibleitem,doneButton];
    }
}


-(void)removeToolBar{
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}


- (void)completeSelectDate:(UIToolbar *)toolBar {
    _goTimeString = [self.dayFormatter stringFromDate:self.date.date];
    

    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}



@end
