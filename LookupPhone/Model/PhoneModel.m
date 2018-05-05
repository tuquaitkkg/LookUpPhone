//
//  PhoneModel.m
//  LookupPhone
//
//  Created by NhuomTV on 1/17/17.
//  Copyright © 2017 Nextop Asia. All rights reserved.
//

#import "PhoneModel.h"
#import "NSDictionary+SafeGetters.h"

@implementation PhoneModel

+ (PhoneModel*)phoneWithDic:(NSDictionary*)dic{
    
    PhoneModel *phone = [[PhoneModel alloc] init];
//    phone.phoneID = [dic stringForKey:@"uid"];
//    phone.city = [dic stringForKey:@"city"];
//    phone.country = [dic stringForKey:@"country"];
//    
//    
//    NSDictionary *dicLocation = [dic dictionaryForKey:@"geo_location"];
//    phone.latitude = [dicLocation stringForKey:@"latitude"];
//    phone.longitude = [dicLocation stringForKey:@"longitude"];
//    
//    NSArray *phones = [dic arrayForKey:@"phones"];
//    if (phones.count) {
//        
//        NSDictionary *dicPhone = phones[0];
//        
//        phone.carrier = [dicPhone stringForKey:@"carrier"];
//        phone.is_sms_allowed = [dicPhone stringForKey:@"is_sms_allowed"];
//        phone.phone_number = [dicPhone stringForKey:@"phone_number"];
//        phone.phone_rank = [dicPhone stringForKey:@"phone_rank"];
//        phone.phone_type = [dicPhone stringForKey:@"phone_type"];
//
//    }
//    
//    phone.provider = [dic stringForKey:@"provider"];
//    phone.state = [dic stringForKey:@"state"];
//    phone.type = [dic stringForKey:@"type"];
//    phone.zip = [dic stringForKey:@"zip"];

    
    return phone;
}

- (NSString*)phoneString{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [self.phone_number length]; i++) {
        [array addObject:[NSString stringWithFormat:@"%C", [self.phone_number characterAtIndex:i]]];
    }
    return  [self convertStringFromNumbers:array];
}

-(NSString*)convertStringFromNumbers: (NSArray*)numbers{
    
    NSString *str = @"";
    if (numbers.count >= 3) {
        str = @"(";
    }
    
    for (NSInteger i=0; i< numbers.count; i++) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@", numbers[i]]];
        if (i == 2) {
            str =  [str stringByAppendingString:@") "];
        }
        
        if (i == 5) {
            str =  [str stringByAppendingString:@"-"];
        }
        
    }
    
    return str;
}
@end
