//
//  NRFavoriteFeedCell.h
//  NSNewsReader
//
//  Created by Peter Gubin on 06.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NRFavoriteFeedCell : UITableViewCell

@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Summary;
@property IBOutlet UIButton* FavoriteButton;
@end
