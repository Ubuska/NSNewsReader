//
//  NRFeedItemCellTableViewCell.h
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface NRFeedItemCell : UITableViewCell

@property IBOutlet AsyncImageView* Image;
@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Summary;
@property IBOutlet UILabel* PublicationDate;

@end
