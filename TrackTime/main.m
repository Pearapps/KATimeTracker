//
//  main.m
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KAGeneralMethods.h"
#import "KATrackTime.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
       [[[KATrackTime alloc] init] start];
    }
    return 0;
}

