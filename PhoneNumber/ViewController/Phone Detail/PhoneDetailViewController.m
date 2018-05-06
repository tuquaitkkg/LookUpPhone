//
//  PhoneDetailViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "PhoneDetailViewController.h"
#import <MapKit/MapKit.h>
#import <RETableViewManager/RETableViewManager.h>
#import "MapViewController.h"
#import <RETableViewManager.h>
#import "PhoneViewCell.h"

@interface PhoneDetailViewController ()<RETableViewManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *unlockView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnUnLock;

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end

@implementation PhoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.phoneModel phoneString];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.unlockView.hidden = YES;

    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = 50;
    self.tableView.contentInset = inset;

    self.nameLabel.text = self.phoneModel.name;
    self.btnUnLock.layer.cornerRadius = 3.0;
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.phoneModel.latitude.floatValue, self.phoneModel.longitude.floatValue);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [self.mapView addAnnotation:annotation];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    self.manager[NSStringFromClass([RETableViewItem class])]     = NSStringFromClass([PhoneViewCell class]);
    [self setUpData];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)setUpData{
    // Initialize section and add to manager
    RETableViewSection* section = [RETableViewSection section];
    section.headerHeight = 0.1f;
    section.footerHeight = 0.1f;
    
    [self.manager addSection:section];
    
    if (self.phoneModel.name.length > 0){
        RETableViewItem *item                 = [RETableViewItem itemWithTitle:@"Name" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
            
        }];
        item.detailLabelText = self.phoneModel.name;
        [section addItem:item];
    }
    
    RETableViewItem *item0                 = [RETableViewItem itemWithTitle:@"Address" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item0.detailLabelText = self.phoneModel.address;
    [section addItem:item0];
    
    RETableViewItem *item1                 = [RETableViewItem itemWithTitle:@"Phone Number" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item1.detailLabelText = [self.phoneModel phoneString];
    [section addItem:item1];
    
    RETableViewItem *item2                 = [RETableViewItem itemWithTitle:@"Area Code (NPA)" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item2.detailLabelText = self.phoneModel.areCode;
    [section addItem:item2];
    
    RETableViewItem *item3                 = [RETableViewItem itemWithTitle:@"Exchange (NXX)" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item3.detailLabelText = self.phoneModel.exchange;
    [section addItem:item3];
    
    RETableViewItem *item4                 = [RETableViewItem itemWithTitle:@"Original Service Provider" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item4.detailLabelText = self.phoneModel.provider;
    [section addItem:item4];
    
    RETableViewItem *item5                 = [RETableViewItem itemWithTitle:@"Zip Code Coverage" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item5.detailLabelText = self.phoneModel.zipCode;
    [section addItem:item5];
    
    RETableViewItem *item6                 = [RETableViewItem itemWithTitle:@"Original Service Type" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item6.detailLabelText = self.phoneModel.serviceType;
    [section addItem:item6];
    
    RETableViewItem *item7                 = [RETableViewItem itemWithTitle:@"Carrier Type" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item7.detailLabelText = self.phoneModel.carrier;
    [section addItem:item7];
    
    RETableViewItem *item8                 = [RETableViewItem itemWithTitle:@"Original Coverage Area" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item8.detailLabelText = self.phoneModel.areStr;
    [section addItem:item8];
    
    RETableViewItem *item9                 = [RETableViewItem itemWithTitle:@"Switch CLLI Code" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    item9.detailLabelText = self.phoneModel.cllCode;
    [section addItem:item9];
    
}
- (IBAction)unlockButton_TouchUpInside:(id)sender {
    
}
- (IBAction)tapOnMap:(id)sender {
    [self logEventToShowFullAd];
    MapViewController *mapVC = [[MapViewController alloc] initWithNibName:NSStringFromClass([MapViewController class]) bundle:nil];
    mapVC.phoneModel = self.phoneModel;
    [self.navigationController pushViewController:mapVC animated:YES];
}

@end
