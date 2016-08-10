//
//  PDProductServiceManager.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/15.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDProductServiceManager : NSObject


- (void)getAllProductListByPageNumber:(NSInteger)page completion:(void (^)(NSArray *products, NSInteger page))completion;

- (void)getHistoryVersionWithAppKey:(NSString *)appKey
                         completion:(void (^)(NSArray *historyBuilds))completion;

@end
