//
//  SBConfigAccountViewController.h
//  Sabotter
//
//  Created by sugyan on 10/01/02.
//

#import <UIKit/UIKit.h>


@interface SBConfigAccountViewController : UIViewController {
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
}

- (IBAction)onPushCancelButton:(id)sender;
- (IBAction)onPushSaveButton:(id)sender;

@end
