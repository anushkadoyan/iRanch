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
            image:(NSData *)image
         location:(NSDictionary*) location
            address:(NSString *)address
{
    self = [super init];
    if (self) {
        self.name = name;
        self.about = about;
        self.rating = rating;
        self.image = image;
        self.location = location;
        self.address = address;

    }
    return self;
}




- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.about forKey:@"about"];
    [encoder encodeInteger:self.rating forKey:@"rating"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.address forKey:@"address"];


}
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
    
        self.name = [decoder decodeObjectForKey:@"name"];
        self.about = [decoder decodeObjectForKey:@"about" ];
        self.rating = [decoder decodeIntForKey:@"rating"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.address = [decoder decodeObjectForKey:@"address"];



    }
    return self;

}

@end
