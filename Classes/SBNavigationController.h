//
//  SBNavigationController.h
//  Sabotter
//
//  Created by sugyan on 09/12/20.
//

#import <UIKit/UIKit.h>
#import "SBTimelineViewController.h"


@interface SBNavigationController : UINavigationController {
    IBOutlet SBTimelineViewController *timelineViewController;
}

@property (retain, nonatomic) SBTimelineViewController *timelineViewController;

@end
