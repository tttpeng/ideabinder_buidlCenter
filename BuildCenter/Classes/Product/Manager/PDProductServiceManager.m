//
//  PDProductServiceManager.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/15.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDProductServiceManager.h"

#import "AFNetworking.h"
#import "Product.h"
#import "MJExtension.h"

@implementation PDProductServiceManager


- (void)getAllProductList:(void (^)(NSArray *))completion
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  NSDictionary *params = @{@"uKey":kUserKey,
                           @"page":@"1",
                           @"_api_key":kApiKey};
  
  [manager POST:@"http://www.pgyer.com/apiv1/user/listMyPublished" parameters:params success:^ void(AFHTTPRequestOperation * operation, id result) {
    
    NSArray *dataArray = result[@"data"][@"list"];
    NSArray *products = [Product objectArrayWithKeyValuesArray:dataArray];
    
    completion(products);
    
  } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
    
    completion(nil);
  }];
}

- (void)getHistoryVersionWithAppKey:(NSString *)appKey completion:(void (^)(NSArray *))completion
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

  NSDictionary *params = @{@"aKey":appKey,
                           @"page":@"1",
                           @"_api_key":kApiKey};
  
  [manager POST:@"http://www.pgyer.com/apiv1/app/builds" parameters:params success:^ void(AFHTTPRequestOperation * operation, id result) {
    
    NSArray *dataArray = result[@"data"][@"list"];
    NSArray *historyBuilds = [Product objectArrayWithKeyValuesArray:dataArray];
    completion(historyBuilds);
    
  } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
    completion(nil);
    
  }];
}

@end

