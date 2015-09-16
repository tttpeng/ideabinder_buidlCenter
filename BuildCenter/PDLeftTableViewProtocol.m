//
//  PDLeftTableViewProtocol.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDLeftTableViewProtocol.h"

#import "PDProductListCell.h"
#import "Product.h"
#import "UIImageView+WebCache.h"

@implementation PDLeftTableViewProtocol


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.viewModel numberKindsOfProducts];
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
  
  PDProductListCell *cell = [PDProductListCell cellWithTableView:tableView];
  
  cell.nameLabel.text = [self.viewModel leftProductNameAtIndex:indexPath.row];
  
  [cell.iconImageView sd_setImageWithURL:[self.viewModel leftIconUrlAtIndex:indexPath.row]
                        placeholderImage:[UIImage imageNamed:@"default-icon"]];
  
  cell.versionLabel.text = [self.viewModel leftVersionStrAtIndex:indexPath.row];
  
  return cell;
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  [self.controller leftViewClickAtIndex:indexPath.row];
  
}

@end
