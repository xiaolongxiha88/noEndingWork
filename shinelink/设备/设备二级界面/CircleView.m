//
//  CircleView.m
//  圆形进度条
//
//  Created by andy on 15/10/23.
//  Copyright © 2015年 andy. All rights reserved.
//

#import "CircleView.h"

#define DefaultTrackLineWidth               16.0f           // 默认轨迹宽度
#define DefaultProgressLineWidth            14.0f           // 默认进度宽度
#define radiusSize  70*HEIGHT_SIZE
@interface CircleView ()

// 轨迹layer
@property (nonatomic, strong) CAShapeLayer      *trackLayer;

// 进度条layer
@property (nonatomic, strong) CAShapeLayer      *progressLayer;

// 圆形路径
@property (nonatomic, strong) UIBezierPath      *circlePath;

@property (nonatomic, strong) UIBezierPath      *circlePath1;

// 左半边渐变颜色
@property (nonatomic, strong) CAGradientLayer   *gradientLayer;


@end

@implementation CircleView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValue];
        [self drawDefaultUI];
    }
    return self;
}

- (void)setupDefaultValue {
    _progress           = 0;
    _trackLineWidth     = DefaultTrackLineWidth;
    _progressLineWidth  = DefaultProgressLineWidth;
    _trackColor         = COLOR(14, 138, 243, 1);
    _startAngle         = CoverToRadian(-360);
    _endAngle           = CoverToRadian(0);
    _colockwise         = YES;
}


- (void)drawDefaultUI {
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), 100*HEIGHT_SIZE);
    // 半径： 取 self.frame的宽高最小值进行计算
    CGFloat radius =radiusSize;
    _circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:_colockwise];
    _circlePath1= [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:_colockwise];
    
    _trackLayer             = [CAShapeLayer layer];
    _trackLayer.frame       = self.bounds;
    _trackLayer.path        = _circlePath1.CGPath;
    _trackLayer.lineWidth   = _trackLineWidth;
    _trackLayer.strokeColor = _trackColor.CGColor;
    _trackLayer.lineCap     = kCALineCapRound;
    _trackLayer.fillColor   = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_trackLayer];
    
    _progressLayer              = [CAShapeLayer layer];
    _progressLayer.path         = _circlePath.CGPath;
    _progressLayer.frame        = self.bounds;
    _progressLayer.lineWidth    = _progressLineWidth;
    _progressLayer.strokeColor  = COLOR(2, 156, 217, 1).CGColor;
    _progressLayer.fillColor    = [UIColor clearColor].CGColor;
    _progressLayer.lineCap      = kCALineCapRound;
    _progressLayer.strokeEnd    = _progress / 100;
   // [self.layer addSublayer:_progressLayer];
    
    _gradientLayer              = [CAGradientLayer layer];
    UIColor *kk=COLOR(76, 224, 79, 1);
    _gradientLayer.colors       = @[(__bridge id)kk.CGColor,(__bridge id)kk.CGColor,(__bridge id)kk.CGColor,(__bridge id)kk.CGColor];
   //_gradientLayer.colors  =@[(__bridge id)kk.CGColor];
    _gradientLayer.locations    = @[@(0.0f),@(0.3f),@(0.7f),@(1.0f)];
    _gradientLayer.startPoint   = CGPointMake(1.0f, 0.0f);
    _gradientLayer.endPoint     = CGPointMake(1.0f, 1.0f);
    _gradientLayer.frame        = self.bounds;
    [_gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:_gradientLayer];
    
    
}

- (void)updateCirclePath {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), 100*HEIGHT_SIZE);
    // 半径： 取 self.frame的宽高最小值进行计算
    CGFloat radius =radiusSize;
    //    startAngle,endAngle 是以M_PI为单位，不是以度数，，，
    _circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:_endAngle clockwise:_colockwise];
    _circlePath1= [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:_colockwise];
    _trackLayer.path = _circlePath1.CGPath;
    _progressLayer.path = _circlePath.CGPath;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth {
    _progressLayer.lineWidth = progressLineWidth;
}

- (void)setTrackLineWidth:(CGFloat)trackLineWidth {
    _trackLayer.lineWidth = trackLineWidth;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackLayer.strokeColor = trackColor.CGColor;
}

-(void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self updateCirclePath];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    [self updateCirclePath];
}

- (void)setProgress:(CGFloat)progress {
    _progress = MAX(0, MIN(progress, 100));
    __block CAShapeLayer *progressLayer = self.progressLayer;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        progressLayer.strokeEnd = _progress / 10;// 动画时间
        //        NSLog(@"-----%f",progressLayer.strokeEnd);
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
