//
//  PDRightTableViewProtocol.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDRightTableViewProtocol.h"
#import "PDProductVersionCell.h"
#import "Product.h"

@implementation PDRightTableViewProtocol


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.viewModel numberOfVersionRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  PDProductVersionCell *cell = [PDProductVersionCell cellWithTableView:tableView];
  
  cell.versionLabel.text = [self.viewModel rightVersionAtIndex:indexPath.row];
  [cell. downloadButton addTarget:self action:@selector(downloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  
  cell.downloadButton.tag = indexPath.row;
  return cell;
  
}


- (void)downloadButtonClick:(UIButton *)button
{
  [[UIApplication sharedApplication] openURL:[self.viewModel rightDownloadUrlAtIndex:button.tag]];
}


@end
