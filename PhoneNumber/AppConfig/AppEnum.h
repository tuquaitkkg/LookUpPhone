//
//  AppEnum.h
//  PhotoCleaner
//
//  Created by NhuomTV on 11/15/16.
//  Copyright © 2016 Nextop Asia. All rights reserved.
//

#ifndef AppEnum_h
#define AppEnum_h

#define WIDTH_SCREEN  [UIScreen mainScreen].bounds.size.width
#define HEGHT_SCREEN [UIScreen mainScreen].bounds.size.height
#define DOCUMENT_PATH NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#endif  
