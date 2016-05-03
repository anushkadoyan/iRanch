//
//  RanchModel.h
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
//static NSString * const nameKey = @"name";
//static NSString * const aboutKey = @"about";
@interface RanchModel : NSObject

+ (instancetype) sharedModel;
- (NSUInteger) numberOfRestaurants;
- (NSDictionary *) restaurantAtIndex: (NSUInteger) index;
- (void) removeRestaurantAtIndex: (NSUInteger) index;
- (void) insertRestaurant: (Restaurant *) restaurant;
- (void) insertRestaurant: (NSString *) name
                    about: (NSString *) about
                   rating: (int) rating ;
- (void) insertRestaurant: (Restaurant *) restaurant
                 atIndex: (NSUInteger) index;
//- (void) insertRestaurant: (NSString *) restaurant
//                  about: (NSString *) about
//                 atIndex: (NSUInteger) index;

@end
