//
//  RanchModel.h
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
//static NSString * const nameKey = @"name";
//static NSString * const aboutKey = @"about";
@interface RanchModel : NSObject

+ (instancetype) sharedModel;
- (NSUInteger) numberOfRestaurants;
- (Restaurant *) restaurantAtIndex: (NSUInteger) index;
- (void) removeRestaurantAtIndex: (NSUInteger) index;
- (void) insertRestaurant: (Restaurant *) restaurant;
- (void) insertRestaurant: (NSString *) name
                    about: (NSString *) about
                   rating: (int) rating
                    image: (NSData*) image
                 location: (NSDictionary*) location
                  address: (NSString *) address;

-(Restaurant *) getRestaurantByName: (NSString*) name;

- (void) insertRestaurant: (Restaurant *) restaurant
                 atIndex: (NSUInteger) index;
//- (void) insertRestaurant: (NSString *) restaurant
//                  about: (NSString *) about
//                 atIndex: (NSUInteger) index;

@end
