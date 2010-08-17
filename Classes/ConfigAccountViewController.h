//
//  ConfigAccountViewController.h
//  Sabotter
//
//  Created by sugyan on 10/08/02.
//

#import <UIKit/UIKit.h>
#import "Common.h"


@interface ConfigAccountViewController : UITableViewController {
    IBOutlet UISwitch *enableSwitch;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    SBService service;
}

@property (readwrite) SBService service;

- (IBAction)onUsernameFieldExit:(id)sender;
- (IBAction)onPasswordFieldExit:(id)sender;

@end
