//
//  RanchViewController.m
//  iRanch
//
//  Created by Anush on 5/2/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "RanchViewController.h"

@interface RanchViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UITextView *restAbout;

@end

@implementation RanchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restName.text = self.name;
    self.restAbout.text = self.about;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
