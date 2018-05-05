//
//  MapViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/19/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.phoneModel phoneString];

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.phoneModel.latitude.floatValue, self.phoneModel.longitude.floatValue);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [self.mapView addAnnotation:annotation];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                               target:self
                                                                               action:@selector(onRightBarButton:)];
    [self.navigationItem setRightBarButtonItem:rightItem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)onRightBarButton:(UIBarButtonItem*)sender{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Options" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Apple Map" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString* directionsURL = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude,[self.phoneModel.latitude floatValue], [self.phoneModel.longitude floatValue]];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: directionsURL]];

    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Google Map" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            NSString *url = [NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f&zoom=14&directionsmode=driving", [self.phoneModel.latitude floatValue], [self.phoneModel.longitude floatValue]];

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        else {

            [[UIApplication sharedApplication] openURL:[NSURL
                                                        URLWithString:@"https://itunes.apple.com/app/id585027354"]];
        }

    }]];
    
    [actionSheet setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [actionSheet
                                                     popoverPresentationController];
    popPresenter.barButtonItem = sender;
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
