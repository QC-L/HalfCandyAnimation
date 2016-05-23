//
//  MagicMoveBackTransition.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/20.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "MagicMoveBackTransition.h"
#import "SecondViewController.h"
#import "ViewController.h"
#import "HiveTableViewCell.h"

@implementation MagicMoveBackTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    SecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    HiveTableViewCell *cell = [toVC.halfSurgeTableView cellForRowAtIndexPath:[[toVC.halfSurgeTableView indexPathsForSelectedRows] firstObject]];
    
    UIView *snapShotView = [fromVC.myImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:fromVC.myImageView.frame toView:fromVC.view];
    
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    cell.myImageView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    
    //发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.myImageView.hidden = NO;
        cell.myImageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}

@end
