//
//  Data.m
//  HalfSurgeAnimation
//
//  Created by QC.L on 16/05/18
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "Data.h"
#import "Sub.h"

@implementation Data

+ (NSDictionary *)objectClassInArray{
    return @{@"sub" : [Sub class]};
}

@end
