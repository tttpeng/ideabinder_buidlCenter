//
//  PDProductServiceManager.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/15.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDProductServiceManager : NSObject


- (void)getAllProductList:(void (^)(NSArray *products))completion;

@end
