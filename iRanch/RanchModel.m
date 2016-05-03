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
    [self.restaurants writeToFile:self.filepath atomically:YES];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent:kRanchPList];
        _restaurants = [NSMutableArray arrayWithContentsOfFile:_filepath];
        
        // initialize our properties
        
        if(!_restaurants) {
//            NSDictionary *rest1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hot Wings", nameKey,
//                                    @"This place has the best ranch!!", aboutKey, nil];
            Restaurant *rest1= [[Restaurant alloc] initWithName:@"Hot Wings" about:@"This place has the best ranch!!" rating:10];
            Restaurant *rest2= [[Restaurant alloc] initWithName:@"Conrads" about:@"Yummy and nice texture" rating:7];
            Restaurant *rest3= [[Restaurant alloc] initWithName:@"Domino's" about:@"Gross. I hate it." rating:4];
            Restaurant *rest4= [[Restaurant alloc] initWithName:@"Taco Bell" about:@"It's okay" rating:5];
            Restaurant *rest5= [[Restaurant alloc] initWithName:@"LA Cafe" about:@"Almost perfect" rating:9];


//            MyClass oClass = [[MyClass alloc] initWithName:@"Hot Wings" andAbout:@"This place has the best ranch!!"];

            
            _restaurants  = [[NSMutableArray alloc] initWithObjects:
                           rest1,rest2,rest3,rest4,rest5,nil];
            
        }
    }
    return self;
}


- (NSUInteger) numberOfRestaurants {
    return [self.restaurants count];
}


-(Restaurant *) getRestaurantByName: (NSString*) name {
    NSString *query = name;
    BOOL found = NO;
    for (Restaurant *rest in _restaurants) {
        if ([rest.name isEqualToString:query]) {
            found = YES;
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
    [self save];
}

- (void) insertRestaurant: (Restaurant *) restaurant {
    
    [self.restaurants addObject: restaurant];
    [self save];
}



- (void) insertRestaurant: (NSString *) name
                  about: (NSString *) about
                  rating: (int) rating {
    
    Restaurant *rest= [[Restaurant alloc] initWithName:name about:about rating:rating];
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
