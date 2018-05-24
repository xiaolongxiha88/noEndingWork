//
//  stationTableView.h
//  shinelink
//
//  Created by sky on 16/4/27.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stationTableView : UITableViewController

@property(nonatomic,strong)NSString *stationId;

@property(nonatomic,assign)NSInteger setType;

@property (nonatomic,copy) void(^goToPlantBlock)();

@end
