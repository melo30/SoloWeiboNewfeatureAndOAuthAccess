//
//  SoloAccountTool.m
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/24.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloAccountTool.h"
#import "SoloAccount.h"
#define SoloAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation SoloAccountTool

+ (void)saveAccount:(SoloAccount *)account
{
    //计算账号的过期时间
    //拿到当前时间
    NSDate *now = [NSDate date];
    account.expireTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:SoloAccountFile];
}

+ (SoloAccount *)account
{
    //取出账号
    SoloAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SoloAccountFile];
    
    //判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expireTime] == NSOrderedAscending) {//还没有过期
        return account;
    }else{//过期
    return nil;
    }
}
@end
