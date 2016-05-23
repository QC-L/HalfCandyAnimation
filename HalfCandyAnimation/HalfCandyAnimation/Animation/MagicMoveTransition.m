//
//  MagicMoveTransition.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/20.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "HiveTableViewCell.h"

@implementation MagicMoveTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    
    HiveTableViewCell *cell = [fromVC.halfSurgeTableView cellForRowAtIndexPath:fromVC.halfSurgeTableView.indexPathForSelectedRow];
    
    
    UIView *snapView = [cell.myImageView snapshotViewAfterScreenUpdates:NO];
    
    // 把某视图坐标系下的点或者矩形 变成 另一个视图坐标系上的点或矩形 convertRect
    snapView.frame = [cell convertRect:cell.myImageView.frame toView:fromVC.view];
    
    fromVC.finalCellRect = snapView.frame;
    cell.myImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.myImageView.hidden = YES;
    
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapView.frame = [containerView convertRect:toVC.myImageView.frame toView:toVC.view];
    } completion:^(BOOL finished) {
        toVC.myImageView.hidden = NO;
        cell.myImageView.hidden = NO;
        [snapView removeFromSuperview];
        // 告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

    
}

@end
