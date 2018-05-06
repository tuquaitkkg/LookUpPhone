//
//  ContactViewController.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactViewCell.h"
#import <ContactsKit.h>
#import <AddressBook/AddressBook.h>

@interface ContactViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *contacts;

@end

@implementation ContactViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Contact";
        self.tabBarItem.image = [[UIImage imageNamed:@"ic_contact_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_contact_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    }
    
    return self;
}

-(NSMutableArray *)contacts{

    if (!_contacts) {
        _contacts = [NSMutableArray new];
    }

    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ContactViewCell class]) ];
    
    [self.tableView reloadData];
    [self getData];
    
}
- (void)getData{
    
    CKAddressBook *addressBook = [[CKAddressBook alloc] init];
    
    [addressBook requestAccessWithCompletion:^(NSError *error) {
        
        if (!error)
        {
            // Get fields from the mask
            CKContactField mask = CKContactFieldFirstName | CKContactFieldLastName | CKContactFieldBirthday | CKContactFieldPhones;
            
            // Final sort of the contacts array
            NSArray *sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES] ];
            
            [addressBook contactsWithMask:mask uinify:NO sortDescriptors:sortDescriptors
                                   filter:nil completion:^(NSArray *contacts, NSError *error) {
                                       
                                       if (! error){
                                           [self.contacts removeAllObjects];
                                           [self.contacts addObjectsFromArray:contacts];
                                           [self.tableView reloadData];
                                       }
                                       
                                   }];
        }
        else{
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CKContact *contact = self.contacts[indexPath.row];
    if (contact.phones.count > 0) {
        CKPhone *phone = contact.phones[0];
         NSString *str = [phone.number stringByReplacingOccurrencesOfString:@"-" withString:@""];
         str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
         str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
         str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];

        [self searchWithPhone:str];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactViewCell *cell = (ContactViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactViewCell class]) ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    [cell configCell:self.contacts[indexPath.row]];
    cell.clickGoToCallView = ^(NSIndexPath *indexPath) {
        CallAndMessageViewController *callVC = [[CallAndMessageViewController alloc] initWithNibName:@"CallAndMessageViewController" bundle:nil];
        callVC.hidesBottomBarWhenPushed = YES;
        CKContact *contact = self.contacts[indexPath.row];
        NSString *str;
        if (contact.phones.count > 0) {
            CKPhone *phone = contact.phones[0];
            str = [phone.number stringByReplacingOccurrencesOfString:@"-" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        callVC.phoneNumber = str;
        [self.navigationController pushViewController:callVC animated:YES];
    };
    return cell;
}


@end
