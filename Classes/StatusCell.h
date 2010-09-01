//
//  StatusCell.h
//  Sabotter
//
//  Created by sugyan on 10/08/25.
//

#import <UIKit/UIKit.h>


@interface StatusCell : UITableViewCell {
    IBOutlet UIView *view;
    IBOutlet UILabel *statusTextLabel;
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *infoLabel;
}

@property (nonatomic, retain) UILabel *statusTextLabel;
@property (nonatomic, retain) UILabel *usernameLabel;
@property (nonatomic, retain) UILabel *infoLabel;

@end
