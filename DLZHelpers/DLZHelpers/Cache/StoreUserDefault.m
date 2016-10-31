//
//  StoreUserDefault.m
//  DLZHelpers
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "StoreUserDefault.h"

@implementation StoreUserDefault

static StoreUserDefault *_instance = nil;

+(StoreUserDefault*)instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[StoreUserDefault alloc] init];
    });
    return _instance;
}
/*
 *-----------------存储对象数组------------------------*
 *-----------------基数序列为key，偶数序列为value------------------------*
 */
-(BOOL)saveData:(NSArray *)keyAndData{
    BOOL state = YES;
    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        for (int i=0; i<keyAndData.count; i=i+2) {
            [userDefaults setObject:[keyAndData objectAtIndex:i+1] forKey:[keyAndData objectAtIndex:i]];
        }
        [userDefaults synchronize];
    }
    @catch (NSException *exception) {
        state=NO;
        DDLogError(@"%@",exception);
    }
    @finally {
        
    }
    return state;
}
-(NSData*)getDataWithNSData:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dataForKey:key];
}
-(NSString *)getDataWithString:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}
-(NSArray *)getDataWithArray:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults arrayForKey:key];
}
-(NSDictionary *)getDataWithDictionary:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:key];
}

-(void)setData:(NSString *)key data:(id)data{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:key];
}

@end
