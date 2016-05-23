//
//  KeyedArchiverManager.h
//  GitHubClient
//
//  Created by QC.L on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyedArchiverManager : NSObject

+ (BOOL)keyedArchiverPathWithUrl:(NSString *)url
                    withResponse:(id)response;
+ (id)keyedUnarchiverPahtWith:(NSString *)url;

@end
