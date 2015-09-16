//
//  PDProductViewModel.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/15.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDProductViewModel : NSObject

- (void)reloadAllProducts:(void(^)())completion;



- (NSInteger)numberKindsOfProducts;
- (NSString *)leftProductNameAtIndex:(NSInteger)index;
- (NSURL *)leftIconUrlAtIndex:(NSInteger)index;
- (NSString *)leftVersionStrAtIndex:(NSInteger)index;

@end
