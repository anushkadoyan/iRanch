//
//  AddViewController.m
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "AddViewController.h"
#import "MapViewController.h"
@interface AddViewController ()<UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *restNameField;
//@property (weak, nonatomic) IBOutlet UITextView *restAboutView;
@property (weak, nonatomic) IBOutlet UITextView *aboutField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *rateSlider;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic)  CLGeocoder *geocoder;
@property (strong, nonatomic)  CLPlacemark *placemark;
@property (weak, nonatomic) IBOutlet UILabel *rateLabelDesc;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

//========================================================
//
//
// CORE LOCATION AND IMAGE PICKER API USED HERE
//
//========================================================
@implementation AddViewController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.restNameField.delegate = self;
    self.aboutField.delegate = self;
    self.restNameField.placeholder = self.name;
    self.imageView.image = self.image;
    self.rateLabelDesc.text = @"Meh";

    [self.rateSlider setValue: 5 animated: YES];
    [self.restNameField becomeFirstResponder];
    
    //When clicking away dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector( dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navBar.shadowImage = [UIImage new];
    self.navBar.translucent = YES;
    [self.rateSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.2 alpha:1.0] ];

    

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
    
//    NSLog(@"lat:%@, long:%@",latitudeString,longitudeString);

    self.locationDict= [[NSDictionary alloc] initWithObjectsAndKeys:latitudeString, @"latitude",
                           longitudeString, @"longitude", nil];
    
    [self.locationButton setTitle:@"Found" forState:(UIControlStateNormal)];
    [self.locationManager stopUpdatingLocation];

    
//    didn't work :(
    // Reverse Geocoding
    
    
    
//    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
//        CLPlacemark *placemark = placemarks[0];
//        NSLog(@"Found %@", placemark.name);
//        self.address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                                         self.placemark.subThoroughfare, self.placemark.thoroughfare,
//                                                         self.placemark.postalCode, self.placemark.locality,
//                                                         self.placemark.administrativeArea,
//         self.placemark.country];
//    }];
    [self.geocoder reverseGeocodeLocation: newLocation completionHandler:
    
    ^(NSArray *placemarks, NSError *error) {
        
        
        
        //Get nearby address
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        
        
        //String to hold address
        
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        
        
        
        //Print the location to console
        
        NSLog(@"I am currently at %@",locatedAt);
        
        self.address = locatedAt;
        
        //Set the label text to current location
        
        
        
        
        
    }];
//    NSLog(@"Resolving the Address");
//    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//        if (error == nil && [placemarks count] > 0) {
//            self.placemark = [placemarks lastObject];
//            self.address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                 self.placemark.subThoroughfare, self.placemark.thoroughfare,
//                                 self.placemark.postalCode, self.placemark.locality,
//                                 self.placemark.administrativeArea,
//                                 self.placemark.country];
//        } else {
//            NSLog(@"error:%@", error.debugDescription);
//        }
//        NSString *returnAddress = self.address;
//        NSLog(@"%@",self.address);
////        [self remainderOfMethodHereUsingReturnAddress:returnAddress];
//
//    } ];
    
    
    
    
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


// touch away
-(void)dismissKeyboard {
    [self.restNameField resignFirstResponder];
    [self.aboutField resignFirstResponder];

}


// Rating changed
- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int numberAsInt = (int) (slider.value+0.5f);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",numberAsInt];
    self.rateLabel.text = [NSString stringWithFormat:@"%@%@",newText,@"/10"];
    self.rating = [self.rateLabel.text intValue];
    if ([self.rateLabel.text intValue]==0) {
        self.rateLabelDesc.text = @"Ew";

    }
    else if ([self.rateLabel.text intValue]>0 && [self.rateLabel.text intValue]<=3) {
        self.rateLabelDesc.text = @"Yuck";

    }
    else if ([self.rateLabel.text intValue]>3 && [self.rateLabel.text intValue]<=6) {
        self.rateLabelDesc.text = @"Meh";

    }
    else if ([self.rateLabel.text intValue]>6 && [self.rateLabel.text intValue]<=9) {
        self.rateLabelDesc.text = @"Yum";

    }
    else if ([self.rateLabel.text intValue]==10) {
        self.rateLabelDesc.text = @"Wow!";

    }
    if([self.rateLabel.text intValue]<5) {
        [self.rateSlider setMinimumTrackTintColor:[UIColor redColor]];

    }
    else {
        [self.rateSlider setMinimumTrackTintColor:[UIColor colorWithRed:0.2 green:0.6 blue:0.2 alpha:1.0] ];

    }

    
}


// Image button clicked
- (IBAction)addImageClicked:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;

    [self presentViewController:picker animated:YES completion:NULL];
}


// Location button clicked
- (IBAction)getLocationClicked:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestAlwaysAuthorization];
    self.geocoder = [[CLGeocoder alloc] init];

    [self.locationManager startUpdatingLocation];
    

}

// IMAGE PICKER
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelClicked:(id)sender {
    if(self.completionHandler) {
        self.completionHandler(nil,nil,5,nil,nil,nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (BOOL) textView: (UITextView *) textView shouldChangeTextInRange: (NSRange) range replacementText: (NSString *)text {
    NSString *changedString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [self enableSaveButton:self.restNameField.text about:changedString];
    return YES;
}

-(BOOL) textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:( NSString *)string {
    

    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self enableSaveButton:self.aboutField.text about:changedString];
    return YES;
}

-(void) enableSaveButton: (NSString *) restNameText about:(NSString *) restAboutText {
    self.saveButton.enabled =(restNameText.length > 0 && restAboutText.length > 0);
}


// Save button clicked
- (IBAction)saveClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.completionHandler) {
        // ADD RATING
//        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        self.completionHandler(self.restNameField.text,self.aboutField.text,self.rating,self.imageView.image,self.locationDict,self.address);
    }

}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(self.completionHandler) {
        // ADD RATING
//        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);

        self.completionHandler(self.restNameField.text,self.aboutField.text,self.rating,self.imageView.image,self.locationDict,self.address);
        
    }
    self.aboutField.text=nil;
    self.restNameField.text=nil;

    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
