//
//  LZPageViewController.m
//  LZSegmentPageController
//
//  Created by nacker on 16/3/25.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import "LZPageViewController.h"
#import "LZPageContentView.h"
#import "LZPageMainCell.h"
#import "addServerViewController.h"
#import "RKAlertView.h"
#import "newEnergyStorage.h"
#import "newEnergyStorage2000.h"
#import "newEnergySPF5000.h"
#import "newEnergyMix.h"

@interface LZPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LZPageContentViewDelegate>
@property (nonatomic, assign) CGFloat pageBarHeight;
@property (nonatomic, weak) LZPageContentView *contentViews;
@property (nonatomic, weak) UICollectionView *collectionMain;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic,assign) int lastPositionX;
@property (nonatomic,assign) BOOL scrollToRight;

@property (nonatomic ,strong) NSArray *itemsArray;
@property (nonatomic, strong) NSArray *controllersClass;
@property (nonatomic, strong) NSMutableArray *controllers;
@end

#define CollectionWidth (SCREEN_Width - 120)


static NSString *mainCell = @"mainCellmainCell";

@implementation LZPageViewController

- (NSMutableArray *)controllers{
    if (!_controllers) {
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < _controllersClass.count; i ++) {
            Class className = _controllersClass[i];
            UIViewController *vc = [[className alloc] init];
            vc.title = _itemsArray[i];
            [self addChildViewController:vc];
            [controllers addObject:vc];
        }
        _controllers = controllers;
    }
    return _controllers;
}

- (instancetype)initWithTitles:(NSArray *)titlesArray controllersClass:(NSArray *)controllersClass
{
    if (self = [super init]) {
        
        self.itemsArray = titlesArray;
        self.controllersClass = controllersClass;
        self.pageBarHeight = 30*HEIGHT_SIZE;
        [self addCollectionPage];
        [self addCollectionMain];
    }
    return self;
}

-(void)setPageBarHeight:(CGFloat)pageBarHeight{
    _pageBarHeight = pageBarHeight;
}

-(void)viewDidAppear:(BOOL)animated{


}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([_type isEqualToString:@"1"]) {
        self.title = root_energy_title;
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *isNew=[ud objectForKey:@"isNewEnergy"];
        
      
         //   NSString *deviceType=[[ud objectForKey:@"PcsDeviceType"] stringValue];
        
        NSString *deviceType=[NSString stringWithFormat:@"%@",[ud objectForKey:@"PcsDeviceType"]];
        
        if ([isNew isEqualToString:@"Y"]) {
            if ([deviceType isEqualToString:@"0"]) {
          //        self.title = @"";
                newEnergyStorage2000 *findVc=[[newEnergyStorage2000 alloc]init];
             [self.navigationController pushViewController:findVc animated:YES];
            //    [self presentViewController:findVc animated:NO completion:nil];
              
            }else if ([deviceType isEqualToString:@"1"]) {
               //     self.title = @"";
                newEnergyStorage *findVc=[[newEnergyStorage alloc]init];
          [self.navigationController pushViewController:findVc animated:YES];
            }else if ([deviceType isEqualToString:@"2"]) {
                //     self.title = @"";
                newEnergySPF5000 *findVc=[[newEnergySPF5000 alloc]init];
                [self.navigationController pushViewController:findVc animated:YES];
            }else if ([deviceType isEqualToString:@"3"]) {
                //     self.title = @"";
                newEnergyMix *findVc=[[newEnergyMix alloc]init];
                [self.navigationController pushViewController:findVc animated:YES];
            }

        }
        
    }else{
        self.title = root_ME_kefu;
        
        NSString *serviceBool=[[NSUserDefaults standardUserDefaults]objectForKey:@"serviceBool"];
        
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *Username=[ud objectForKey:@"userName"];
        
        if ([serviceBool isEqualToString:@"1"]||[Username isEqualToString:Demo_Name]) {

            UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_tianjia_1 style:UIBarButtonItemStylePlain target:self action:@selector(doAdd)];
            rightItem.tag=10;
            self.navigationItem.rightBarButtonItem=rightItem;
            
        }
        
        
        
      
    }

}

-(void)viewDidLoad{
    [super viewDidLoad];
    

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _scrollToRight = YES;
    _lastPositionX = 0;
}

- (void)doAdd{
    
    [RKAlertView showNoCancelBtnAlertWithTitle:root_Alet_user message:root_tianjia_wenti_Alert confirmTitle:root_OK confrimBlock:^{
        addServerViewController *add=[[addServerViewController alloc]init];
        [self.navigationController pushViewController:add animated:NO];
    }];
    
  

}

- (void)addCollectionPage{
    
    LZPageContentView *contentViews = [[LZPageContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.pageBarHeight) itemsArray:self.itemsArray];
    contentViews.delegate = self;
    [self.view addSubview:contentViews];
    self.contentViews = contentViews;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor =mainColor;
    self.lineWidth = self.view.frame.size.width / self.itemsArray.count;
    line.frame = CGRectMake(0, self.pageBarHeight - 3, self.lineWidth, 3);
    [self.contentViews addSubview:line];
    [self.contentViews bringSubviewToFront:line];
    self.line = line;
}

- (void)addCollectionMain{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGRect frame = CGRectMake(0, CGRectGetMaxY(self.contentViews.frame), self.view.frame.size.width, self.view.frame.size.height - self.pageBarHeight - 64);
    
    UICollectionView *collectionMain = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionMain.dataSource = self;
    collectionMain.delegate = self;
    collectionMain.pagingEnabled = YES;
    collectionMain.scrollEnabled = YES;
    collectionMain.bounces = NO;
    collectionMain.showsHorizontalScrollIndicator = NO;
    [collectionMain registerClass:[LZPageMainCell class] forCellWithReuseIdentifier:mainCell];
    [self.view addSubview:collectionMain];
    [self.view bringSubviewToFront:collectionMain];
    self.collectionMain = collectionMain;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZPageMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mainCell forIndexPath:indexPath];
    [cell setIndexController:self.controllers[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionMain scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake((0 + indexPath.row) * self.lineWidth, self.pageBarHeight - 3, self.lineWidth, 3);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x ;
    int index = (x + SCREEN_Width * 0.5) / SCREEN_Width;
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(index *self.lineWidth, self.pageBarHeight - 3, self.lineWidth, 3);
    }];
    self.contentViews.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.x;
    if (currentPostion - _lastPositionX > 5) {
        _scrollToRight = YES;
    }else if(currentPostion - _lastPositionX < -5){
        _scrollToRight = NO;
    }
    _lastPositionX = currentPostion;
}

#pragma mark - LZPageContentViewDelegate
- (void)pageContentView:(LZPageContentView *)pageContentView didClickBtnIndex:(NSInteger)index
{
    [self.collectionMain scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake((0 + index) *self.lineWidth, self.pageBarHeight - 3, self.lineWidth, 3);
    }];
}


@end
