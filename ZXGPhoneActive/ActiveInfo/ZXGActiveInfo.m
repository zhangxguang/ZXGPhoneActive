//
//  ZXGActiveInfo.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/12/6.
//  Copyright © 2018 zxg. All rights reserved.
//

#import "ZXGActiveInfo.h"

@interface ZXGActiveInfo ()



@end

@implementation ZXGActiveInfo

#pragma mark - 单例
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static ZXGActiveInfo *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+ (instancetype)sharedActiveInfo
{
    static ZXGActiveInfo *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZXGActiveInfo new];
    });
    
    return instance;
}

#pragma mark -




@end
