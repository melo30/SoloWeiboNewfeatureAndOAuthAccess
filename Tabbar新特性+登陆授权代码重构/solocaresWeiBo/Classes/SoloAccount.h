//
//  SoloAccount.h
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/21.
//  Copyright © 2015年 solocares. All rights reserved.
//  账号信息

#import <Foundation/Foundation.h>

@interface SoloAccount : NSObject<NSCoding>

@property (nonatomic, copy)NSString *access_token;
@property (nonatomic, strong)NSDate *expireTime;//账号当时的保存时间
// 服务器返回数字很大，用long long(比如主键，ID)
@property (nonatomic, assign)long long expires_in;
@property (nonatomic, assign)long long remind_in;
@property (nonatomic, assign)long long uid;

//再搞一个字典转模型的方法,封装起来
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
