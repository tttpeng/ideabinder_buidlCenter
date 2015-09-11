//
//  ProductVersionCell.m
//  Build推送
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "ProductVersionCell.h"

@implementation ProductVersionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
  static NSString *identifier = @"ProductVersionCell";
  ProductVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[ProductVersionCell alloc] init];
    cell = [[NSBundle mainBundle] loadNibNamed:@"ProductVersionCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
  }
  return cell;
}


@end
