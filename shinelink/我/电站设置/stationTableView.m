//
//  stationTableView.m
//  shinelink
//
//  Created by sky on 16/4/27.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "stationTableView.h"
#import "StationSafeViewController.h"
#import "StationLocationViewController.h"
#import "StationAppearanceViewController.h"
#import "StationEarningsViewController.h"
#import"addStationViewController.h"

@interface stationTableView ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIBarButtonItem *leftItem;
@end

@implementation stationTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_setType==1) {
        _leftItem=[[UIBarButtonItem alloc]initWithTitle:root_oss_512_fanHui_dianZhanGuanLi style:UIBarButtonItemStylePlain target:self action:@selector(goToPlantEdit)];
        self.navigationItem.leftBarButtonItem=_leftItem;
    }
    
    self.view.backgroundColor=MainColor;
       self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
       self.tableView.separatorColor=[UIColor whiteColor];
    self.dataArray =[NSMutableArray arrayWithObjects:root_WO_anzhuang,root_WO_dili,root_WO_zijin,root_WO_tupian,nil];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (_setType!=1) {
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:root_tianjia_1 style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed)];
        rightItem.tag=10;
        self.navigationItem.rightBarButtonItem=rightItem;
    }
 
}


-(void)goToPlantEdit{
    self.goToPlantBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)buttonPressed{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:root_demo_Alert cancelButtonTitle:root_Yes];
        return;
    }else{
        addStationViewController *addView=[[addStationViewController alloc]init];
        [self.navigationController pushViewController:addView animated:YES];
    }

}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
       cell.backgroundColor=MainColor;
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.tintColor = [UIColor lightGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    if (indexPath.row==0) {
        StationSafeViewController *aboutView = [[StationSafeViewController alloc]init];
        if (_setType==1) {
            aboutView.stationId=_stationId;
            aboutView.setType=1;
        }
        [self.navigationController pushViewController:aboutView animated:NO];
      
    }else if (indexPath.row==1){
        StationLocationViewController *aboutView = [[StationLocationViewController alloc]init];
        if (_setType==1) {
            aboutView.stationId=_stationId;
            aboutView.setType=1;
        }
   
        [self.navigationController pushViewController:aboutView animated:NO];
    }else if (indexPath.row==2){
        StationEarningsViewController *aboutView = [[StationEarningsViewController alloc]init];
        if (_setType==1) {
            aboutView.stationId=_stationId;
            aboutView.setType=1;
        }
        [self.navigationController pushViewController:aboutView animated:NO];
    }else if (indexPath.row==3){
        StationAppearanceViewController *aboutView = [[StationAppearanceViewController alloc]init];
        if (_setType==1) {
            aboutView.stationId=_stationId;
            aboutView.setType=1;
        }
        [self.navigationController pushViewController:aboutView animated:NO];
    }
   
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
