//
//  AppAPIClient.m
//  JHAPIClient
//
//  Created by Shenjinghao on 2017/2/7.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "AppAPIClient.h"

@implementation AppAPIClient

+ (instancetype)shareInstance
{
    static AppAPIClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[AppAPIClient alloc] initWithBaseUrl:nil];
    });
    return client;
    
}

@end
