//
//  KAGeneralMethods.h
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KAGeneralMethods : NSObject
- (NSString *)takeInputOfLength:(int)length withMessage:(NSString *)message;
- (NSString *)stringFromDate:(NSDate *)date; // get a string from date easily
+ (id)sharedManager; // singleton shared manager method
@end
