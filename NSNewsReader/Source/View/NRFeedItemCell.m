//
//  NRFeedItemCellTableViewCell.m
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#import "NRFeedItemCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NRFeedItemCell()
@property (nonatomic) NRFeedItemCell_ViewModel* viewModel;

@property IBOutlet AsyncImageView* Image;
@property IBOutlet UILabel* Title;
@property IBOutlet UILabel* Summary;
@property IBOutlet UILabel* PublicationDate;

@end

@implementation NRFeedItemCell

- (void)awakeFromNib
{
    self.viewModel = [NRFeedItemCell_ViewModel new];
    RAC(self, Image.imageURL) = RACObserve(self, viewModel.image);
    RAC(self, Title.text) = RACObserve(self, viewModel.title);
    RAC(self, Summary.text) = RACObserve(self, viewModel.summary);
    RAC(self, PublicationDate.text) = RACObserve(self, viewModel.publicationDate);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
