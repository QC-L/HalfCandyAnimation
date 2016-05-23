//
//  HiveTableViewCell.h
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sub;
@interface HiveTableViewCell : UITableViewCell
@property (nonatomic, strong) Sub *sub;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@end
