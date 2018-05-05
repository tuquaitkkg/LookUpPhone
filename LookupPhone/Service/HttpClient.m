//
//  HttpClient.m
//  MovieBox
//
//  Created by NhuomTV on 12/26/16.
//  Copyright © 2016 Nextop Asia. All rights reserved.
//

#import "HttpClient.h"
#import "PhoneModel.h"
#import <CoreLocation/CoreLocation.h>
#import <TFHpple.h>

@implementation HttpClient

static HttpClient *SINGLETON = nil;
    
static bool isFirstAccess = YES;
    
#pragma mark - Public Method
    
+ (id)sharedInstance
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isFirstAccess = NO;
            SINGLETON = [[super allocWithZone:NULL] init];
        });
        
        return SINGLETON;
    }
    
#pragma mark - Life Cycle
    
+ (id) allocWithZone:(NSZone *)zone
    {
        return [self sharedInstance];
    }
    
+ (id)copyWithZone:(struct _NSZone *)zone
    {
        return [self sharedInstance];
    }
    
+ (id)mutableCopyWithZone:(struct _NSZone *)zone
    {
        return [self sharedInstance];
    }
    
- (id)copy
    {
        return [[HttpClient alloc] init];
    }
    
- (id)mutableCopy
    {
        return [[HttpClient alloc] init];
    }
    
- (id) init
    {
        if(SINGLETON){
            return SINGLETON;
        }
        if (isFirstAccess) {
            [self doesNotRecognizeSelector:_cmd];
        }
        self = [super init];
        self = [super initWithBaseURL:[NSURL URLWithString:@""]];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet
                                                          setWithObjects:@"text/plain", @"text/html", @"application/json",@"text/javascript", nil];
        return self;
}

//-(void)searchPhone:(NSString *)phone calBack:(CallBack)callBack{
//    NSString *url = [NSString stringWithFormat:@"http://gadget.whitepages.com/api/v2/listings/?nonce=2147483647&version=2.0&client_id=8iR5q&device_id=FF8A29DA-001C-4D3B-B18B-C716E6C309FA&page=1&page_size=20&phone=%@&format=json&secret=d4e4639fdf0d5f48aec10b40cb99def4&app_ver=6",phone];
//    
//    [self GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:nil
//      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          
//          if ([responseObject isKindOfClass:[NSDictionary class]]) {
//              NSDictionary *primary = responseObject[@"response"][@"primary"];
//              if ([primary isKindOfClass:[NSDictionary class]]) {
//                  NSArray *list = primary[@"listings"];
//                  if (list.count) {
//                      PhoneModel *phone = [PhoneModel phoneWithDic:list[0]];
//                      if (callBack) {
//                          callBack(YES, @"",1000,phone);
//                      }
//                  }else{
//                      if (callBack) {
//                          callBack(NO, @"",1000,nil);
//                      }
//                  }
//              }else{
//                  if (callBack) {
//                      callBack(NO, @"",1000,nil);
//                  }
//              }
//
//          }
//          NSLog(@"%@",responseObject);
//          
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          
//          if (callBack) {
//              callBack(NO, @"",1000,nil);
//          }
//      }];
//}


- (void)searchPhone:(NSString*) phoneNumber calBack:(CallBack)callBack{
    if (phoneNumber.length > 10) {
        phoneNumber = [phoneNumber substringFromIndex:phoneNumber.length - 10];
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
 
        
        // 1
        NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.reversephonelookup.com/number/%@/",phoneNumber]];
        NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
        
        // 2
        TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
        
        // 3
        NSString *tutorialsXpathQueryString = @"//div/span";
        NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
        
        PhoneModel *phone = [[PhoneModel alloc] init];
        phone.phone_number = phoneNumber;
        
        if (tutorialsNodes.count > 1) {
            TFHppleElement *name = tutorialsNodes[0];
            NSLog(@"%@",name.content);
            phone.name = name.content;
            
            TFHppleElement *address = tutorialsNodes[1];
            NSLog(@"%@",address.content);
            if (![address.content containsString:@"view more"]) {
                phone.address = address.content;
                CLLocationCoordinate2D location = [self geoCodeUsingAddress:address.content];
                phone.latitude = [NSString stringWithFormat:@"%f",location.latitude];
                phone.longitude = [NSString stringWithFormat:@"%f",location.longitude];
            }else{
                phone.address = @"";
            }            
        }
        
        NSString *info = @"//div/table[@cellpadding=5]/tr";
        NSArray *infoNotes = [tutorialsParser searchWithXPathQuery:info];
        
        if (infoNotes.count < 4){
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(NO, @"",1000,nil);
                }
            });
            return ;
        }
        
        TFHppleElement *element1 = infoNotes[0];
        if (element1.children.count >= 8){
            TFHppleElement *element11 = element1.children[3];
            phone.areCode = element11.content;
            NSLog(@"%@",element11.content);
            
            TFHppleElement *element12 = element1.children[7];
            NSLog(@"%@",element12.content);
            phone.exchange = element12.content;
            
        }else{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(NO, @"",1000,nil);
                }
            });
            return ;
        }
        
        TFHppleElement *element2 = infoNotes[1];
        if (element2.children.count >= 7){
            TFHppleElement *element11 = element2.children[2];
            NSLog(@"%@",element11.content);
            phone.provider = element11.content;
            
            TFHppleElement *element12 = element2.children[6];
            NSLog(@"%@",element12.content);
            phone.zipCode = element12.content;
            
        }else{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(NO, @"",1000,nil);
                }
            });
            return ;

        }
        
        TFHppleElement *element3 = infoNotes[2];
        if (element3.children.count >= 6){
            TFHppleElement *element11 = element3.children[2];
            NSLog(@"%@",element11.content);
            phone.serviceType = element11.content;
            
            
            TFHppleElement *element12 = element3.children[5];
            NSLog(@"%@",element12.content);
            phone.carrier = element12.content;
            
        }else{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(NO, @"",1000,nil);
                }
            });
            return ;

        }
        
        TFHppleElement *element4 = infoNotes[3];
        if (element4.children.count >= 6){
            TFHppleElement *element11 = element4.children[2];
            NSLog(@"%@",element11.content);
            phone.areStr = element11.content;
            
            TFHppleElement *element12 = element4.children[5];
            NSLog(@"%@",element12.content);
            phone.cllCode = element12.content;
            
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (callBack) {
                    callBack(NO, @"",1000,nil);
                }
            });
            return ;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (callBack) {
                callBack(YES, @"",1000,phone);
            }
        });
      
    });
   
}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"https://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

@end
