//
//  ZPAScreenLockState.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "ZPAScreenLockState.h"

#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")
#define NotificationChange CFSTR("com.apple.springboard.lockstate")
#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")

BOOL IscreenLockedByAMPScreenLockState;

/**
 监听系统锁屏

 @param center 通知中心
 @param observer 观察者
 */
static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo);

@implementation ZPAScreenLockState

/**
 监听系统锁屏
 */
+ (void)monitorScreenLockState
{
    //监听系统锁屏
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationChange, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

@end

/**
 监听系统锁屏

 @param center 通知中心
 @param observer 观察者
 */
static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)
{
    NSString* lockstate = (__bridge NSString*)name;

    if ([lockstate isEqualToString:(__bridge  NSString*)NotificationLock]) {

        // 此处监听的系统锁屏
        IscreenLockedByAMPScreenLockState = YES;
    }else {

        // 此处监听到屏幕解锁事件（锁屏也会调用此处一次，锁屏事件要在上面实现）
        if (IscreenLockedByAMPScreenLockState == YES) {

            //锁屏
            IscreenLockedByAMPScreenLockState = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPAScreenLockState_Locked" object:nil];
        }else{

            //解锁屏幕
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZPAScreenLockState_UnLocked" object:nil];
        }
    }
}
