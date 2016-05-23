//
//  QCRequest.h
//  GitHubClient
//
//  Created by QC.L on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCRequest : NSObject
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSDictionary *allHttpHeaderFields;
@end
