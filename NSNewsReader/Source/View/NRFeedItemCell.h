//
//  NRFeedItemCellTableViewCell.h
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "NRFeedItemCell-ViewModel.h"

@interface NRFeedItemCell : UITableViewCell

@property (nonatomic, readonly) NRFeedItemCell_ViewModel* viewModel;


@end
