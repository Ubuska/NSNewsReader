//
//  Protocols.h
//  NSNewsReader
//
//  Created by Peter Gubin on 05.09.15.
//  Copyright (c) 2015 Peter Gubin. All rights reserved.
//

#ifndef NSNewsReader_Protocols_h
#define NSNewsReader_Protocols_h
#import "NRFeed.h"

@protocol UpdateView <NSObject>
- (void) UpdateView;
@end

@protocol ParserResponder <NSObject>
- (void) ParserSucceded;
- (void) ParserFailed;
@end

@protocol ValidatorResponder <NSObject>
- (void) ValidationCompleted:(NSString*) XMLDataType Data:(NSData*)Data Feed:(NRFeed*)Feed;
@end

@protocol FeedBrowserTabController <NSObject>
- (void) EditPressed;
- (void) TabItemPressed;
@end


@protocol DownloadProgressHandler <NSObject>
- (void) DownloadProgress:(float)Progress;
- (void) DownloadFinished;
@end
#endif
