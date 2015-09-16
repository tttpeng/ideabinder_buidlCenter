//
//  Product.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject



@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appFileSize;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) NSString *appVersionNo;
@property (nonatomic, strong) NSString *appBuildVersion;
@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *appIcon;
@property (nonatomic, strong) NSString *appDescription;
@property (nonatomic, strong) NSString *appUpdateDescription;
@property (nonatomic, strong) NSString *appScreenshots;
@property (nonatomic, strong) NSString *appCreated;



@end
