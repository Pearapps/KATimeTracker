//
//  NSString+KAStringMethods.h
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KAStringMethods)
- (BOOL)isEqualToAnyOfTheseStrings:(NSArray *)array;
- (BOOL)isEqualToStringAndLower:(NSString *)string;
@end
