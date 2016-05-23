//
//  QCNetworkManager.m
//  GitHubClient
//
//  Created by QC.L on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "QCNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "QCRequest.h"
#import "KeyedArchiverManager.h"
#import "EtagManager.h"

@interface QCNetworkManager ()

@end

@implementation QCNetworkManager

+ (QCNetworkManager *)defaultManager {
    static QCNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QCNetworkManager alloc] init];
    });
    return manager;
}

- (void)getRequest:(QCRequest *)request {
    
    AFHTTPSessionManager *manager = [self getManager];
    
    if ([[AFNetworkReachabilityManager manager] isReachable]) {
        id result = [KeyedArchiverManager keyedUnarchiverPahtWith:request.urlString];
        if (result) {
            [self.delegate requestedSuccess:result];
        } else {
            [self.delegate requestedError:[NSError errorWithDomain:@"is no cache" code:400 userInfo:nil]];
        }
        return;
    }
    
    for (id key in request.allHttpHeaderFields.allKeys) {
        [manager.requestSerializer setValue:request.allHttpHeaderFields[key] forHTTPHeaderField:key];
    }
    
    NSString *etag = [EtagManager getEtagCacheWithUrl:request.urlString];
    if (etag.length > 0) {
        [manager.requestSerializer setValue:etag forHTTPHeaderField:@"If-None-Match"];
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    }
    
    [manager GET:request.urlString parameters:request.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        
        if (response.statusCode == 304) {
            id result = [KeyedArchiverManager keyedUnarchiverPahtWith:request.urlString];
            if (result) {
                [self.delegate requestedSuccess:result];
            } else {
                [self.delegate requestedError:[NSError errorWithDomain:@"error" code:400 userInfo:nil]];
            }
            return;
        }
        // 设置Etag
        NSString *eTag = response.allHeaderFields[@"Etag"];

        [EtagManager setEtagCacheWithURL:request.urlString etag:eTag];
        [KeyedArchiverManager keyedArchiverPathWithUrl:request.urlString withResponse:responseObject];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestedSuccess:)] && responseObject) {
            [self.delegate requestedSuccess:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestedError:)]) {
            [self.delegate requestedError:error];
        }
    }];
}

- (void)postRequest:(QCRequest *)request {
    AFHTTPSessionManager *manager = [self getManager];
    
    if ([[AFNetworkReachabilityManager manager] isReachable]) {
        id result = [KeyedArchiverManager keyedUnarchiverPahtWith:request.urlString];
        if (result) {
            [self.delegate requestedSuccess:result];
        } else {
            [self.delegate requestedError:[NSError errorWithDomain:@"is no cache" code:400 userInfo:nil]];
        }
        return;
    }
    
    for (id key in request.allHttpHeaderFields.allKeys) {
        [manager.requestSerializer setValue:request.allHttpHeaderFields[key] forHTTPHeaderField:key];
    }
    
    NSString *etag = [EtagManager getEtagCacheWithUrl:request.urlString];
    if (etag.length > 0) {
        [manager.requestSerializer setValue:etag forHTTPHeaderField:@"If-None-Match"];
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    }
    
    [manager POST:request.urlString parameters:request.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        
        if (response.statusCode == 304) {
            id result = [KeyedArchiverManager  keyedUnarchiverPahtWith:request.urlString];
            if (result) {
                [self.delegate requestedSuccess:result];
            } else {
                [self.delegate requestedError:[NSError errorWithDomain:@"error" code:400 userInfo:nil]];
            }
            return;
        }
        
        // 设置Etag
        NSString *eTag = response.allHeaderFields[@"Etag"];
        
        [EtagManager setEtagCacheWithURL:request.urlString etag:eTag];
        [KeyedArchiverManager keyedArchiverPathWithUrl:request.urlString withResponse:responseObject];
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestedSuccess:)] && responseObject) {
            [self.delegate requestedSuccess:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestedError:)]) {
            [self.delegate requestedError:error];
        }
        
    }];
    
}

- (AFHTTPSessionManager *)getManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 让网络请求管理类支持304
    NSMutableIndexSet *set = [manager.responseSerializer.acceptableStatusCodes mutableCopy];
    [set addIndex:304];
    manager.responseSerializer.acceptableStatusCodes = set;
    return manager;
}

@end
