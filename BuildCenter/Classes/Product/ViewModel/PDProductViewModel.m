//
//  PDProductViewModel.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/15.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDProductViewModel.h"

#import "PDProductApi.h"

#import "Product.h"

@interface PDProductViewModel ()

@property (nonatomic, strong) PDProductApi *api;

@end

@implementation PDProductViewModel

- (void)reloadAllProducts:(void (^)())completion
{
  [self.api loadNewProducts:^{
    completion();
  }];
}

- (void)reloadHistoryBuildsWithIndex:(NSInteger)index completion:(void (^)())completion
{
  Product *procuct = self.api.products[index];
  NSString *appKey = procuct.appKey;
  [self.api loadHistoryVersionBulidsWithAppKey:appKey completion:^{
    completion();
  }];
}

- (NSInteger)numberKindsOfProducts
{
  return self.api.products.count;
}
- (NSURL *)leftIconUrlAtIndex:(NSInteger)index
{
  
  Product *product = self.api.products[index];
  NSString *iconStr   = [NSString stringWithFormat:
                         @"http://7kttjt.com1.z0.glb.clouddn.com/image/view/app_icons/%@",
                         product.appIcon];
  return [NSURL URLWithString:iconStr];
}


- (NSString *)leftProductNameAtIndex:(NSInteger)index
{
  Product *product = self.api.products[index];
  return product.appName;
}

- (NSString *)leftVersionStrAtIndex:(NSInteger)index
{
  Product *product = self.api.products[index];
  return product.appVersionNo;
}


#pragma mark -
#pragma mark - Right Table

- (NSInteger)numberOfVersionRows
{
  return self.api.historyBuilds.count;
}

- (NSString *)rightVersionAtIndex:(NSInteger)index
{
  Product *product = self.api.historyBuilds[index];
  return product.appVersionNo;
}



- (NSString *)headerProductName
{
  return self.api.theNewProduct.appName;
}
- (NSString *)headerVersion
{
  return self.api.theNewProduct.appVersionNo;
}
- (NSURL *)headerIconUrl
{
  NSString *iconStr   = [NSString stringWithFormat:
                          @"http://7kttjt.com1.z0.glb.clouddn.com/image/view/app_icons/%@",
                          self.api.theNewProduct.appIcon];
  return [NSURL URLWithString:iconStr];  
}


- (NSString *)downloadAppkey;
{
  return self.api.theNewProduct.appKey;
}

- (PDProductApi *)api
{
  if (!_api) {
    _api = [[PDProductApi alloc] init];
  }
  return _api;
}


@end
