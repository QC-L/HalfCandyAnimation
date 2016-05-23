//
//  KeyedArchiverManager.m
//  GitHubClient
//
//  Created by QC.L on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "KeyedArchiverManager.h"
#import "NSString+MD5.h"

#define kDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

const NSString *keyedArchiver = @"/keyedCache";

@implementation KeyedArchiverManager

+ (NSString *)getKeyedArchiverPathWith:(NSString *)url {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kDocumentDirectory, keyedArchiver];
    [[NSFileManager defaultManager] createDirectoryAtPath:urlString withIntermediateDirectories:NO attributes:nil error:nil];
    urlString = [urlString stringByAppendingPathComponent:[url stringWithMD5]];
    
    return urlString;
}

+ (BOOL)keyedArchiverPathWithUrl:(NSString *)url
                             withResponse:(id)response {
    return [NSKeyedArchiver archiveRootObject:response toFile:[self getKeyedArchiverPathWith:url]];
}

+ (id)keyedUnarchiverPahtWith:(NSString *)url {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getKeyedArchiverPathWith:url]];
}

@end
