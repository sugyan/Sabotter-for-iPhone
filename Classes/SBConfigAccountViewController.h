//
//  SBConfigAccountViewController.h
//  Sabotter
//
//  Created by sugyan on 10/01/02.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"


typedef enum {
    SERVICE_TWITTER,
    SERVICE_WASSR,
} ConfigAccountService;


@interface SBConfigAccountViewController : UIViewController <HttpClientProtocol> {
    ConfigAccountService service;
    IBOutlet UILabel *titleLabel;
    IBOutlet UISwitch *enableSwitch;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UIBarButtonItem *saveButton;
}

- (id)initWithService:(ConfigAccountService)configAccountService;
- (IBAction)onPushCancelButton:(id)sender;
- (IBAction)onPushSaveButton:(id)sender;
- (IBAction)onEndEditingTextField:(id)sender;
- (IBAction)onChangeValueOfTextField:(id)sender;
- (IBAction)onChangeSwitch:(id)sender;

@end
