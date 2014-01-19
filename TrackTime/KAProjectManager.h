//
//  KAProjectManager.h
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KAProjectManager : NSObject
+ (id)sharedManager; // Gets the shared instance

- (NSArray *)projects; // All projects currently created
- (BOOL)addNewProject:(NSString *)projectName; // Add a new project with name: returns if successful or not (will fail if user tries to enter same

- (double)getCurrentHoursFromProjectNamed:(NSString *)projectNamed; // Get current amount of hours
- (void)addHoursToProjectName:(NSString *)name withHours:(double)hours; // Add hours to a project
- (void)removeProjectNamed:(NSString *)projectNamed; // Delete a project
- (void)removeAllProjects; // Removes all current Projects

// For live time tracking
- (void)startTimeWithProjectName:(NSString *)projectName; // Start tracking time
- (double)stopTimeWithProjectName:(NSString *)projectName; // Returns (in hours) what was just added

@end
