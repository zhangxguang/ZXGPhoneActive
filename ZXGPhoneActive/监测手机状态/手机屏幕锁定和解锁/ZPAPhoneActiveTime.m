//
//  ZPAPhoneActiveTime.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "ZPAPhoneActiveTime.h"
#import "ZPAScreenLockState.h"

@implementation ZPAPhoneActiveTime

#pragma mark - 单例
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static ZPAPhoneActiveTime *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });

    return instance;
}

+ (instancetype)sharedPhoneActiveTime
{
    static ZPAPhoneActiveTime *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZPAPhoneActiveTime new];
    });

    return instance;
}

#pragma mark -
- (void)recordPhoneActiveTime
{
    //监听系统锁屏
    [ZPAScreenLockState monitorScreenLockState];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenLocked:)
                                                 name:@"ZPAScreenLockState_Locked"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenUnLocked:)
                                                 name:@"ZPAScreenLockState_UnLocked"
                                               object:nil];
}

//屏幕锁定
- (void)screenLocked:(NSNotification *)notification
{
    NSLog(@"屏幕锁定");

}

//屏幕解锁
- (void)screenUnLocked:(NSNotification *)notification
{
    NSLog(@"屏幕解锁");

}

@end
