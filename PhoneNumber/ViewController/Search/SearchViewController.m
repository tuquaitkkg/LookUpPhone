//
//  SearchViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "SearchViewController.h"
#import "HttpClient.h"
#import "PhoneModel.h"
#import "PhoneDetailViewController.h"
#import <KSToastView/KSToastView.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (nonatomic, strong) NSMutableArray *numbers;
@property (weak, nonatomic) IBOutlet UIButton *btnPaste;

@end

@implementation SearchViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"ico_search"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchActionButton_TouchUpInside:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.numberLabel.text = @"";
    self.btnPaste.layer.cornerRadius = 3;
    self.btnPaste.layer.borderWidth = 2;
    self.btnPaste.layer.borderColor = self.btnPaste.titleLabel.textColor.CGColor;
    self.viewPhoneNumber.layer.cornerRadius = 5.0f;
    self.viewPhoneNumber.layer.masksToBounds = YES;
    self.viewPhoneNumber.clipsToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(IBAction)searchActionButton_TouchUpInside:(id) sender{
    if (self.numbers.count < 10) {
        [KSToastView ks_showToast:@"Phone number you enter is invalid."];
        return;
    }
    NSString *str = [self.numbers componentsJoinedByString:@""];
    [self searchWithPhone:str];
}

-(NSMutableArray *)numbers{

    if (_numbers == nil) {
        _numbers = [NSMutableArray new];
    }
    return _numbers;
}

-(NSString*)convertStringFromNumbers{
    
    NSString *str = @"";
    if (self.numbers.count >= 3) {
        str = @"(";
    }

    for (NSInteger i=0; i< self.numbers.count; i++) {
        NSString *number = self.numbers[i];
        str = [str stringByAppendingString:number];
        if (i == 2) {
           str =  [str stringByAppendingString:@") "];
        }
        
        if (i == 5) {
           str =  [str stringByAppendingString:@"-"];
        }

    }

    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onNumberButton:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSInteger number = button.tag - 1000;
    if (number == -1) {
        //Delete
        if (self.numbers.count) {
            [self.numbers removeLastObject];
            self.numberLabel.text = [self convertStringFromNumbers];
        }
        return ;
    }
    if (number == -2) {
        //Delete all
        if (self.numbers.count) {
            [self.numbers removeAllObjects];
            self.numberLabel.text = [self convertStringFromNumbers];
        }
        return ;
    }
    
    if (self.numbers.count >= 10) {
        return ;
    }
    
    [self.numbers addObject:[NSString stringWithFormat:@"%ld",number]];
    self.numberLabel.text = [self convertStringFromNumbers];
    if (self.numbers.count == 10) {
        [self searchActionButton_TouchUpInside:nil];
    }

}

- (IBAction)onPaste:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *originalString = pasteboard.string;
    if (!originalString.length) {
        return;
    }

    [self.numbers removeAllObjects];

    for (int i = 0; i < [originalString length]; i++) {
        NSString *str = [NSString stringWithFormat:@"%C", [originalString characterAtIndex:i]];
        if ([str isEqualToString:@"0"]
            || [str isEqualToString:@"1"]
            || [str isEqualToString:@"2"]
            || [str isEqualToString:@"3"]
            || [str isEqualToString:@"4"]
            || [str isEqualToString:@"5"]
            || [str isEqualToString:@"6"]
            || [str isEqualToString:@"7"]
            || [str isEqualToString:@"8"]
            || [str isEqualToString:@"9"]) {
            [self.numbers addObject:str];
        }
    }
    self.numberLabel.text = [self convertStringFromNumbers];
}

@end
