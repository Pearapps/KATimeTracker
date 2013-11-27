//
//  NSString+KAStringMethods.m
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "NSString+KAStringMethods.h"

@implementation NSString (KAStringMethods)

- (BOOL)isEqualToArrayAnyOfTheseStrings:(NSArray *)array{
    for (NSString * string in array){
        if ([self isEqualToString:string]){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isEqualToStringAndLower:(NSString *)string{
    return [self isEqualToArrayAnyOfTheseStrings:@[string, [string lowercaseString]]];
}
@end
