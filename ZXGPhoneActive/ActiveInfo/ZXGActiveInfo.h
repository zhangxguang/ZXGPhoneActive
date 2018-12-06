//
//  ZXGActiveInfo.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/12/6.
//  Copyright © 2018 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXGActiveInfo : NSObject

+ (instancetype)sharedActiveInfo;

/**
 活跃时间 NSDate
 */
@property (nonatomic, strong) NSDate *activeTime;

/**
 活跃时间的字符串 NSString
 */
@property (nonatomic, copy) NSString *activeTimeString;

/**
 当前的位置信息，可能不是当前的，也可能是最近一次的位置信息
 */
@property (nonatomic, strong) CLLocation *currentLocation;

/**
 当前位置信息的字符串
 */
@property (nonatomic, copy) NSString *currentLocationName;








@end

NS_ASSUME_NONNULL_END
