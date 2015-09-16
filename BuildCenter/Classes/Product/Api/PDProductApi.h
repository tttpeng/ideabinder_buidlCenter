//
//  PDApi.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/12.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDProductApi : NSObject

@property (nonatomic, strong) NSArray *products;

- (void)loadNewProducts:(void(^)())completion;
@end
