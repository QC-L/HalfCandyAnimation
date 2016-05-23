//
//  SecondViewController.h
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Sub;

@interface SecondViewController : UIViewController
@property (nonatomic, strong) Sub *sub;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) UIImage *image;

@end
