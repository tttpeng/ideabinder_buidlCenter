//
//  PDProductVersionCell.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDProductVersionCell.h"

@implementation PDProductVersionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
  static NSString *identifier = @"PDProductVersionCell";
  PDProductVersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[PDProductVersionCell alloc] init];
    cell = [[NSBundle mainBundle] loadNibNamed:@"PDProductVersionCell" owner:nil options:nil][0];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
  }
  return cell;
}


@end
