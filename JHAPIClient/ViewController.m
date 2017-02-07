//
//  ViewController.m
//  JHAPIClient
//
//  Created by Shenjinghao on 2017/2/6.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "ViewController.h"
#import "JHAPIClient.h"
#import "AppAPIClient.h"
#import <AFHTTPRequestOperationManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //demo
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 220, self.view.bounds.size.width - 30, 45);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonDidClicked:(id)sender
{

    //错误  The data couldn’t be read because it isn’t in the correct format.
    
    //第一层封装
//    JHAPIClient *request = [[JHAPIClient alloc] initWithBaseUrl:[NSURL URLWithString:@"https://www.baidu.com"]];
//    [request getPath:@"https://www.baidu.com" parameters:nil requestContentType:kJHHttpRequestContentTypeJSON success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求成功%@",responseObject);
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.view.bounds.size.width - 30, 145)];
//        label.text = [responseObject JSONRepresentation];
//        [self.view addSubview:label];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSString *errorInfo = [error localizedDescription];
//        NSLog(@"请求失败%@",error);
//    }];
    
    //第二层
//    https  ||  http    例子http://blog.csdn.net/lqq200912408/article/details/50520631
//    The resource could not be loaded because the App Transport Security policy requires the use of a secure connection.
    [[AppAPIClient shareInstance] getPath:@"http://zuimeia.com/api/category/100/all/?type=zuimei.daily&appVersion=2.3.0&openUDID=2DEBF952-F7E9-4135-BB78-781F5567E8D5&page=1&page_size=20&platform=1&resolution=%7B640%2C%201136%7D&systemVersion=10.2.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.view.bounds.size.width - 30, 145)];
        
        label.text = [responseObject[@"result"] stringValue];
        [self.view addSubview:label];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
    
    //测试成功
//    [self test2];
}

#pragma mark 成功
- (void)test2
{
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //这里进行设置；
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *str = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<root>"
    "<command_type>***</command_type>"
    "<id>***</id>"
    "<action>***</action>"
    "<value>***</value>"
    "</root>";
    
    NSDictionary *parameters = @{@"test" : str};
    
    [manager POST:@"https://www.baidu.com"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject){
              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              NSLog(@"成功: %@", string);
          }
          failure:^(AFHTTPRequestOperation *operation,NSError *error){
              NSLog(@"失败: %@", error);
          }];
}

//
// 返回 JSON形式的字符串
//
- (NSString *)JSONRepresentation {
    
    NSData* data = [NSJSONSerialization dataWithJSONObject: self options: 0 error: nil];
    NSString* result = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
