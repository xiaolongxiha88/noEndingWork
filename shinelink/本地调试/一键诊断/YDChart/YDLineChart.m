//
//  YDLineChart.m
//  JHChartDemo
//
//  Created by sky on 2018/1/23.
//  Copyright © 2018年 JH. All rights reserved.
//

#import "YDLineChart.h"
#define kXandYSpaceForSuperView 20.0


@interface YDLineChart ()<CAAnimationDelegate>

@property (assign, nonatomic)   float  xLength;
@property (assign , nonatomic)  float  yLength;

@property (assign , nonatomic)  float  perYlen ;


@property (assign , nonatomic)  float  perValue ;
@property (nonatomic,strong)    NSMutableArray * drawDataArr;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (assign , nonatomic) BOOL  isEndAnimation ;
@property (nonatomic,strong) NSMutableArray * layerArr;
@property (nonatomic,strong) NSMutableArray * lableArray;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray * xArrayForFirst;
@property (assign, nonatomic) float lastLableX;

@end

@implementation YDLineChart



/**
 *  重写初始化方法
 *
 *  @param frame         frame
 *  @param lineChartType 折线图类型
 *
 *  @return 自定义折线图
 */
-(instancetype)initWithFrame:(CGRect)frame andLineChartType:(JHLineChartTypeYD)lineChartType{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _lineType = lineChartType;
        _lineWidth = 0.5;
        
        _yLineDataArr  = @[@"10",@"20",@"30",@"40",@"50"];
        _xLineDataArr  = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
        _showXDescVertical = NO;
        _xDescriptionAngle = M_PI_2/15;
        _xDescMaxWidth = 30.0;
        _pointNumberColorArr = @[[UIColor redColor]];
        _positionLineColorArr = @[[UIColor darkGrayColor]];
        _pointColorArr = @[[UIColor orangeColor]];
        _xAndYNumberColor = [UIColor darkGrayColor];
        _valueLineColorArr = @[[UIColor redColor]];
        _layerArr = [NSMutableArray array];
        _lableArray=[NSMutableArray array];
        _showYLine = YES;
        _showYLevelLine = NO;
        _showValueLeadingLine = YES;
        _valueFontSize = 8.0;
        _showPointDescription = YES;
        _drawPathFromXIndex = 0;
        _showDoubleYLevelLine = NO;
        self.animationDuration = 2.0;
        //        _contentFillColorArr = @[[UIColor lightGrayColor]];
        [self configChartXAndYLength];
        [self configChartOrigin];
        [self configPerXAndPerY];
    }
    return self;
    
}

/**
 *  清除图标内容
 */
-(void)clear{
    

    for (CALayer *layer in _layerArr) {
        
        [layer removeFromSuperlayer];
    }
    for (UILabel *lable in _lableArray) {
        
        [lable removeFromSuperview];
    }
 //   [self showAnimation];
    
}

/**
 *  获取每个X或y轴刻度间距
 */
