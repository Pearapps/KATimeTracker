//
//  KAGeneralMethods.m
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAGeneralMethods.h"

@implementation KAGeneralMethods
+ (id)sharedManager {
    static KAGeneralMethods * shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSString *)takeInputOfLength:(int)length withMessage:(NSString *)message{
        char * str = malloc(sizeof(char) * length);
        for (int i = 0; i < length; i++){
            str[i] = 0;
        }
        printf("%s",message.UTF8String);
        scanf("%s", str);
        free(str);
        return [NSString stringWithUTF8String:str];
}
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
@end
