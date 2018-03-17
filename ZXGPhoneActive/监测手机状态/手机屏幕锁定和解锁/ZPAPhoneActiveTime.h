//
//  ZPAPhoneActiveTime.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/17.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPAPhoneActiveTime : NSObject

+ (instancetype)sharedPhoneActiveTime;

/**
 记录手机屏幕活跃时间
 */
- (void)recordPhoneActiveTime;

@end
