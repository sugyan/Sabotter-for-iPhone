//
//  SBConfigTableViewController.h
//  Sabotter
//
//  Created by sugyan on 09/12/21.
//

#import <UIKit/UIKit.h>


@interface SBConfigTableViewController : UITableViewController {
    IBOutlet UITextField *twitterUsernameField;
    IBOutlet UITextField *twitterPasswordField;
    IBOutlet UITextField *wassrUsernameField;
    IBOutlet UITextField *wassrPasswordField;
}

- (IBAction)editingTextFieldDone:(id)sender;

@end
