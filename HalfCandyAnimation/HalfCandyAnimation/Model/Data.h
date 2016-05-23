//
//  Data.h
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/05/18
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sub;

@interface Data : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL more;

@property (nonatomic, strong) NSArray<Sub *> *sub;

@end