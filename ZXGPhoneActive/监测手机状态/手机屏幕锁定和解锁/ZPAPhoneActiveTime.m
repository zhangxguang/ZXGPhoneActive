//
//  ZPAPhoneActiveTime.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "ZPAPhoneActiveTime.h"
#import "ZPAScreenLockState.h"

@interface ZPAPhoneActiveTime ()

+ (instancetype)sharedPhoneActiveTime;

/**
 记录手机屏幕活跃时间
 */
- (void)recordPhoneActiveTime;

@property (nonatomic, copy) ZPAScreenLockedBlock lockedBlock;//屏幕锁定时的回调
@property (nonatomic, copy) ZPAScreenUnLockedBlock unLockedBlock;//屏幕解锁时的回调

@end


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

- (void)recordPhoneActiveTimeWithLockedBlock:(ZPAScreenLockedBlock)lockedBlock AndScreenUnLockedBlock:(ZPAScreenUnLockedBlock)unLockedBlock
{
    self.lockedBlock = lockedBlock;
    self.unLockedBlock = unLockedBlock;

    [self recordPhoneActiveTime];
}

//屏幕锁定
- (void)screenLocked:(NSNotification *)notification
{
    NSDictionary *infoDict = [[NSDictionary alloc] init];
    if (self.lockedBlock != nil) {
        self.lockedBlock(infoDict);
    }
}

//屏幕解锁
- (void)screenUnLocked:(NSNotification *)notification
{
    NSDictionary *infoDict = [[NSDictionary alloc] init];
    if (self.unLockedBlock != nil) {
        self.unLockedBlock(infoDict);
    }
}

@end
