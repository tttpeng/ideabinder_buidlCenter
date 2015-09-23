//
//  PDApi.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/12.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDProductApi.h"

#import "PDProductServiceManager.h"
@interface PDProductApi ()

@property (nonatomic, strong) PDProductServiceManager *serviceManager;

@end

@implementation PDProductApi

- (void)loadNewProducts:(void(^)())completion
{
  [self.serviceManager getAllProductList:^(NSArray *products) {
    _products = products;
    completion();
  }];
}

- (void)loadHistoryVersionBulidsWithAppKey:(NSString *)appkey completion:(void(^)())completion
{
  [self.serviceManager getHistoryVersionWithAppKey:appkey completion:^(NSArray *historyBuilds) {
    self.theNewProduct =  historyBuilds[0];

    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:historyBuilds];
    [tempArray removeObjectAtIndex:0];
    _historyBuilds = tempArray;
    _theNewProduct = historyBuilds[0];
    completion();
  }];
}

- (PDProductServiceManager *)serviceManager
{
  if (!_serviceManager) {
    _serviceManager = [[PDProductServiceManager  alloc] init];
  }
  return _serviceManager;
}


@end
