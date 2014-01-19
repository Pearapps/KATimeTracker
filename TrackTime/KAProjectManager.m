//
//  KAProjectManager.m
//  TrackTime
//
//  Created by Kenneth Parker Ackerson on 11/26/13.
//  Copyright (c) 2013 Kenneth Parker Ackerson. All rights reserved.
//

#import "KAProjectManager.h"

@implementation KAProjectManager

+ (id)sharedManager {
    static KAProjectManager * shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (BOOL)addNewProject:(NSString *)projectName {
    if ([self getDictionaryAssociatedWithName:projectName]) {
        return NO;
    }
    NSMutableArray * array = [self projects].mutableCopy;
    [array addObject:[self createDictionaryWithProjectName:projectName andSeconds:@(0.0) andSecondsSince:@(0.0)]];
    [self setProjects:array];
    return YES;
}

- (void)addHoursToProjectName:(NSString *)name withHours:(double)hours {
    
    NSMutableArray * projects = [self projects].mutableCopy;

    NSDictionary * dict = [self getDictionaryAssociatedWithName:name];

    double currentSeconds = [(NSNumber *)dict[@"seconds"] doubleValue] + (hours * 3600);
    NSInteger i = [projects indexOfObject:dict];
    [projects removeObject:dict];
    [projects insertObject:[self createDictionaryWithProjectName:name andSeconds:@(currentSeconds) andSecondsSince:@(0.0)] atIndex:i];
    
    [self setProjects:projects];
}

- (NSArray *)projects {
    NSArray * projects= [[NSUserDefaults standardUserDefaults] objectForKey:@"Projects"];
    if (!projects) {
        projects = @[];
        [[NSUserDefaults standardUserDefaults] setObject:projects forKey:@"Projects"];
    }
    return projects;
}

- (void)setProjects:(NSArray *)projects {
    [[NSUserDefaults standardUserDefaults] setObject:projects forKey:@"Projects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (double)getCurrentHoursFromProjectNamed:(NSString *)projectNamed {
    NSDictionary * dict = [self getDictionaryAssociatedWithName:projectNamed];
    double currentSeconds = [(NSNumber *)dict[@"seconds"] doubleValue];
    return currentSeconds/3600.f;
}

- (NSDictionary *)getDictionaryAssociatedWithName:(NSString *)projectNamed {
    NSMutableArray * projects = [self projects].mutableCopy;
    for (NSDictionary * dict in projects) {
        if ([dict[@"name"] isEqualToString:projectNamed]) {
            return dict;
        }
    }
    return nil;
}

- (void)removeAllProjects {
    [self setProjects:@[]];

}

- (void)removeProjectNamed:(NSString *)projectNamed {
    NSDictionary * dict = [self getDictionaryAssociatedWithName:projectNamed];
    if (dict) {
        NSMutableArray * projects = [self projects].mutableCopy;
        [projects removeObject:dict];
        [self setProjects:projects];
    }
}

- (double)stopTimeWithProjectName:(NSString *)projectName {
    NSDictionary * dict = [self getDictionaryAssociatedWithName:projectName];
    if (dict) {
        NSNumber * secondsSince = dict[@"secondsSince"];
        double currentSeconds = [(NSNumber *)dict[@"seconds"] doubleValue];
        NSNumber * newSecondsToAdd = @([[NSDate date] timeIntervalSince1970] - [secondsSince doubleValue]);
        NSDictionary * newdict = [self createDictionaryWithProjectName:projectName andSeconds:@(currentSeconds+[newSecondsToAdd doubleValue]) andSecondsSince:@(0.0)];
        NSMutableArray * projects = [[self projects] mutableCopy];
        NSInteger i = [projects indexOfObject:dict];
        [projects removeObject:dict];
        [projects insertObject:newdict atIndex:i];
        [self setProjects:projects];
        return [newSecondsToAdd doubleValue]/3600;
    }
    return 0.0;
}

- (void)startTimeWithProjectName:(NSString *)projectName {
    NSDictionary * dict = [self getDictionaryAssociatedWithName:projectName];
    if (dict) {
        NSMutableDictionary * newDict = [[self createDictionaryWithProjectName:dict[@"name"] andSeconds:dict[@"seconds"] andSecondsSince:@([[NSDate date] timeIntervalSince1970])] mutableCopy];
        NSMutableArray * projects = [[self projects] mutableCopy];
        NSInteger i = [projects indexOfObject:dict];
        [projects removeObject:dict];
        [projects insertObject:newDict atIndex:i];
        [self setProjects:projects];
    }

}

#pragma mark Private

- (NSDictionary *)createDictionaryWithProjectName:(NSString *)projectName andSeconds:(NSNumber *)seconds andSecondsSince:(NSNumber *)secondsSince { // NSDictionary will automatically make sure that you can't put anything nil here.
    return @{@"name": projectName, @"seconds" : seconds, @"secondsSince" : secondsSince};
}

@end
