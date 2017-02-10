# module_JHAPIClient
模块化的网咯组件，依赖AFN

此模块组件主要对AFHTTPRequestOperationManager进行封装,如对session进行封装，请关注JHNetwork

#使用方法

``` objc
[[AppAPIClient shareInstance] getPath:@"http://zuimeia.com/api/category/100/all/?type=zuimei.daily&appVersion=2.3.0&openUDID=2DEBF952-F7E9-4135-BB78-781F5567E8D5&page=1&page_size=20&platform=1&resolution=%7B640%2C%201136%7D&systemVersion=10.2.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
NSLog(@"请求成功%@",responseObject);
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.view.bounds.size.width - 30, 145)];

label.text = [responseObject[@"result"] stringValue];
[self.view addSubview:label];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
NSLog(@"请求失败%@",error);
}];
```
