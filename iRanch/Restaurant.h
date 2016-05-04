//
//  Restaurant.h
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject <NSCoding>
@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *about;
//rate 1-5
@property int rating;


-(id)initWithName:(NSString *)name
            about:(NSString *)about
           rating:(int)rating;
@end
