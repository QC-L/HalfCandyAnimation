//
//  QCHiveHomePage.h
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/05/18
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data,Sub;

@interface QCHiveHomePage : NSObject

@property (nonatomic, assign) BOOL result;

@property (nonatomic, strong) NSArray<Data *> *data;

@property (nonatomic, assign) NSInteger code;

@end