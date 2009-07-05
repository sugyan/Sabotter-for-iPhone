#import "SBStatusCell.h"
#import "SBIconRepository.h"


@implementation SBStatusCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
        UIView *contentView = [self contentView];

        CGRect nameFrame = CGRectMake(2, 2, 294, 16);
        CGRect textFrame = CGRectMake(52, 20, 244, 48);
        CGRect serviceFrame = CGRectMake(2, 70, 48, 12);
        CGRect dateFrame = CGRectMake(52, 70, 244, 12);
        CGRect favoritedFrame = CGRectMake(52, 70, 244, 12);
        CGRect iconFrame = CGRectMake(2, 20, 48, 48);
        
        userName = [[[UILabel alloc] initWithFrame:nameFrame] autorelease];
        [userName setFont:[UIFont boldSystemFontOfSize:13.0]];
        [userName setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:userName];

        text = [[[UILabel alloc] initWithFrame:textFrame] autorelease];
        [text setFont:[UIFont systemFontOfSize:13.0]];
        [text setNumberOfLines:3];
        [text setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:text];

        service = [[[UILabel alloc] initWithFrame:serviceFrame] autorelease];
        [service setFont:[UIFont systemFontOfSize:12.0]];
        [service setTextAlignment:UITextAlignmentCenter];
        [service setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:service];

        date = [[[UILabel alloc] initWithFrame:dateFrame] autorelease];
        [date setFont:[UIFont italicSystemFontOfSize:12.0]];
        [date setTextColor:[UIColor darkGrayColor]];
        [date setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:date];

        favorited = [[[UILabel alloc] initWithFrame:favoritedFrame] autorelease];
        [favorited setFont:[UIFont italicSystemFontOfSize:12.0]];
        [favorited setTextAlignment:UITextAlignmentRight];
        [favorited setTextColor:[UIColor orangeColor]];
        [favorited setBackgroundColor:[UIColor clearColor]];
        [contentView addSubview:favorited];

        icon = [[[UIImageView alloc] initWithFrame:iconFrame] autorelease];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [contentView addSubview:icon];

        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return self;
}

- (void)updateWithStatus:(SBStatus *)status {
    [userName setText:[NSString stringWithFormat:@"%@(%@)", [status screenName], [status loginId]]];
    NSMutableString *textStr = [NSMutableString stringWithCapacity:64];
    if (([status service] == SERVICE_WASSR) && !([[status replyId] isEqualToString:@""])) {
        [textStr appendString:[NSString stringWithFormat:@"> %@\n", [status replyId]]];
    }
    [textStr appendString:[status text]];
    [text setText:textStr];
    switch ([status service]) {
    case SERVICE_TWITTER:
        [service setText:@"Twitter"];
        [[self contentView] setBackgroundColor:[UIColor colorWithRed:51.0/255.0 green:204.0/255.0 blue:1.0 alpha:0.1]];
        break;
    case SERVICE_WASSR:
        [service setText:@"Wassr"];
        [[self contentView] setBackgroundColor:[UIColor colorWithRed:63.0/255.0 green:149.0/255.0 blue:0.0 alpha:0.1]];
        break;
    default:
        break;
    }
    [date setText:[formatter stringFromDate:[status dateTime]]];
    if ([status favorited]) {
        [favorited setText:@"★"];
    } else {
        [favorited setText:@""];
    }

    SBIconContainer *container = [[SBIconRepository instance] containerForUrl:[status iconUrl]];
    [icon setImage:[container image]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [formatter release];
    [super dealloc];
}


@end
