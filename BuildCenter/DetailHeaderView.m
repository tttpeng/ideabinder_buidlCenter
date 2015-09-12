//
//  DetailHeaderView.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

+ (DetailHeaderView *)initCustomView
{
  DetailHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"DetailHeaderView" owner:self options:nil] firstObject];
  NSLog(@"-0----->%@",NSStringFromCGRect(view.frame));
  return view;
}
@end
