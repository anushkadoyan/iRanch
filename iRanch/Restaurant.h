//
//  Restaurant.h
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Restaurant : NSObject <NSCoding>


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *about;
//rate 1-10
@property int rating;
//picture
@property (readwrite, nonatomic) NSData *image;
@property (readwrite, nonatomic) NSDictionary *location;


-(id)initWithName:(NSString *)name
            about:(NSString *)about
            rating:(int)rating
            image:(NSData *)image
            location:(NSDictionary *)location;

- (void) encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder ;

@end
