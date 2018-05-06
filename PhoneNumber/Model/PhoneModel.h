//
//  PhoneModel.h
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface PhoneModel : RLMObject

@property NSString *phoneID;
@property NSString *name;
@property NSString *address;
@property NSString *latitude;
@property NSString *longitude;
@property NSString *areCode;
@property NSString *provider;
@property NSString *phone_number;
@property NSString *exchange;
@property NSString *zipCode;
@property NSString *serviceType;
@property NSString *carrier;
@property NSString *cllCode;
@property NSString *areStr;

+ (PhoneModel*)phoneWithDic:(NSDictionary*)dic;

- (NSString*)phoneString;

@end
