//
//  StatusCellViewController.h
//  Sabotter
//
//  Created by sugyan on 10/08/31.
//

#import <UIKit/UIKit.h>
#import "StatusCell.h"


@interface StatusCellViewController : UIViewController {
    IBOutlet StatusCell *cell;
}

@property (nonatomic, retain) StatusCell *cell;

@end
