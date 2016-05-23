//
//  SecondViewController.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "SecondViewController.h"
#import "QCNetworking.h"
#import "MagicMoveBackTransition.h"
#import "ViewController.h"
#import "Sub.h"

@interface SecondViewController () <UINavigationControllerDelegate, QCNetworkResult>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.delegate = self;
    self.myImageView.image = self.image;
    [self handleRequest];
}

- (void)handleRequest {
    QCRequest *request = [[QCRequest alloc] init];
    request.urlString = [NSString stringWithFormat:@"http://v23appapi.hivetrips.com/info/showv2?infoId=%ld", _sub.infoId];
    
    
    QCNetworkManager *manager = [QCNetworkManager defaultManager];
    manager.delegate = self;
    [manager getRequest:request];
}

- (void)requestedError:(NSError *)error {
    
}

- (void)requestedSuccess:(id)responseObject {
    NSLog(@"%@", responseObject);
    self.myTextView.text = responseObject[@"data"][@"projectContent"];
    self.textViewHeightConstraint.constant = [UIScreen mainScreen].bounds.size.height - 180;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.backButton.hidden = NO;
        
    }];
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
    } else {
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
