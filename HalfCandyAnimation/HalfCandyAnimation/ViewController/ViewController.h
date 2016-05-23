//
//  ViewController.h
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong, readonly) UITableView *halfSurgeTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic,assign)CGRect finalCellRect;
@end

