//
//  LeftTableViewProtocol.m
//  Build推送
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "LeftTableViewProtocol.h"

#import "ProductListCell.h"
#import "Product.h"
#import "UIImageView+WebCache.h"

@implementation LeftTableViewProtocol


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _products.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  ProductListCell *cell = [ProductListCell cellWithTableView:tableView];
  
  Product *product    = _products[indexPath.row];
  cell.nameLabel.text = product.appName;
  
  NSString *iconStr   = [NSString stringWithFormat:@"http://7kttjt.com1.z0.glb.clouddn.com/image/view/app_icons/%@",product.appIcon];
  
  [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconStr]
                        placeholderImage:[UIImage imageNamed:@"default-icon"]];
  

  cell.versionLabel.text = product.appVersion;
  
  return cell;
  
}

@end
