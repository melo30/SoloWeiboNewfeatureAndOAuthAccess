//
//  SoloAccountTool.h
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/24.
//  Copyright © 2015年 solocares. All rights reserved.

//账号管理工具类。与账号有关的东西都放在这里

#import <Foundation/Foundation.h>
@class SoloAccount;

@interface SoloAccountTool : NSObject

/**
 *  存储账号信息,相当于set方法
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(SoloAccount *)account;

/**
 *  返回存储的账号信息，相当于get方法
 *
 *  @return 需要获取的账号
 */
+ (SoloAccount *)account;

@end
