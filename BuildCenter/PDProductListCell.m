//
//  ProductListCell.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDProductListCell.h"

@implementation PDProductListCell



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
  static NSString *identifier = @"PDProductListCell";
  PDProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[PDProductListCell alloc] init];
    cell = [[NSBundle mainBundle] loadNibNamed:@"PDProductListCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
  }
  return cell;
}


- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
