//
//  QCNetworkManager.h
//  GitHubClient
//
//  Created by QC.L on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QCRequest;

@protocol QCNetworkResult <NSObject>

@required
- (void)requestedSuccess:(id)responseObject;
- (void)requestedError:(NSError *)error;

@end

@interface QCNetworkManager : NSObject

+ (QCNetworkManager *)defaultManager;

@property (nonatomic, weak) id<QCNetworkResult>delegate;

- (void)getRequest:(QCRequest *)request;
- (void)postRequest:(QCRequest *)request;



@end
