//
//  AddViewController.h
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addCompletionHandler) (NSString* restAboutPlaceholder);

@interface AddViewController : UIViewController

@property (strong, nonatomic) NSString  *restAboutPlaceholder;
@property (copy,nonatomic) addCompletionHandler completionHandler;

@end
