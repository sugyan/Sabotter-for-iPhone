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
}

@property (nonatomic, retain) UILabel *statusTextLabel;

@end
