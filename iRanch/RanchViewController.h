//
//  RanchViewController.h
//  iRanch
//
//  Created by Anush on 5/2/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


typedef void (^ranchCompletionHandler) (NSString* name,NSString* about,int rating, NSData *image);


@interface RanchViewController : UIViewController<CLLocationManagerDelegate>


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) UIImage *image;

@property int rating;
@property (copy,nonatomic) ranchCompletionHandler completionHandler;

@end
