//
//  ViewController.m
//  BuildCenter
//
//  Created by Peng Tao on 15/9/10.
//  Copyright (c) 2015年 Peng Tao. All rights reserved.
//

#import "PDViewController.h"

#import "PDLeftTableViewProtocol.h"
#import "PDRightTableViewProtocol.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Product.h"

#import "UIImageView+WebCache.h"

#import "PDProductViewModel.h"

#import "MJRefresh.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@interface PDViewController ()
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *headerDownLoadButton;
@property (weak, nonatomic) IBOutlet UILabel *headerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerVersionLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendBuild;

@property (weak, nonatomic) IBOutlet UILabel *headerDateLabel;

@property (nonatomic, strong) PDLeftTableViewProtocol  *leftProtocol;
@property (nonatomic, strong) PDRightTableViewProtocol *rightProtocol;

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSArray *historyBuilds;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) PDProductViewModel *viewModel;

@property (nonatomic, copy) NSString *downloadAppKey;

@property (nonatomic, strong) SVProgressHUD *hub;


@end

@implementation PDViewController

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
  
//  [self loadData];
  
  [self.headerDownLoadButton addTarget:self action:@selector(downLoadClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.sendBuild addTarget:self action:@selector(sendBuildClick:) forControlEvents:UIControlEventTouchUpInside];
  
  self.leftTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.leftTableView.header beginRefreshing];
}

- (void)loadData
{
  [self.viewModel reloadAllProducts:^{
    [self.leftTableView reloadData];
    [self.leftTableView.header endRefreshing];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftTableView selectRowAtIndexPath:indexPath
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    
    [self leftViewClickAtIndex:0];
  }];
}


- (void)refreshHeaderView
{
  if ([[self.viewModel headerAppIdentifier] isEqualToString:@"com.ideabinder.salesMOUD.WorkingCenterRep"] || [[self.viewModel headerProductName] isEqualToString:@"iDA DM"]) {
    self.sendBuild.hidden = NO;
  }
  else {
    self.sendBuild.hidden = YES;
  }
  self.headerIconImageView.layer.cornerRadius  = 30;
  self.headerIconImageView.layer.masksToBounds = YES;

  [self.headerIconImageView sd_setImageWithURL:[self.viewModel headerIconUrl]
                              placeholderImage:[UIImage imageNamed:@"default-icon"]];
  
  self.headerNameLabel.text    = [self.viewModel headerProductName];
  self.headerVersionLabel.text = [self.viewModel headerVersion];
  self.headerDateLabel.text    = [self.viewModel headerDataString];
  
  self.downloadAppKey = [self.viewModel downloadAppkey];
}

- (void)downLoadClick:(UIButton *)sender
{
  NSString *path = [NSString stringWithFormat:@"%@%@",kDownloadDefaultURL,self.downloadAppKey];
  NSURL* nsUrl = [NSURL URLWithString:path];
  [[UIApplication sharedApplication] openURL:nsUrl];
}

- (void)sendBuildClick:(UIButton *)button
{
  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要发布新Build吗？" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self postBuildNotification];
  }];
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
  }];
  [alertController addAction:action];
  [alertController addAction:cancelAction];
  [self presentViewController:alertController animated:YES completion:nil];
}


- (void)postBuildNotification
{
  
  NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
  NSString *host = [userdefault objectForKey:@"host"];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"ideabinder" password:@"ideabinder"];

  NSString *url;
  if ([[self.viewModel headerAppIdentifier] isEqualToString:@"com.ideabinder.salesMOUD.WorkingCenterRep"]) {
    url = [NSString stringWithFormat:@"http://%@/view/Customized/job/iDAREP/build",host];
  }
  if ([[self.viewModel headerAppIdentifier] isEqualToString:@"com.ideabinder.xjp.remicade"]) {
    url = [NSString stringWithFormat:@"http://%@/view/Customized/job/iDADSM/build",host];
  }
  [SVProgressHUD show];
  
  [manager POST:url parameters:nil success:^ void(AFHTTPRequestOperation * operation, id result) {
    
    
    if (operation.response.statusCode == 201) {
      [SVProgressHUD showSuccessWithStatus:@"Build正在发布,请等待推送消息"];
    }
    else {
      [SVProgressHUD showErrorWithStatus:@"发布失败请重试"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [SVProgressHUD dismiss];
    });
  } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
    [SVProgressHUD showErrorWithStatus:@"发布失败请重试"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [SVProgressHUD dismiss];
    });
    
  }];
  
  
}
- (void)leftViewClickAtIndex:(NSInteger)index
{
  [self.viewModel reloadHistoryBuildsWithIndex:index completion:^{
    [self.rightTableView reloadData];
    [self refreshHeaderView];
  }];
}


#pragma mark -
#pragma mark - Properties

- (PDLeftTableViewProtocol *)leftProtocol
{
  if (!_leftProtocol) {
    _leftProtocol = [[PDLeftTableViewProtocol alloc] init];
    _leftProtocol.controller = self;
    _leftProtocol.viewModel = self.viewModel;
  }
  return _leftProtocol;
}

- (PDRightTableViewProtocol *)rightProtocol
{
  if (!_rightProtocol) {
    _rightProtocol = [[PDRightTableViewProtocol alloc] init];
    _rightProtocol.viewModel = self.viewModel;
    
  }
  return _rightProtocol;
}


- (PDProductViewModel *)viewModel
{
  if (!_viewModel) {
    _viewModel = [[PDProductViewModel alloc] init];
  }
  return _viewModel;
}
@end
