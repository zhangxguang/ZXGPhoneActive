//
//  ZPAScreenLockState.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPAScreenLockState : NSObject

/**
 监听系统锁屏
 */
+ (void)monitorScreenLockState;

@end
