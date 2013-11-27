//
//  KAProjectManager.h
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KAProjectManager : NSObject
+ (id)sharedManager; // use this shared manager
- (NSArray *)projects; // all projects currently created
- (BOOL)addNewProject:(NSString *)projectName; // add a new project with name: returns if successful or not (will fail if user tries to enter same

- (double)getCurrentHoursFromProjectNamed:(NSString *)projectNamed; // get current amount of hours
- (void)addHoursToProjectName:(NSString *)name withHours:(double)hours; //add hours to a project
- (void)removeProjectNamed:(NSString *)projectNamed; // delete a project


// for live time tracking
- (void)startTimeWithProjectName:(NSString *)projectName; // start tracking time
- (double)stopTimeWithProjectName:(NSString *)projectName; //returns (in hours) what was just added
@end
