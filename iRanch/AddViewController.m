//
//  AddViewController.m
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *restNameField;
@property (weak, nonatomic) IBOutlet UITextView *restAboutView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelClicked:(id)sender {
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