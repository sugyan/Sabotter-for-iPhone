#import <UIKit/UIKit.h>


@interface SBConfigViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    UISwitch *t_switch;
    UISwitch *w_switch;
    UITextField *t_usernameField;
    UITextField *w_usernameField;
    UITextField *t_passwordField;
    UITextField *w_passwordField;
}

@end
