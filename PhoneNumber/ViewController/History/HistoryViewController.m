//
//  HistoryViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryViewCell.h"
#import <Realm.h>
#import "PhoneModel.h"
#import "HttpClient.h"
#import "PhoneDetailViewController.h"
#import <KSToastView/KSToastView.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface HistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) RLMResults *historys;

@end

@implementation HistoryViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"History";
        self.tabBarItem.image = [[UIImage imageNamed:@"ic_history_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_history_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HistoryViewCell class]) ];
    
    UIBarButtonItem *barButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Edit"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(toggleEdit)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UIBarButtonItem *barButtonItem1=[[UIBarButtonItem alloc]initWithTitle:@"About"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(goToRateApp)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.historys = [PhoneModel allObjects];
    
    [self.tableView reloadData];

}

-(void)toggleEdit{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
}

-(void)goToRateApp{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    aboutView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutView animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PhoneModel *model = [self.historys objectAtIndex:indexPath.row];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObject:model];
        }];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhoneModel *model = [self.historys objectAtIndex:indexPath.row];
    [self searchWithPhone:model.phone_number];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryViewCell *cell = (HistoryViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HistoryViewCell class]) ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCell:[self.historys objectAtIndex:indexPath.row]];
    return cell;
}


@end
