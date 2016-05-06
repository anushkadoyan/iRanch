//
//  AddViewController.h
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^addCompletionHandler) (NSString* name,NSString* restAboutPlaceholder,int rating, UIImage* image, NSDictionary* location, NSString *address);

@interface AddViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *about;
//rate 1-5
@property int rating;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDictionary *locationDict;
@property (strong, nonatomic) NSString  *restAboutPlaceholder;
@property (copy,nonatomic) addCompletionHandler completionHandler;
@property (strong, nonatomic)  NSString *address;

@end
