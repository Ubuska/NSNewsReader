// Quickly look for <feed> or <RSS> tags.
// If it finds technology-specific tag, it breaks parsing and notify ValidatoResponderDelegate.

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "NRAbstractParser.h"

@interface NRFormatValidator : NRAbstractParser

@property id<ValidatorResponder> ValidatorResponderDelegate;

@end
