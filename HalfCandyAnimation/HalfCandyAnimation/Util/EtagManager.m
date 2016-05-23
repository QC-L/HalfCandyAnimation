//
//  EtagManager.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/9.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "EtagManager.h"
#import "NSString+MD5.h"

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

static NSString * const kEtagKey = @"kEtagKey";

@implementation EtagManager


+ (NSString *)getEtagCachePath {
    return [NSString stringWithFormat:@"%@/%@.plist", kCacheDirectory, kEtagKey];
}

+ (void)setEtagCacheWithURL:(NSString *)url
                       etag:(NSString *)etag {
    NSMutableDictionary *dic = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self getEtagCachePath]] mutableCopy];
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    NSString *md5String = [url stringWithMD5];
    dic[md5String] = etag;
    
    [NSKeyedArchiver archiveRootObject:dic toFile:[self getEtagCachePath]];
}

+ (NSString *)getEtagCacheWithUrl:(NSString *)url {
    NSDictionary *etagDic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getEtagCachePath]];
    return etagDic[[url stringWithMD5]];
}


+ (void)removeAllEtagCache {
    [[NSFileManager defaultManager] removeItemAtPath:[self getEtagCachePath] error:nil];
}

@end