- (void)configPerXAndPerY{
    
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYD:
        {
            _perXLen = (_xLength)/(_MaxX-1);
            _perYlen = (_yLength-kXandYSpaceForSuperView)/_yLineDataArr.count;
            if (_showDoubleYLevelLine) {
                _perYlen = (_yLength-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
            }
        }
            break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYD:
        {
            _perXLen = (_xLength/2-kXandYSpaceForSuperView)/[_xLineDataArr[0] count];
            _perYlen = (_yLength-kXandYSpaceForSuperView)/_yLineDataArr.count;
        }
            break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:
        {
            _perXLen = (_xLength)/(_xLineDataArr.count-1);
            _perYlen = (_yLength/2-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
        }
            break;
        case JHLineChartQuadrantTypeAllQuardrantYD:
        {
            _perXLen = (_xLength/2-kXandYSpaceForSuperView)/([_xLineDataArr[0] count]);
            _perYlen = (_yLength/2-kXandYSpaceForSuperView)/[_yLineDataArr[0] count];
        }
            break;
            
        default:
            break;
    }
    
}


/**
 *  重写LineChartQuardrantType的setter方法 动态改变折线图原点
 *
 */
-(void)setLineChartQuadrantType:(JHLineChartQuadrantTypeYD)lineChartQuadrantType{
    
    _lineChartQuadrantType = lineChartQuadrantType;
    [self configChartOrigin];
    
}



/**
 *  获取X与Y轴的长度
 */
- (void)configChartXAndYLength{
    _xLength = CGRectGetWidth(self.frame)-self.contentInsets.left-self.contentInsets.right;
    _yLength = CGRectGetHeight(self.frame)-self.contentInsets.top-self.contentInsets.bottom;
}


/**
 *  重写ValueArr的setter方法 赋值时改变Y轴刻度大小
 *
 */
-(void)setValueArr:(NSArray *)valueArr{
    
    _valueArr = valueArr;
    
    [self updateYScale];
    
}


- (void)updateXScale{
    if (_xLineDataArr.count) {
        
        NSInteger max=0;
        
        
        for ( NSNumber *x  in _xLineDataArr) {
            NSInteger i=[x integerValue];
            if (i>=max) {
                max = i;
            }
            
        }
        
        
        
        
        if (max%5==0) {
            max = max;
        }else
            max = (max/5+1)*5;
        _xArrayForFirst = nil;
        NSMutableArray *arr = [NSMutableArray array];
        if (max<=5) {
            for (NSInteger i = 0; i<5; i++) {
                
                [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                
            }
        }
        
        if (max<=10&&max>5) {
            
            
            for (NSInteger i = 0; i<5; i++) {
                
                [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                
            }
            
        }else if(max>10&&max<=50){
            
            for (NSInteger i = 0; i<max/5+1; i++) {
                [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                
                
            }
            
        }else if(max<=100){
            
            for (NSInteger i = 0; i<max/10; i++) {
                [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*10]];
                
                
            }
            
        }else if(max > 100){
            
            NSInteger count = max / 10;
            
            for (NSInteger i = 0; i<10+1; i++) {
                [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                
            }
        }
        
        
        _xArrayForFirst = [arr copy];
         
    }
}

/**
 *  更新Y轴的刻度大小
 */
- (void)updateYScale{
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:{
            
            NSInteger max = 0;
            NSInteger min = 0;
//            if (_valueArr.count==0) {
//                _valueArr=@[@[@"10",@"20",@"30",@"40",@"50"]];
//            }
            
            for (NSArray *arr in _valueArr) {
                for (NSString * numer  in arr) {
                    NSInteger i = [numer integerValue];
                    if (i>=max) {
                        max = i;
                    }
                    if (i<=min) {
                        min = i;
                    }
                }
                
            }
            
            min = labs(min);
            max = (min<max?(max):(min));
            if (max%5==0) {
                max = max;
            }else
                max = (max/5+1)*5;
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *minArr = [NSMutableArray array];
            if (max>0 && max<=5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*1]];
                }
            }
            
            if (max<=10&&max>5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*2]];
                }
                
            }else if(max>10&&max<=100){
                
                
                for (NSInteger i = 0; i<max/5; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*5]];
                }
                
            }else{
                
                NSInteger Ynum=6;
                NSInteger count = max / (Ynum);
                if (count==0) {
                    count=1;
                }
                
                for (NSInteger i = 0; i<Ynum; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*count]];
                }
                
            }
            _yLineDataArr = @[[arr copy],[minArr copy]];
            
            
            [self setNeedsDisplay];
            
            
        }break;
        case JHLineChartQuadrantTypeAllQuardrantYD:{
            
            NSInteger max = 0;
            NSInteger min = 0;
            
            
            for (NSArray *arr in _valueArr) {
                for (NSString * numer  in arr) {
                    NSInteger i = [numer integerValue];
                    if (i>=max) {
                        max = i;
                    }
                    if (i<=min) {
                        min = i;
                    }
                }
                
            }
            
            
            min = labs(min);
            max = (min<max?(max):(min));
            if (max%5==0) {
                max = max;
            }else
                max = (max/5+1)*5;
            NSMutableArray *arr = [NSMutableArray array];
            NSMutableArray *minArr = [NSMutableArray array];
            if (max<=5) {
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*1]];
                }
            }
            
            if (max<=10&&max>5) {
                
                
                for (NSInteger i = 0; i<5; i++) {
                    
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*2]];
                    
                }
                
            }else if(max>10&&max<=100){
                
                
                for (NSInteger i = 0; i<max/5; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*5]];
                }
                
            }else{
                
                NSInteger count = max / 10;
                
                for (NSInteger i = 0; i<11; i++) {
                    [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                    [minArr addObject:[NSString stringWithFormat:@"-%ld",(i+1)*count]];
                }
                
            }
            
            _yLineDataArr = @[[arr copy],[minArr copy]];
            
            [self setNeedsDisplay];
        }break;
        default:{
            if (_valueArr.count) {
                
                NSInteger max=0;
                
                for (NSArray *arr in _valueArr) {
                    for (NSString * numer  in arr) {
                        NSInteger i = [numer integerValue];
                        if (i>=max) {
                            max = i;
                        }
                        
                    }
                    
                }
                
                
                if (max%5==0) {
                    max = max;
                }else
                    max = (max/5+1)*5;
                _yLineDataArr = nil;
                NSMutableArray *arr = [NSMutableArray array];
                if (max<=5) {
                    for (NSInteger i = 0; i<5; i++) {
                        
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*1]];
                        
                    }
                }
                
                if (max<=10&&max>5) {
                    
                    
                    for (NSInteger i = 0; i<5; i++) {
                        
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*2]];
                        
                    }
                    
                }else if(max>10&&max<=50){
                    
                    for (NSInteger i = 0; i<max/5+1; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*5]];
                        
                        
                    }
                    
                }else if(max<=100){
                    
                    for (NSInteger i = 0; i<max/10; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*10]];
                        
                        
                    }
                    
                }else if(max > 100){
                    
                    NSInteger count = max / 10;
                    
                    for (NSInteger i = 0; i<10+1; i++) {
                        [arr addObject:[NSString stringWithFormat:@"%ld",(i+1)*count]];
                        
                    }
                }
                
                
                _yLineDataArr = [arr copy];
                
                [self setNeedsDisplay];
                
                
            }
            
        }
            break;
    }
    
    
    
}

