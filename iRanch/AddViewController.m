//
//  AddViewController.m
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()<UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *restNameField;
@property (weak, nonatomic) IBOutlet UITextView *restAboutView;
@property (weak, nonatomic) IBOutlet UITextView *aboutField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *rateSlider;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aboutField.text = self.restAboutPlaceholder;
    self.restNameField.placeholder = self.name;
    self.imageView.image = self.image;
    [self.rateSlider setValue: 5 animated: YES];
    [self.restNameField becomeFirstResponder];

//    picker.sourceType =
//    UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:picker animated:YES
//                     completion:NULL];


//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController.delegate = self;
//    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:imagePickerController animated:YES completion:nil];

}
- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    int numberAsInt = (int) (slider.value+0.5f);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",numberAsInt];
    self.rateLabel.text = [NSString stringWithFormat:@"%@%@",newText,@"/10"];
    self.rating = [self.rateLabel.text intValue];

}
- (IBAction)addImageClicked:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}


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
        self.completionHandler(nil,nil,5,nil);
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
    [self enableSaveButton:self.restAboutView.text about:changedString];
    return YES;
}

-(void) enableSaveButton: (NSString *) restNameText about:(NSString *) restAboutText {
    self.saveButton.enabled =(restNameText.length > 0 && restAboutText.length > 0);
}



- (IBAction)saveClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.completionHandler) {
        // ADD RATING
//        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
        self.completionHandler(self.restNameField.text,self.aboutField.text,self.rating,self.imageView.image);
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(self.completionHandler) {
        // ADD RATING
//        NSData *imageData = UIImagePNGRepresentation(self.imageView.image);

        self.completionHandler(self.restNameField.text,self.aboutField.text,self.rating,self.imageView.image);
        
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
