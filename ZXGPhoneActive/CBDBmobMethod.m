//
//  CBDBmobMethod.m
//  CBDBigImage
//
//  Created by zxg on 2018/9/21.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "CBDBmobMethod.h"


@interface CBDBmobMethod ()
@property (nonatomic, copy) CBDBmobMethodResultBlock resultBlock;
@end

@implementation CBDBmobMethod

#pragma mark - Bmob
- (void)addBmobData:(NSDictionary *)dataDict
{
    NSString *timeString = dataDict[@"time"];
    
    BmobObject *gameScore = [BmobObject objectWithClassName:@"activeTime"];
    [gameScore setObject:timeString forKey:@"time"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        NSLog(@"添加成功");
    }];
}

- (void)getBmobData
{
    //查找表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"wlp"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error){
            //进行错误处理
            NSLog(@"查 询失 败 * * * %@", error);
            NSDictionary *dict = [[NSDictionary alloc] init];
            self.resultBlock(dict);
            
        }else{
            
            NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
            for (BmobObject *object in array) {
                if (object) {
                    NSString *playerName = [object objectForKey:@"wlpinfo"];
                    [userDict setObject:playerName forKey:@"wlpinfo"];
                    
                    NSString *imageName = [object objectForKey:@"wlpImageInfo"];
                    [userDict setObject:imageName forKey:@"wlpImageInfo"];
                }
            }

            self.resultBlock([userDict copy]);
        }
        
    }];
}


@end

