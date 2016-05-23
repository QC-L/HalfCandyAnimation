//
//  SecondViewController.m
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "SecondViewController.h"
#import "MagicMoveBackTransition.h"
#import "ViewController.h"

@interface SecondViewController () <UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation SecondViewController

- (void)awakeFromNib {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.delegate = self;
    self.myImageView.image = self.image;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[ViewController class]]) {
        MagicMoveBackTransition *inverseTransition = [[MagicMoveBackTransition alloc]init];
        return inverseTransition;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if ([animationController isKindOfClass:[MagicMoveBackTransition class]]) {
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
