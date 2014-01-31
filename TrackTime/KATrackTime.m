//
//  KATrackTime.m
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KATrackTime.h"
#import "KAGeneralMethods.h"
#import "KAProjectManager.h"
#define tempProjectName @"g5tZb259U6FjzAaMRnKwetfs"
@implementation KATrackTime

- (void)start {
    [self mainMenu];
}

- (void)mainMenu{
    printf("\n\nMain Menu: \nA: Add new project\nB: Select current project\nC: Just track time\nQ: Quit\n");
    NSString * input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@""];
    while (![input isEqualToStringAndLower:@"Q"]) {
        if ([input isEqualToStringAndLower:@"B"]) {
            [self selectCurrentProject];
        } else if ([input isEqualToStringAndLower:@"A"]) {
            [self addNewProject];
        } else if ([input isEqualToStringAndLower:@"C"]) {
            [[KAProjectManager sharedManager] addNewProject:tempProjectName];
            [self startTime:tempProjectName];
            [[KAProjectManager sharedManager] removeProjectNamed:tempProjectName];
        }
        
        printf("\n\nMain Menu: \nA: Add new project\nB: Select current project\nC: Just track time\nQ: Quit\n");
        input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@""];
    }
    
}
- (void)selectCurrentProject{
    
    NSString * input = @"";
    do {
        NSArray * projects = [[KAProjectManager sharedManager] projects];
        if (projects.count == 0){
            printf("\n\nNo Current Projects");
            return;
        }
        printf("\n\nCurrent Projects: \n");
        
        for (long i  = 0; i < projects.count; i++){
            NSDictionary * dict = projects[i];
            printf("%ld. %s\n", i+1, [(NSString *)dict[@"name"] UTF8String]);
        }
        input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@"\nInput number of project you wish to open (Q to go back or D to delete all): "];
        while (!([input rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) || [input integerValue] > projects.count) {
            if ([input isEqualToStringAndLower:@"Q"]){
                return;
            } else if ([input isEqualToStringAndLower:@"D"]) {
                [[KAProjectManager sharedManager] removeAllProjects];
                printf("\nSuccess!\n");
                return;
            }
            printf("\nInvalid Input\n");
            input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@"\nInput number of project you wish to open (or Q to go back): "];
        }
        [self editingProject:projects[[input integerValue]-1][@"name"]];
        
    } while (true);
}
- (void)addNewProject{
    NSString * input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@"\nEnter new project name: "];
    if (input.length > 0 && ![input isEqualToAnyOfTheseStrings:@[tempProjectName]] && [[KAProjectManager sharedManager] addNewProject:input]){
        printf("\nSuccess!\n");
    }else{
        printf("\nFailed!\n");
    }
}

- (void)editingProject:(NSString *)projectname {
    NSString * input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:[NSString stringWithFormat:@"\n\nEditing Project \"%@\": \nA: Show current hours\nB: Add hours manually\nC: *Start Time*\nD: Delete\nE: Back\n", projectname]];
    while (true) {
        if ([input isEqualToStringAndLower:@"B"]) {
            input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@"\nEnter hours:\n"];
            while (!([input rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"1234567890."] invertedSet]].location == NSNotFound)) {
                input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:@"\nEnter hours:\n"];
            }
            [[KAProjectManager sharedManager] addHoursToProjectName:projectname withHours:[input doubleValue]];
        } else if ([input isEqualToStringAndLower:@"A"]) {
            printf("\nCurrent hours %f\n", [[KAProjectManager sharedManager] getCurrentHoursFromProjectNamed:projectname]);
        } else if ([input isEqualToStringAndLower:@"C"]) {
            [self startTime:projectname];
        } else if ([input isEqualToStringAndLower:@"D"]) {
            [[KAProjectManager sharedManager] removeProjectNamed:projectname];
            return;
        } else if ([input isEqualToStringAndLower:@"E"]) {
            return;
        }
        input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:[NSString stringWithFormat:@"\n\nEditing Project \"%@\": \nA: Show current hours\nB: Add hours manually\nC: *Start Time*\nD: Delete\nE: Back\n", projectname]];
    }
}
- (void)startTime:(NSString *)projectName {
    while (true) {
        [[KAProjectManager sharedManager] startTimeWithProjectName:projectName];
        
        NSString * input = nil;
        
        if ([projectName isEqualToAnyOfTheseStrings:@[tempProjectName]]) {
            input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:[NSString stringWithFormat:@"\n\nStarting Time At: %@: P: Pause, D (or any other character): Done\n",[[KAGeneralMethods sharedManager] stringFromDate:[NSDate date]]]];
        } else {
            input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:[NSString stringWithFormat:@"\n\nStarting Time On \"%@\" at time: %@: P: Pause, D (or any other character): Done\n", projectName,[[KAGeneralMethods sharedManager] stringFromDate:[NSDate date]]]];
        }
        
        
       if ([input isEqualToStringAndLower:@"P"]) {
            [[KAProjectManager sharedManager] stopTimeWithProjectName:projectName];
            while (true) {
                input = [[KAGeneralMethods sharedManager] takeInputOfLength:50 withMessage:[NSString stringWithFormat:@"\n\nPAUSED: Press R to resume"]];
                if ([input isEqualToStringAndLower:@"R"]) {
                    break;
                }
            }
        } else {
           double hoursAdded = [[KAProjectManager sharedManager] stopTimeWithProjectName:projectName];
           printf("\nEnded at %s with %f Hours added\n", [[[KAGeneralMethods sharedManager] stringFromDate:[NSDate date]] UTF8String], hoursAdded);
           return;
        }
    }
}

@end
