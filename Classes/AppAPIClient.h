//
//  AppAPIClient.h
//  JHAPIClient
//
//  Created by Shenjinghao on 2017/2/7.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "JHAPIClient.h"

/**
 最外层再封装一层，可以处理crash后的error info，处理各种定制业务
 */
@interface AppAPIClient : JHAPIClient

+ (instancetype) shareInstance;


@end
