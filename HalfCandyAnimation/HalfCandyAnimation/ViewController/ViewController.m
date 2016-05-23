//
//  ViewController.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "ViewController.h"
#import "QCNetworking.h"
#import "QCHiveHomePage.h"
#import <MJExtension/MJExtension.h>
#import "Data.h"
#import "Sub.h"
#import "HiveTableViewCell.h"
#import "SecondViewController.h"
#import "MagicMoveTransition.h"

static NSString * const kTableViewCell = @"cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, QCNetworkResult, UINavigationControllerDelegate>
@property (nonatomic, strong, readwrite) UITableView *halfSurgeTableView;
@property (nonatomic, strong) QCHiveHomePage *homePageModel;
@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    self.halfSurgeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.halfSurgeTableView.delegate = self;
    self.halfSurgeTableView.dataSource = self;
    [self.view addSubview:self.halfSurgeTableView];
    self.halfSurgeTableView.tableFooterView = [[UIView alloc] init];
    [self.halfSurgeTableView registerNib:[UINib nibWithNibName:@"HiveTableViewCell" bundle:nil] forCellReuseIdentifier:kTableViewCell];
    
    [self handleData];
}

- (void)handleData {
    QCRequest *request = [[QCRequest alloc] init];
    request.urlString = @"http://v23appapi.hivetrips.com/index/list?";
    [QCNetworkManager defaultManager].delegate = self;
    [[QCNetworkManager defaultManager] getRequest:request];
}

- (void)requestedError:(NSError *)error {
    
}

- (void)requestedSuccess:(id)responseObject {
    self.homePageModel = [QCHiveHomePage mj_objectWithKeyValues:responseObject];
    [self.halfSurgeTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homePageModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Data *subArray = self.homePageModel.data[section];
    return subArray.sub.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Data *subArray = self.homePageModel.data[section];
    return subArray.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell];
    Data *subArray = self.homePageModel.data[indexPath.section];
    Sub *sub = subArray.sub[indexPath.row];
    cell.sub = sub;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HiveTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SecondViewController *svc = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    svc.sub = [self.homePageModel.data[indexPath.section] sub][indexPath.row];
    svc.image = cell.myImageView.image;
    [self.navigationController pushViewController:svc animated:YES];
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if ([toVC isKindOfClass:[SecondViewController class]]) {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc]init];
        return transition;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
