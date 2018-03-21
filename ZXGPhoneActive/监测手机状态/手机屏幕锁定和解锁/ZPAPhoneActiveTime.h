//
//  ZPAPhoneActiveTime.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ScreenLockedBlock)(NSDictionary *infoDict);
typedef void (^ScreenUnLockedBlock)(NSDictionary *infoDict);

@interface ZPAPhoneActiveTime : NSObject

+ (instancetype)sharedPhoneActiveTime;

/**
 记录手机屏幕活跃时间

 @param lockedBlock 屏幕锁定时的回调
 @param unLockedBlock 屏幕解锁时的回调
 */
- (void)recordPhoneActiveTimeWithLockedBlock:(ScreenLockedBlock)lockedBlock AndScreenUnLockedBlock:(ScreenUnLockedBlock)unLockedBlock;

@end
