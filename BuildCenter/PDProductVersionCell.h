//
//  PDProductVersionCell.h
//  BuildCenter
//
//  Created by Peng Tao on 15/9/11.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDProductVersionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
