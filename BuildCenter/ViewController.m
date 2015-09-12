//
//  ViewController.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/10.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "ViewController.h"

#import "LeftTableViewProtocol.h"
#import "RightTableViewProtocol.h"
#import "DetailHeaderView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Product.h"

#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, strong) LeftTableViewProtocol  *leftProtocol;
@property (nonatomic, strong) RightTableViewProtocol *rightProtocol;

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSArray *historyBuilds;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *headerDownLoadButton;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.leftTableView.delegate    = self.leftProtocol;
  self.leftTableView.dataSource  = self.leftProtocol;
  self.rightTableView.delegate   = self.rightProtocol;
  self.rightTableView.dataSource = self.rightProtocol;
  
  self.leftTableView.tableFooterView = [UIView new];
  
  self.leftTableView.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
  self.leftTableView.layer.borderWidth = 1;
  
  self.rightTableView.layer.borderColor = [UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
  self.rightTableView.layer.borderWidth = 1;
  
  UIView *headerView = [[UIView alloc] init];
  headerView.frame = CGRectMake(0, 0, 300, 50);
  
  UILabel *headerLabel = [[UILabel alloc] init];
  headerLabel.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
  headerLabel.frame = CGRectMake(10, 10, 280, 30);
  headerLabel.layer.cornerRadius = 5;
  headerLabel.layer.masksToBounds = YES;
  headerLabel.text = @"产品列表";
  headerLabel.textAlignment = NSTextAlignmentCenter;
  [headerView addSubview:headerLabel];
  self.leftTableView.tableHeaderView = headerView;
  
  [self loadData];
  
  [self.headerDownLoadButton addTarget:self action:@selector(downLoadClick:) forControlEvents:UIControlEventTouchUpInside];
  


  
}


- (void)loadData
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  NSDictionary *params = @{@"uKey":@"0eb9d8944087d49316360624304e66d1",
                           @"page":@"1",
                           @"_api_key":@"33fb0e3ad622f13a130a056913a25fe1"};
  
  [manager POST:@"http://www.pgyer.com/apiv1/user/listMyPublished" parameters:params success:^ void(AFHTTPRequestOperation * operation, id result) {
    
    NSArray *dataArray = result[@"data"][@"list"];
    _products = [Product objectArrayWithKeyValuesArray:dataArray];
    self.leftProtocol.products = _products;
    [self.leftTableView reloadData];
    
    
  } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
    
  }];
}



- (void)loadRightDataWithIndex:(NSInteger)index
{
  Product *product  =_products[index];
  
  NSString *iconStr   = [NSString stringWithFormat:@"http://7kttjt.com1.z0.glb.clouddn.com/image/view/app_icons/%@",product.appIcon];

  [_headerIconImageView sd_setImageWithURL:[NSURL URLWithString:iconStr]
                        placeholderImage:[UIImage imageNamed:@"default-icon"]];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  
  NSDictionary *params = @{@"aKey":product.appKey,
                           @"page":@"1",
                           @"_api_key":@"33fb0e3ad622f13a130a056913a25fe1"};
  
  [manager POST:@"http://www.pgyer.com/apiv1/app/builds" parameters:params success:^ void(AFHTTPRequestOperation * operation, id result) {
    
    NSArray *dataArray = result[@"data"][@"list"];
    _historyBuilds = [Product objectArrayWithKeyValuesArray:dataArray];
    self.rightProtocol.historyBuilds = _historyBuilds;
    [self.rightTableView reloadData];
    
    
  } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
    
  }];
}


- (void)downLoadClick:(UIButton *)sender
{
  Product *product = _products[_index];
  NSString *path = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/%@",product.appKey];
  NSURL* nsUrl = [NSURL URLWithString:path];
  [[UIApplication sharedApplication] openURL:nsUrl];
  
}

- (void)leftViewClickAtIndex:(NSInteger)index
{
  [self loadRightDataWithIndex:index];
  _index = index;
}


#pragma mark -
#pragma mark - Properties

- (LeftTableViewProtocol *)leftProtocol
{
  if (!_leftProtocol) {
    _leftProtocol = [[LeftTableViewProtocol alloc] init];
    _leftProtocol.controller = self;
  }
  return _leftProtocol;
}

- (RightTableViewProtocol *)rightProtocol
{
  if (!_rightProtocol) {
    _rightProtocol = [[RightTableViewProtocol alloc] init];
  }
  return _rightProtocol;
}
@end
