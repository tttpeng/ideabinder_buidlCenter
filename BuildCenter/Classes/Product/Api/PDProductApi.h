//
//  PDApi.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/12.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@interface PDProductApi : NSObject

@property (nonatomic, strong) NSMutableArray *mutableProducts;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSArray *historyBuilds;
@property (nonatomic, strong) Product *theNewProduct;

- (void)loadNewProducts:(void(^)())completion;
- (void)loadHistoryVersionBulidsWithAppKey:(NSString *)appkey completion:(void(^)())completion;

@end
