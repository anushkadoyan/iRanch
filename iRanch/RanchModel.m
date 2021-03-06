//
//  RanchModel.m
//  iRanch
//
//  Created by Anush on 4/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//
#import "Restaurant.h"
#import "RanchModel.h"
static NSString *const kRanchPList = @"Ranch.plist";

@interface RanchModel()

@property (strong, nonatomic) NSMutableArray *restaurants;
@property NSUInteger currentIndex;
@property (strong, nonatomic) NSString *filepath;
@property (strong, nonatomic) NSData *data;

@end

@implementation RanchModel

+ (instancetype) sharedModel {
    static RanchModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}
-(void) save {
//save to plist file
    _data = [NSKeyedArchiver archivedDataWithRootObject:_restaurants];
    [self.data writeToFile:self.filepath atomically:YES];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent:kRanchPList];
       
        _data = [NSData dataWithContentsOfFile:_filepath];
        _restaurants = [NSKeyedUnarchiver unarchiveObjectWithData:_data];
        // initialize our properties
//        NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager]
//                                            URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
        if(!_restaurants) {
//            NSDictionary *rest1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hot Wings", nameKey,
//                                    @"This place has the best ranch!!", aboutKey, nil];
            
            
//            NSData *imageData = UIImagePNGRepresentation(resta.image);
//            UIImage *image = [UIImage imageWithData:data];

            
            //Dummy locations
            NSDictionary *locationDict= [[NSDictionary alloc] initWithObjectsAndKeys:@"23", @"latitude",
                                @"42", @"longitude", nil];
             NSDictionary *locationDic2= [[NSDictionary alloc] initWithObjectsAndKeys:@"12.42", @"latitude",
                                @"123.1", @"longitude", nil];
             NSDictionary *locationDic3= [[NSDictionary alloc] initWithObjectsAndKeys:@"36.7783", @"latitude",
                                @"119.4179", @"longitude", nil];
             NSDictionary *locationDict4= [[NSDictionary alloc] initWithObjectsAndKeys:@"40", @"latitude",
                                @"45", @"longitude", nil];
             NSDictionary *locationDict5= [[NSDictionary alloc] initWithObjectsAndKeys:@"31", @"latitude",
                                @"-30", @"longitude", nil];
            
            
            //Dummy restaurants and reviews
            Restaurant *rest1= [[Restaurant alloc] initWithName:@"Hot Wings" about:@"This place has the best ranch!!" rating:10 image:nil location:locationDict address: @"314 N Brand Blvd, Glendale, CA 91203"];
            Restaurant *rest2= [[Restaurant alloc] initWithName:@"Conrads" about:@"Yummy and nice texture" rating:7 image:nil location:locationDic2 address:@"820 N Central Ave, Glendale, CA 91203"];
            Restaurant *rest3= [[Restaurant alloc] initWithName:@"Domino's" about:@"Gross. I hate it." rating:4 image:nil location:locationDic3 address:@"1136 S Colorado Blvd, Denver, CO 80246"];
            Restaurant *rest4= [[Restaurant alloc] initWithName:@"Buffalo Wild Wings" about:@"It's okay" rating:5 image:nil location:locationDict4 address: @"142-C South Brand Boulevard, Glendale, CA 91205"];
            Restaurant *rest5= [[Restaurant alloc] initWithName:@"LA Cafe" about:@"Almost perfect" rating:9 image:nil location:locationDict5 address: @"639 S Spring St, Los Angeles, CA 90014"];
            

//            MyClass oClass = [[MyClass alloc] initWithName:@"Hot Wings" andAbout:@"This place has the best ranch!!"];

            
            _restaurants  = [[NSMutableArray alloc] initWithObjects:
                           rest1,rest2,rest3,rest4,rest5,nil];

            [self save];
            
        }
    }
    return self;
}


- (NSUInteger) numberOfRestaurants {
    return [self.restaurants count];
}


-(Restaurant *) getRestaurantByName: (NSString*) name {
    NSString *query = name;
    for (Restaurant *rest in _restaurants) {
        if ([rest.name isEqualToString:query]) {
            return rest;

            break;
        }
    }
    return nil;
}
- (Restaurant *) restaurantAtIndex: (NSUInteger) index {
    // check index
    
    return self.restaurants[index];
}

- (void) removeRestaurantAtIndex: (NSUInteger) index {
    // check index
    if(index<[self numberOfRestaurants]) {
        [self.restaurants removeObjectAtIndex: index];
        
    }
   NSLog( @"removed");
    [self save];
}

- (void) insertRestaurant: (Restaurant *) restaurant {
    
    [self.restaurants addObject: restaurant];
    [self save];
}



- (void) insertRestaurant: (NSString *) name
                    about: (NSString *) about
                    rating: (int) rating
                    image: (NSData*) image
                    location: (NSDictionary*) location
                  address: (NSString *) address {

    Restaurant *rest= [[Restaurant alloc] initWithName:name about:about rating:rating image:image location:location address: address];
    [self insertRestaurant: rest];

    [self save];
    
}

- (void) insertRestaurant: (Restaurant *) restaurant
                 atIndex: (NSUInteger) index {
    if(index<=[self numberOfRestaurants]) {
        [self.restaurants insertObject: restaurant atIndex: index];
    }
    [self save];
}

//- (void) insertRestaurant: (NSString *) restaurant
//                  about: (NSString *) about
//                 atIndex: (NSUInteger) index {
//    
//    
//    Restaurant *rest= [[Restaurant alloc] initWithName:name about:about rating:rating];
//    
//        [self insertRestaurant:rest atIndex:index];
//    }
//    //    [self.restaurants insertObject:flashcardDict atIndex: index];
//    [self save];
//}
//

@end
