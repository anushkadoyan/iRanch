//
//  RanchViewController.h
//  iRanch
//
//  Created by Anush on 5/2/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ranchCompletionHandler) (NSString* name,NSString* about,int rating, UIImage *image);


@interface RanchViewController : UIViewController

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) UIImage *image;

@property int rating;
@property (copy,nonatomic) ranchCompletionHandler completionHandler;

@end
