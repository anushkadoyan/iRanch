//
//  MapViewController.m
//  iRanch
//
//  Created by Anush on 5/4/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

@import GoogleMaps;

@interface MapViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;


@end


@implementation MapViewController{
    GMSMapView *mapView_;
    
}


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    // Check for iOS 8 Vs earlier version like iOS7.Otherwise code will
//    // crash on ios 7
//    if ([self.locationManager respondsToSelector:@selector
//         (requestWhenInUseAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//    [self.locationManager startUpdatingLocation];    //    [self.locationManager startUpdatingLocation];


//    [self.locationManager startUpdatingLocation];
    
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    // Do any additional setup after loading the view, typically from a nib.

    // Do any additional setup after loading the view.
}






#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00B0",
                                newLocation.coordinate.latitude];
//    self.latitudeLabel.text = latitudeString;
    
    NSString *longitudeString = [NSString stringWithFormat:@"%g\u00B0",
                                 newLocation.coordinate.longitude];
    
    NSLog(@"lat:%@, long:%@",latitudeString,longitudeString);
    NSInteger lat = [latitudeString integerValue];
    NSInteger lon = [longitudeString integerValue];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lon
                                                                 zoom:6];
    // Creates a marker in the center of the map.
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    GMSCameraPosition *camera2 = [GMSCameraPosition cameraWithLatitude:lat-1
                                                            longitude:lon-1
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

    marker.position = CLLocationCoordinate2DMake(lat, lon);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    
    marker2.position = CLLocationCoordinate2DMake(lat-1, lon-1);
    marker2.title = @"Sydney";
    marker2.snippet = @"Australia";
    marker2.map = mapView_;

    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSString *errorType = (error.code == kCLErrorDenied) ?
    @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error getting Location"
                          message:errorType
                          delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    switch (status) {
//        case kCLAuthorizationStatusNotDetermined:
//        case kCLAuthorizationStatusRestricted:
//        case kCLAuthorizationStatusDenied:
//        {
//            // do some error handling
//        }
//            break;
//        default:{
//            [self.locationManager startUpdatingLocation];
//        }
//            break;
//    }
//}

//-(void)CurrentLocationIdentifier
//{
//    //---- For getting current gps location
//        //------
//}
//// CLLocationManager Delegate Methods
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:
//(NSArray *)locations
//{
//    NSLog(@"location info object=%@", [locations lastObject]);
//}
//
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"%@", error.localizedDescription);
//}
//
//



/*
 - (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"called");
    CLLocation* currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             //             CountryArea = NULL;
         }
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
     }];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


