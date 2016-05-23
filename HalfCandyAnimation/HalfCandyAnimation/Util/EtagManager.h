//
//  EtagManager.h
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/9.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtagManager : NSObject

+ (void)setEtagCacheWithURL:(NSString *)url
                       etag:(NSString *)etag;

+ (NSString *)getEtagCacheWithUrl:(NSString *)url;

+ (void)removeAllEtagCache;

@end
