//
//  SoloAccount.m
//  solocaresWeiBo
//
//  Created by 陈诚 on 15/12/21.
//  Copyright © 2015年 solocares. All rights reserved.
//

#import "SoloAccount.h"

@implementation SoloAccount

//构造方法，首先得调用super的init方法
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];//kvc
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/** 解档
 *  从文件中解析对象的时候调(从文件里面解析哪些属性给我们的模型)
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    //是一个构造方法，所以首先要调super的init方法
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expireTime = [decoder decodeObjectForKey:@"expireTime"];

    }
    return self;
}
/**归档
 *  将对象写入文件的时候调用(我们模型的哪些属性要存到文件里面去)
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expireTime forKey:@"expireTime"];
}
@end
