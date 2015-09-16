//
//  PDLeftTableViewProtocol.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PDViewController.h"
#import "PDProductViewModel.h"

@interface PDLeftTableViewProtocol : NSObject
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *products;


@property (nonatomic, strong) PDProductViewModel *viewModel;
@property (nonatomic, weak) PDViewController *controller;

@end
