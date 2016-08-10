;//
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
  _mutableProducts = [NSMutableArray array];
  [self loadProductsByPageNumber:0 completion:completion];
}

- (void)loadProductsByPageNumber:(NSInteger)pageNumber completion:(void(^)())completion
{
  [self.serviceManager getAllProductListByPageNumber:pageNumber
                                          completion:
   ^(NSArray *products, NSInteger page) {
     if (products.count > 0) {
       [_mutableProducts addObjectsFromArray:products];
       [self loadProductsByPageNumber:page + 1 completion:completion];
     }
     else {
       _products = _mutableProducts;
       completion();
     }
    
  }];
}


- (void)loadHistoryVersionBulidsWithAppKey:(NSString *)appkey completion:(void(^)())completion
{
  [self.serviceManager getHistoryVersionWithAppKey:appkey completion:^(NSArray *historyBuilds) {
    if (historyBuilds.count > 0) {
      self.theNewProduct =  historyBuilds[0];
    }
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:historyBuilds];
    if (tempArray.count > 0) {
      [tempArray removeObjectAtIndex:0];
      _historyBuilds = tempArray;
    }
    if (historyBuilds.count > 0) {
      _theNewProduct = historyBuilds[0];
    }
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
