//
//  ZPAPhoneActiveTime.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZPAScreenLockedBlock)(NSDictionary *infoDict);
typedef void (^ZPAScreenUnLockedBlock)(NSDictionary *infoDict);

@interface ZPAPhoneActiveTime : NSObject

+ (instancetype)sharedPhoneActiveTime;

/**
 记录手机屏幕活跃时间

 @param lockedBlock 屏幕锁定时的回调
 @param unLockedBlock 屏幕解锁时的回调
 */
- (void)recordPhoneActiveTimeWithLockedBlock:(ZPAScreenLockedBlock)lockedBlock AndScreenUnLockedBlock:(ZPAScreenUnLockedBlock)unLockedBlock;

@end
