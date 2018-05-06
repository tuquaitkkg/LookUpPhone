//
//  HttpClient.h
//  MovieBox
//
//  Created by NhuomTV on 12/26/16.
//  Copyright © 2016 Nextop Asia. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^CallBack)(BOOL success, NSString *message, NSInteger code, id result);

@interface HttpClient : AFHTTPSessionManager

    
#define API [HttpClient sharedInstance]
    
    /**
     * gets singleton object.
     * @return singleton
     */
+ (HttpClient*)sharedInstance;

- (void)searchPhone:(NSString* )phoneNumber calBack:(CallBack)callBack;


@end
