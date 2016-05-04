//
//  AddViewController.h
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addCompletionHandler) (NSString* name,NSString* restAboutPlaceholder,int rating, UIImage* image);

@interface AddViewController : UIViewController
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *about;
//rate 1-5
@property int rating;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString  *restAboutPlaceholder;
@property (copy,nonatomic) addCompletionHandler completionHandler;

@end
