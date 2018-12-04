//
//  ZPANotificationManager.h
//  ZXGPhoneActive
//
//  Created by zxg on 2018/12/4.
//  Copyright © 2018 zxg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPANotificationManager : NSObject

+ (instancetype)sharedNotificationManager;
- (void)startNotification;
- (void)registerNotification:(NSInteger)alerTime;

@end

NS_ASSUME_NONNULL_END
