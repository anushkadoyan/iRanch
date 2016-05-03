//
//  Restaurant.m
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "Restaurant.h"
@interface Restaurant()

@end

@implementation Restaurant
-(id)initWithName:(NSString *)name
            about:(NSString *)about
           rating:(int)rating
{
    self = [super init];
    if (self) {
        self.name = name;
        self.about = about;
        self.rating = rating;
    }
    return self;
}

@end