-(void)setContentInsets:(UIEdgeInsets)contentInsets{
    [super setContentInsets:contentInsets];
    [self configChartOrigin];
}

/**
 *  构建折线图原点
 */
- (void)configChartOrigin{
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYD:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left, self.frame.size.height-self.contentInsets.bottom-kXandYSpaceForSuperView);
        }
            break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYD:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left+_xLength/2, CGRectGetHeight(self.frame)-self.contentInsets.bottom);
        }
            break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left, self.contentInsets.top+_yLength/2);
        }
            break;
        case JHLineChartQuadrantTypeAllQuardrantYD:
        {
            self.chartOrigin = CGPointMake(self.contentInsets.left+_xLength/2, self.contentInsets.top+_yLength/2);
        }
            break;
            
        default:
            break;
    }
    
}


- (void)setPointGap:(CGFloat)pointGap {
    _pointGap = pointGap;
    
    [self clear];
    [self setNeedsDisplay];
}

- (void)setIsLongPress:(BOOL)isLongPress {
    
    
    _isLongPress = isLongPress;
    

    
   //  [self clear];
 [self setNeedsDisplay];
    
}

/* 绘制x与y轴 */
- (void)drawXAndYLineWithContext:(CGContextRef)context{
    
    if (_lableArray.count>0) {
        for (UILabel *lable in _lableArray) { 
            [lable removeFromSuperview];
        }
    }
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYD:{
            
            [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(_perXLen*(_MaxX-1), self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength+kXandYSpaceForSuperView) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_showDoubleYLevelLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x+_xLength, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x + _xLength,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            
            if (_xLineDataArr.count>0) {
            //    CGFloat xPace = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
                  CGFloat xPace = _perXLen;
                         _lableArray=[NSMutableArray array];
                _lastLableX=0;
                
                for (NSInteger i = 0; i<_MaxX;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%ld",i]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y, contentSize.width, kXandYSpaceForSuperView)];
                        label.text = [NSString stringWithFormat:@"%ld",i];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.tintColor=_xAndYNumberColor;
                        label.adjustsFontSizeToFitWidth=YES;
                   
                        if (p.x>(_lastLableX+(_xDescMaxWidth*2))) {
                            [self addSubview:label];
                            [_lableArray addObject:label];
                            _lastLableX=p.x;
                        //    NSLog(@"x=%ld",i);
                        }
                    
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:_xLineDataArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
                
                
            }
            
            
            if (_showDoubleYLevelLine) {
                NSArray *leftArray = nil;
                NSArray *rightArray = nil;
                NSAssert(_yLineDataArr.count == 2 && [_yLineDataArr[0] isKindOfClass:[NSArray class]] && [_yLineDataArr[1] isKindOfClass:[NSArray class]] , @"when property showDoubleYLevelLine is true,you must define yLineDataArr as @[@[@1,@2,@3],@[@5,@10,@10]]");
                leftArray = _yLineDataArr[0];
                rightArray = _yLineDataArr[1];
                NSAssert(leftArray.count == rightArray.count && leftArray.count > 0, @"when property showDoubleYLevelLine is true,leftArray.count == rightArray.count");
                if(leftArray.count == rightArray.count && leftArray.count > 0){
                    CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(leftArray.count);
                    for (NSInteger i = 0; i<leftArray.count; i++) {
                        CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                        
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:leftArray[i]].width;
                        CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:leftArray[i]].height;
                        if (_showYLevelLine) {
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                            
                        }else{
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        }
                        [self drawText:[NSString stringWithFormat:@"%@",leftArray[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                        
                        p = P_M(self.chartOrigin.x + _xLength, p.y);
                        len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:rightArray[i]].width;
                        hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:rightArray[i]].height;
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArray[i]] andContext:context atPoint:P_M(p.x + 3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                        
                        
                    }
                }
                
            }else{
                if (_yLineDataArr.count>0) {
                    
                    CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
                    for (NSInteger i = 0; i<_yLineDataArr.count; i++) {
                        CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                        
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].width;
                        CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].height;
                        
                        //虚线
                        if (_showYLevelLine) {
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(_perXLen*(_MaxX-1), p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                            
                        }else{
                            [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        }
                        [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    }
                }
            }
            
            
            
        }break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYD:{
            [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left, self.chartOrigin.y) andEndPoint:P_M(self.contentInsets.left+_xLength, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_xLineDataArr.count == 2) {
                NSArray * rightArr = _xLineDataArr[1];
                NSArray * leftArr = _xLineDataArr[0];
                
                CGFloat xPace = (_xLength/2-kXandYSpaceForSuperView)/(rightArr.count-1);
                
                for (NSInteger i = 0; i<rightArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",rightArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",rightArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:rightArr[i]].width;
                        
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
                for (NSInteger i = 0; i<leftArr.count;i++ ) {
                    CGPoint p = P_M(self.chartOrigin.x-(i+1)*xPace, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",leftArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",leftArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:leftArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        [self drawText:[NSString stringWithFormat:@"%@",leftArr[leftArr.count-1-i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
            }
            if (_yLineDataArr.count>0) {
                CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
                for (NSInteger i = 0; i<_yLineDataArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:_yLineDataArr[i]].height;
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left, p.y) andEndPoint:P_M(self.contentInsets.left+_xLength, p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
            }
            
        }break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:{
            [self drawLineWithContext:context andStarPoint:self.chartOrigin andEndPoint:P_M(_perXLen*(_xLineDataArr.count-1), self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.contentInsets.left,CGRectGetHeight(self.frame)-self.contentInsets.bottom) andEndPoint:P_M(self.contentInsets.left,self.contentInsets.top) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            if (_xLineDataArr.count>0) {
                //    CGFloat xPace = (_xLength-kXandYSpaceForSuperView)/(_xLineDataArr.count-1);
                CGFloat xPace = _perXLen;
                _lableArray=[NSMutableArray array];
                _lastLableX=0;
                
                for (NSInteger i = 0; i<_MaxX;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%ld",i]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y, contentSize.width, kXandYSpaceForSuperView)];
                        label.text = [NSString stringWithFormat:@"%ld",i];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.tintColor=_xAndYNumberColor;
                        label.adjustsFontSizeToFitWidth=YES;
                        
                        if (p.x>(_lastLableX+(_xDescMaxWidth*1.5))) {
                            [self addSubview:label];
                            [_lableArray addObject:label];
                            _lastLableX=p.x;
                            //    NSLog(@"x=%ld",i);
                        }
                        
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.xDescTextFontSize aimString:_xLineDataArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",_xLineDataArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
                
                
            }
            
            if (_yLineDataArr.count == 2) {
                
                NSArray * topArr = _yLineDataArr[0];
                NSArray * bottomArr = _yLineDataArr[1];
                CGFloat yPace = (_yLength/2 - kXandYSpaceForSuperView)/([_yLineDataArr[0] count]);
                _perYlen = yPace;
                for (NSInteger i = 0; i<topArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
//                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:topArr[i]].width;
//                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:topArr[i]].height;
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(_perXLen*(_xLineDataArr.count-1), p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    
                    //y坐标轴的值
//                    [self drawText:[NSString stringWithFormat:@"%@",topArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    
                }
                
                
                for (NSInteger i = 0; i<bottomArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y + (i+1)*yPace);
                //    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:bottomArr[i]].width;
              //      CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:bottomArr[i]].height;
                    
                    if (_showYLevelLine) {
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(_perXLen*(_xLineDataArr.count-1), p.y) andIsDottedLine:YES andColor:self.xAndYLineColor];
                    }else{
                        
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    }
//                    [self drawText:[NSString stringWithFormat:@"%@",bottomArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
                
                
            }
            
        }break;
        case JHLineChartQuadrantTypeAllQuardrantYD:{
            [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x-_xLength/2, self.chartOrigin.y) andEndPoint:P_M(self.chartOrigin.x+_xLength/2, self.chartOrigin.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
            
            if (_showYLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x,self.chartOrigin.y+_yLength/2) andEndPoint:P_M(self.chartOrigin.x,self.chartOrigin.y-_yLength/2) andIsDottedLine:NO andColor:self.xAndYLineColor];
            }
            
            
            
            if (_xLineDataArr.count == 2) {
                NSArray * rightArr = _xLineDataArr[1];
                NSArray * leftArr = _xLineDataArr[0];
                
                CGFloat xPace = (_xLength/2-kXandYSpaceForSuperView)/(rightArr.count-1);
                
                for (NSInteger i = 0; i<rightArr.count;i++ ) {
                    CGPoint p = P_M(i*xPace+self.chartOrigin.x, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",rightArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",rightArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.xDescTextFontSize aimString:rightArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",rightArr[i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                for (NSInteger i = 0; i<leftArr.count;i++ ) {
                    CGPoint p = P_M(self.chartOrigin.x-(i+1)*xPace, self.chartOrigin.y);
                    if (_showXDescVertical) {
                        CGSize contentSize = [self sizeOfStringWithMaxSize:CGSizeMake(_xDescMaxWidth, CGFLOAT_MAX) textFont:self.xDescTextFontSize aimString:[NSString stringWithFormat:@"%@",leftArr[i]]];
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x - contentSize.width / 2.0, p.y+2, contentSize.width, contentSize.height)];
                        label.text = [NSString stringWithFormat:@"%@",leftArr[i]];
                        label.font = [UIFont systemFontOfSize:self.xDescTextFontSize];
                        label.numberOfLines = 0;
                        label.transform = CGAffineTransformRotate(label.transform, _xDescriptionAngle);
                        [self addSubview:label];
                    }else{
                        CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.xDescTextFontSize aimString:leftArr[i]].width;
                        [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, p.y-3) andIsDottedLine:NO andColor:self.xAndYLineColor];
                        
                        [self drawText:[NSString stringWithFormat:@"%@",leftArr[leftArr.count-1-i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor andFontSize:self.xDescTextFontSize];
                    }
                }
                
            }
            
            
            if (_yLineDataArr.count == 2) {
                
                NSArray * topArr = _yLineDataArr[0];
                NSArray * bottomArr = _yLineDataArr[1];
                CGFloat yPace = (_yLength/2 - kXandYSpaceForSuperView)/([_yLineDataArr[0] count]);
                _perYlen = yPace;
                for (NSInteger i = 0; i<topArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y - (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:topArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:topArr[i]].height;
                    
                    [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",topArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                    
                }
                
                
                for (NSInteger i = 0; i<bottomArr.count; i++) {
                    CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y + (i+1)*yPace);
                    CGFloat len = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:bottomArr[i]].width;
                    CGFloat hei = [self sizeOfStringWithMaxSize:CGSizeMake(CGFLOAT_MAX, 30) textFont:self.yDescTextFontSize aimString:bottomArr[i]].height;
                    
                    [self drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+3, p.y) andIsDottedLine:NO andColor:self.xAndYLineColor];
                    [self drawText:[NSString stringWithFormat:@"%@",bottomArr[i]] andContext:context atPoint:P_M(p.x-len-3, p.y-hei / 2) WithColor:_xAndYNumberColor andFontSize:self.yDescTextFontSize];
                }
                
                
            }
            
        }break;
            
        default:
            break;
    }
    
    
}

/**
 *  动画展示路径
 */
-(void)showAnimation{
    [self configChartXAndYLength];
    [self configChartOrigin];
    [self configPerXAndPerY];
    [self configValueDataArray];
    [self drawAnimation];
}


- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if(self.isLongPress)
    {
              [self drawXAndYLineWithContext:context];
        
           [self longPressView];
    }else{
        [self configValueDataArray];
        [self drawAnimation];
        
        [self drawXAndYLineWithContext:context];
        
        
        if (!_isEndAnimation) {
            return;
        }
        
        if (_drawDataArr.count) {
            [self drawPositionLineWithContext:context];
        }
    }

    
}

-(void)longPressView{
    //长按时进入
    if(self.isLongPress)
    {
            CGContextRef context = UIGraphicsGetCurrentContext();

        NSLog(@"%f",_currentLoc.x/self.pointGap);
        int nowPoint = _currentLoc.x/self.pointGap;
        NSInteger countNum=_xLineDataArr.count;
        if (_lineChartQuadrantType==JHLineChartQuadrantTypeFirstQuardrantYD) {
            countNum=_MaxX;
        }
        if(nowPoint >= 0 && nowPoint <countNum) {
            NSNumber *num ;
            if (_lineChartQuadrantType==JHLineChartQuadrantTypeFirstQuardrantYD) {
                 num = [NSNumber numberWithInt:nowPoint];
            }else{

                if(_xLineDataArr.count>(nowPoint+1)){
                        num = [_xLineDataArr objectAtIndex:(nowPoint+1)];
                }

            }




        //    NSLog(@"长按X=%@",num);
            CGFloat chartHeight = self.frame.size.height;

            CGPoint selectPoint = CGPointMake((nowPoint+1)*self.pointGap, chartHeight);

            CGContextSaveGState(context);


            // 画十字线
            CGContextRestoreGState(context);
            CGContextSetLineWidth(context, 1);
            CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
            CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);

//            // 选中横线
//            CGContextMoveToPoint(context, 0, selectPoint.y);
//            CGContextAddLineToPoint(context, self.frame.size.width, selectPoint.y);

            if (_lineChartQuadrantType==JHLineChartQuadrantTypeFirstQuardrantYD) {

                if (![_xLineDataArr containsObject:[NSString stringWithFormat:@"%d",nowPoint]]) {

                    for (int i=0; i<_xLineDataArr.count-1; i++) {
                        int A=[[NSString stringWithFormat:@"%@",_xLineDataArr[i]] intValue];
                        int B=[[NSString stringWithFormat:@"%@",_xLineDataArr[i+1]] intValue];
                        if ((A<nowPoint) && ( B>nowPoint)) {
                            if ( abs((A-nowPoint))>abs((B-nowPoint))) {
                                nowPoint=B;
                            }else{
                                nowPoint=A;
                            }

                        }
                    }
                         selectPoint = CGPointMake((nowPoint+1)*self.pointGap, chartHeight);
                }
                    // 选中竖线
                    CGContextMoveToPoint(context, selectPoint.x, 0);
                    CGContextAddLineToPoint(context, selectPoint.x, self.frame.size.height);

                    [self drawLine:context startPoint:CGPointMake(selectPoint.x, 0) endPoint:CGPointMake(selectPoint.x, self.frame.size.height) lineColor:[UIColor lightGrayColor] lineWidth:1];

            }else{
                // 选中竖线
                CGContextMoveToPoint(context, selectPoint.x, 0);
                CGContextAddLineToPoint(context, selectPoint.x, self.frame.size.height);

                [self drawLine:context startPoint:CGPointMake(selectPoint.x, 0) endPoint:CGPointMake(selectPoint.x, self.frame.size.height) lineColor:[UIColor lightGrayColor] lineWidth:1];
            }



            CGContextStrokePath(context);

            _xBlock(nowPoint);


            // 交界点
//            CGRect myOval = {selectPoint.x-2, selectPoint.y-2, 4, 4};
//            CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
//            CGContextAddEllipseInRect(context, myOval);

               //  CGContextFillPath(context);
        }
    }
    
    
    
}

- (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width {
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}


-(void)moveAnimation{
    [self configValueDataArray];
    [self drawAnimation];
    
  //  [self setNeedsDisplay];
}

/**
 *  装换值数组为点数组
 */
- (void)configValueDataArray{
    _drawDataArr = [NSMutableArray array];
    
    if (_valueArr.count==0) {
        return;
    }
    
    switch (_lineChartQuadrantType) {
        case JHLineChartQuadrantTypeFirstQuardrantYD:{
            
        //       CGFloat yPace = (_yLength - kXandYSpaceForSuperView)/(_yLineDataArr.count);
            
            if (_showDoubleYLevelLine) {
                _perValue = _perYlen/[[_yLineDataArr[0] firstObject] floatValue];
            }else{
                _perValue = _perYlen/[[_yLineDataArr firstObject] floatValue];
            }
            
            
            for (NSDictionary *valueArr in _allDicArray) {
                NSMutableArray *dataMArr = [NSMutableArray array];
                NSSortDescriptor *sortDescripttor1 = [NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES];
                NSArray *keyArray = [valueArr.allKeys sortedArrayUsingDescriptors:@[sortDescripttor1]];
                
                for (NSInteger i = 0; i<keyArray.count; i++) {
                    NSString *key=keyArray[i];
                    NSString*keyValue=[valueArr objectForKey:key];
                    
                    CGPoint p = P_M(([key floatValue])*_perXLen+self.chartOrigin.x,self.contentInsets.top + _yLength-kXandYSpaceForSuperView - [keyValue floatValue]*_perValue);
                    NSValue *value = [NSValue valueWithCGPoint:p];
                    [dataMArr addObject:value];
                }
                [_drawDataArr addObject:[dataMArr copy]];
                
            }
            
            if (_showDoubleYLevelLine) {
                CGFloat scale = [_yLineDataArr[0][0] floatValue] / [_yLineDataArr[1][0] floatValue];
                for (NSArray *valueArr in _valueBaseRightYLineArray) {
                    NSMutableArray *dataMArr = [NSMutableArray array];
                    for (NSInteger i = _drawPathFromXIndex; i<valueArr.count; i++) {
                        CGPoint p = P_M(i*_perXLen+self.chartOrigin.x,self.contentInsets.top + _yLength - [valueArr[i] floatValue]*_perValue*scale);
                        NSValue *value = [NSValue valueWithCGPoint:p];
                        [dataMArr addObject:value];
                    }
                    
                    [_drawDataArr addObject:[dataMArr copy]];
                    
                }
            }
            
        }break;
        case JHLineChartQuadrantTypeFirstAndSecondQuardrantYD:{
            
            _perValue = _perYlen/[[_yLineDataArr firstObject] floatValue];
            
            
            
            for (NSArray *valueArr in _valueArr) {
                NSMutableArray *dataMArr = [NSMutableArray array];
                
                
                CGPoint p ;
                for (NSInteger i = 0; i<[_xLineDataArr[0] count]; i++) {
                    p = P_M(self.contentInsets.left + kXandYSpaceForSuperView+i*_perXLen, self.contentInsets.top + _yLength - [valueArr[i] floatValue]*_perValue);
                    [dataMArr addObject:[NSValue valueWithCGPoint:p]];
                }
                
                for (NSInteger i = 0; i<[_xLineDataArr[1] count]; i++) {
                    p = P_M(self.chartOrigin.x+i*_perXLen, self.contentInsets.top + _yLength - [valueArr[i+[_xLineDataArr[0] count]] floatValue]*_perValue);
                    [dataMArr addObject:[NSValue valueWithCGPoint:p]];
                    
                }
                
                
                
                [_drawDataArr addObject:[dataMArr copy]];
                
            }
            
            
            
            
        }break;
        case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:{
         //   float HH=[[_yLineDataArr[0] firstObject] floatValue];
//            CGFloat yPace = (_yLength/2 - kXandYSpaceForSuperView)/([_yLineDataArr[0] count]);
//            _perYlen = yPace;
//
//                        CGPoint p = P_M(self.chartOrigin.x, self.chartOrigin.y + (i+1)*yPace);
            NSInteger num=([_yLineDataArr[0] count]);
            _perYlen = (_yLength/2 - kXandYSpaceForSuperView)/num;
            
            float perYlenY=[[_yLineDataArr[0] firstObject] floatValue];
            
            _perValue = _perYlen/perYlenY;
            float  unitValue = _perYlen/perYlenY;
            for (NSArray *valueArr in _valueArr) {
                NSMutableArray *dataMArr = [NSMutableArray array];
                for (NSInteger i = _drawPathFromXIndex; i<valueArr.count; i++) {
                    float v0=[valueArr[i] floatValue];
                    CGPoint p = P_M(i*_perXLen+self.chartOrigin.x,self.chartOrigin.y- (v0*unitValue));
                    NSValue *value = [NSValue valueWithCGPoint:p];
                    [dataMArr addObject:value];
                }
                [_drawDataArr addObject:[dataMArr copy]];
                
            }
            
        }break;
        case JHLineChartQuadrantTypeAllQuardrantYD:{
            
            
            
            _perValue = _perYlen/[[_yLineDataArr[0] firstObject] floatValue];
            for (NSArray *valueArr in _valueArr) {
                NSMutableArray *dataMArr = [NSMutableArray array];
                
                
                CGPoint p ;
                for (NSInteger i = 0; i<[_xLineDataArr[0] count]; i++) {
                    p = P_M(self.contentInsets.left + kXandYSpaceForSuperView+i*_perXLen, self.chartOrigin.y-[valueArr[i] floatValue]*_perValue);
                    [dataMArr addObject:[NSValue valueWithCGPoint:p]];
                }
                
                for (NSInteger i = 0; i<[_xLineDataArr[1] count]; i++) {
                    p = P_M(self.chartOrigin.x+i*_perXLen, self.chartOrigin.y-[valueArr[i+[_xLineDataArr[0] count]] floatValue]*_perValue);
                    [dataMArr addObject:[NSValue valueWithCGPoint:p]];
                    
                }
                
                
                
                [_drawDataArr addObject:[dataMArr copy]];
                
            }
            
        }break;
        default:
            break;
    }
    
    
    
}


//执行动画
- (void)drawAnimation{
    
    [_shapeLayer removeFromSuperlayer];
    _shapeLayer = [CAShapeLayer layer];
    if (_drawDataArr.count==0) {
        return;
    }
    
    
    
    //第一、UIBezierPath绘制线段
  // [self configPerXAndPerY];
    
    
    for (NSInteger i = 0;i<_drawDataArr.count;i++) {
        
        NSArray *dataArr = _drawDataArr[i];
        
        [self drawPathWithDataArr:dataArr andIndex:i];
        
    }
    
    
    
}


- (CGPoint)centerOfFirstPoint:(CGPoint)p1 andSecondPoint:(CGPoint)p2{
    
    
    return P_M((p1.x + p2.x) / 2.0, (p1.y + p2.y) / 2.0);
    
}



- (void)drawPathWithDataArr:(NSArray *)dataArr andIndex:(NSInteger )colorIndex{
    
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 0, 0)];
    
 //   UIBezierPath *secondPath = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i<dataArr.count; i++) {
        
        NSValue *value = dataArr[i];
        
        CGPoint p = value.CGPointValue;
        
        if (_pathCurve) {
            if (i==0) {
                
                if (_contentFill) {
                    
//                    [secondPath moveToPoint:P_M(p.x, self.chartOrigin.y)];
//                    [secondPath addLineToPoint:p];
                }
                
                [firstPath moveToPoint:p];
            }else{
                CGPoint nextP = [dataArr[i-1] CGPointValue];
                CGPoint control1 = P_M(p.x + (nextP.x - p.x) / 2.0, nextP.y );
                CGPoint control2 = P_M(p.x + (nextP.x - p.x) / 2.0, p.y);
           //     [secondPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
                [firstPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
            }
        }else{
            
            if (i==0) {
                if (_contentFill) {
//                    [secondPath moveToPoint:P_M(p.x, self.chartOrigin.y)];
//                    [secondPath addLineToPoint:p];
                }
                [firstPath moveToPoint:p];
                //                   [secondPath moveToPoint:p];
            }else{
                [firstPath addLineToPoint:p];
//                [secondPath moveToPoint:p];
//                [secondPath addLineToPoint:p];
            }
            
        }
        
        if (i==dataArr.count-1) {
            
   //        [secondPath addLineToPoint:P_M(p.x, self.chartOrigin.y)];
            
        }
    }
    
    
    
    if (_contentFill) {
   //     [secondPath closePath];
    }
    
    //第二、UIBezierPath和CAShapeLayer关联
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = firstPath.CGPath;
    UIColor *color = (_valueLineColorArr.count==_drawDataArr.count?(_valueLineColorArr[colorIndex]):([UIColor orangeColor]));
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = (_animationPathWidth<=0?2:_animationPathWidth);
    
    //第三，动画
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    
    ani.fromValue = @0;
    
    ani.toValue = @1;
    
    ani.duration = self.animationDuration;
    
    ani.delegate = self;
    
    if (ani.duration > 0) {
        [shapeLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    }else{
        ani = nil;
    }
    
    [self.layer addSublayer:shapeLayer];
    [_layerArr addObject:shapeLayer];
    
  //weakSelf(weakSelf)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ani.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        CAShapeLayer *shaperLay = [CAShapeLayer layer];
//        shaperLay.frame = weakself.bounds;
//     //   shaperLay.path = secondPath.CGPath;
//        if (weakself.contentFillColorArr.count == weakself.drawDataArr.count) {
//
//            shaperLay.fillColor = [weakself.contentFillColorArr[colorIndex] CGColor];
//        }else{
//            shaperLay.fillColor = [UIColor clearColor].CGColor;
//        }
//
//        [weakself.layer addSublayer:shaperLay];
//        [_layerArr addObject:shaperLay];
//    });
    
    
}



/**
 *  设置点的引导虚线
 *
 *  @param context 图形面板上下文
 */
- (void)drawPositionLineWithContext:(CGContextRef)context{
    
    
    
    if (_drawDataArr.count==0) {
        return;
    }
    
    
    
    for (NSInteger m = 0;m<_valueArr.count;m++) {
        NSArray *arr = _drawDataArr[m];
        
        for (NSInteger i = 0 ;i<arr.count;i++ ) {
            
            CGPoint p = [arr[i] CGPointValue];
            UIColor *positionLineColor;
            if (_positionLineColorArr.count == _valueArr.count) {
                positionLineColor = _positionLineColorArr[m];
            }else
                positionLineColor = [UIColor orangeColor];
            
            
            if (_showValueLeadingLine) {
                [self drawLineWithContext:context andStarPoint:P_M(self.chartOrigin.x, p.y) andEndPoint:p andIsDottedLine:YES andColor:positionLineColor];
                [self drawLineWithContext:context andStarPoint:P_M(p.x, self.chartOrigin.y) andEndPoint:p andIsDottedLine:YES andColor:positionLineColor];
            }
            
            if (!_showPointDescription) {
                continue;
            }
            if (p.y!=0) {
                UIColor *pointNumberColor = (_pointNumberColorArr.count == _valueArr.count?(_pointNumberColorArr[m]):([UIColor orangeColor]));
                
                switch (_lineChartQuadrantType) {
                        
                        
                    case JHLineChartQuadrantTypeFirstQuardrantYD:
                    {
                        NSString *aimStr = [NSString stringWithFormat:@"(%@,%@)",_xLineDataArr[i],_valueArr[m][i]];
                        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(100, 25) textFont:self.valueFontSize aimString:aimStr];
                        CGFloat length = size.width;
                        
                        [self drawText:aimStr andContext:context atPoint:P_M(p.x - length / 2, p.y - size.height / 2 -10) WithColor:pointNumberColor andFontSize:self.valueFontSize];
                    }
                        break;
                    case JHLineChartQuadrantTypeFirstAndSecondQuardrantYD:
                    {
                        NSString *str = (i<[_xLineDataArr[0] count]?(_xLineDataArr[0][i]):(_xLineDataArr[1][i-[_xLineDataArr[0] count]]));
                        
                        NSString *aimStr = [NSString stringWithFormat:@"(%@,%@)",str,_valueArr[m][i]];
                        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(100, 25) textFont:self.valueFontSize aimString:aimStr];
                        CGFloat length = size.width;
                        [self drawText:aimStr andContext:context atPoint:P_M(p.x - length / 2, p.y - size.height / 2 -5) WithColor:pointNumberColor andFontSize:self.valueFontSize];
                    }
                        break;
                    case JHLineChartQuadrantTypeFirstAndFouthQuardrantYD:
                    {
                        NSString *aimStr = [NSString stringWithFormat:@"(%@,%@)",_xLineDataArr[i],_valueArr[m][i]];
                        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(100, 25) textFont:self.valueFontSize aimString:aimStr];
                        CGFloat length = size.width;
                        [self drawText:aimStr andContext:context atPoint:P_M(p.x - length / 2, p.y - size.height / 2 -5) WithColor:pointNumberColor andFontSize:self.valueFontSize];
                    }
                        break;
                    case JHLineChartQuadrantTypeAllQuardrantYD:
                    {
                        NSString *str = (i<[_xLineDataArr[0] count]?(_xLineDataArr[0][i]):(_xLineDataArr[1][i-[_xLineDataArr[0] count]]));
                        
                        NSString *aimStr =[NSString stringWithFormat:@"(%@,%@)",str,_valueArr[m][i]];
                        CGSize size = [self sizeOfStringWithMaxSize:CGSizeMake(100, 25) textFont:self.valueFontSize aimString:aimStr];
                        CGFloat length = size.width;
                        
                        [self drawText:aimStr andContext:context atPoint:P_M(p.x - length / 2, p.y - size.height / 2 -5) WithColor:pointNumberColor andFontSize:self.valueFontSize];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
            
            
        }
    }
    
    _isEndAnimation = NO;
    
    
}





-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {

   //[self drawPoint];
 
    }
    
}

/**
 *  绘制值的点
 */
- (void)drawPoint{
    
    for (NSInteger m = 0;m<_drawDataArr.count;m++) {
        
        NSArray *arr = _drawDataArr[m];
        for (NSInteger i = 0; i<arr.count; i++) {
            
            NSValue *value = arr[i];
            
            CGPoint p = value.CGPointValue;
            
            
            UIBezierPath *pBezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 5, 5)];
            [pBezier moveToPoint:p];
            //            [pBezier addArcWithCenter:p radius:13 startAngle:0 endAngle:M_PI*2 clockwise:YES];
            CAShapeLayer *pLayer = [CAShapeLayer layer];
            pLayer.frame = CGRectMake(0, 0, 5, 5);
            pLayer.position = p;
            pLayer.path = pBezier.CGPath;
            
            UIColor *color = _pointColorArr.count==_drawDataArr.count?(_pointColorArr[m]):([UIColor orangeColor]);
            
            pLayer.fillColor = color.CGColor;
            
            CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
            
            ani.fromValue = @0;
            
            ani.toValue = @1;
            
            ani.duration = 1;
            
            
            [pLayer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
            
            [self.layer addSublayer:pLayer];
            
            [_layerArr addObject:pLayer];
            
            
        }
        _isEndAnimation = YES;
        
        [self setNeedsDisplay];
    }
}






@end
