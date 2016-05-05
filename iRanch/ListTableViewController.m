//
//  TableViewController.m
//  iRanch
//
//  Created by Anush on 5/1/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

#import "ListTableViewController.h"
#import "Restaurant.h"
#import "RanchViewController.h"

#import "AddViewController.h"
#import "RanchModel.h"
@interface TableViewController ()
@property (strong, nonatomic) RanchModel *model;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [RanchModel sharedModel];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editClicked:(id)sender {
    if(self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.model.numberOfRestaurants;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model removeRestaurantAtIndex:indexPath.row];
        
        // Delete the row from the tableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (UITableViewCell *) tableView: (UITableView *) tableView
          cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Restaurant *rest = [self.model restaurantAtIndex:indexPath.row];
    
    cell.textLabel.text = rest.name;
    cell.textLabel.font = [UIFont fontWithName:@"Verdana" size:18.0f];
    //NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager]
                                       // URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    

    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Restaurant *r = [[Restaurant alloc] init];
    if ([segue.identifier  isEqual: @"addRanch"]) {
        AddViewController *addVC = segue.destinationViewController;
        //    addVC.restAboutPlaceholder = @"Write something ranchy!";
        addVC.name = @"Hot Wings";
        addVC.rating = 5;
        
        addVC.completionHandler = ^(NSString* name,NSString* restAboutPlaceholder,int rating,UIImage* image ) {
            // && restAboutPlaceholder!=nil && ![restAboutPlaceholder isEqual:@"Write something ranchy!"]
            if(name!=nil) {

                NSData *imageData = UIImagePNGRepresentation(image);
                [self.model insertRestaurant:name about:restAboutPlaceholder rating:rating image:imageData];
                
                [self.tableView reloadData];

                
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        };

    }
    else if ([segue.identifier  isEqual: @"showRanch"]) {

        RanchViewController *ranchVC = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        ranchVC.name = cell.textLabel.text;
        r = [self.model getRestaurantByName:cell.textLabel.text];

        ranchVC.about = r.about;
        
        UIImage* img = [[UIImage alloc] initWithData:r.image];
        ranchVC.rating = r.rating;
        if(r!=nil && r.image!=nil) {
            ranchVC.image =img;
        }
        if(r.image==nil) {
            NSLog(@"is nil");
            UIImage* defaultImage = [UIImage imageNamed: @"defaultranch"];

//            NSData *defaultData = UIImagePNGRepresentation(defaultImage);

//            r.image = defaultData;
            ranchVC.image =  defaultImage;
;
        }
        ranchVC.completionHandler = ^(NSString* name,NSString* restAboutPlaceholder,int rating,NSData* image ){
        
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }

}


@end
