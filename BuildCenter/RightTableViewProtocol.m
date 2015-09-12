//
//  RightTableViewProtocol.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "RightTableViewProtocol.h"
#import "ProductVersionCell.h"
#import "Product.h"

@implementation RightTableViewProtocol


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _historyBuilds.count - 1;
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
  
  ProductVersionCell *cell = [ProductVersionCell cellWithTableView:tableView];
  
  Product *product = _historyBuilds[indexPath.row + 1];
  cell.versionLabel.text = product.appVersionNo;
  return cell;
  
}



@end
