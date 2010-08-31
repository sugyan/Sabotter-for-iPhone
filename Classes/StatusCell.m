//
//  StatusCell.m
//  Sabotter
//
//  Created by sugyan on 10/08/25.
//

#import "StatusCell.h"


@implementation StatusCell

@synthesize statusTextLabel;
@synthesize usernameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
