//
//  MapViewController.m
//  iRanch
//
//  Created by Anush on 5/4/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "MapViewController.h"
#import "RanchModel.h"
#import "Restaurant.h"
@import GoogleMaps;

@interface MapViewController ()
@property (strong, nonatomic) RanchModel *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadClicked;

@end

//========================================================
//
//
// GOOGLE MAPS API USED HERE
//
//========================================================

// API KEY
// AIzaSyDHIPecYdIHQGmnWh20ycjCE51KHqMS0Oc


@implementation MapViewController{
    GMSMapView *mapView_;
    
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

    self.model = [RanchModel sharedModel];

    [self loadMap];
}
- (void) loadMap {
    NSLog(@"called reload");
    //     Create a GMSCameraPosition that tells the map to display the
    //     coordinate -33.86,151.20 at zoom level 6.
    //
    //     Creates a marker in the center of the map.
    
    //zoom on california
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:34.0196
                                                            longitude:-118.29
                                                                 zoom:13];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    //  Go through restaurants and extract locations from each to display on map
    for (int i = 0; i < [self.model numberOfRestaurants]; i++)
    {
        Restaurant *rest = [self.model restaurantAtIndex:i];
        if(rest.location!=nil) {
            NSLog(@"not nil");
            NSString *latitude=rest.location[@"latitude"];
            NSString *longitude=rest.location[@"longitude"];
            CLLocationDegrees lat = [latitude doubleValue];
            CLLocationDegrees lon = [longitude doubleValue];
            NSLog(@"lat:%g, long:%g",lat,lon);
            
            // Creates a marker in the center of the map.
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(lat, lon);
            marker.title = rest.name;
            //            marker.icon = img;
            mapView_.settings.myLocationButton = true;
            
            marker.snippet = [NSString stringWithFormat:@"Rating: %d",rest.rating];
            marker.map = mapView_;
        }
        
    }
    

}
//reload button clicked
- (IBAction)reloadClicked:(id)sender {
    [self loadMap];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


