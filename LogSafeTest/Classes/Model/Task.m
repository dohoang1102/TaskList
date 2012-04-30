//
//  Task.m
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

#import "Task.h"

@interface Task()

@property (nonatomic, assign) NSUInteger taskID;
@property (nonatomic, retain) NSString *taskTitle;

@end

@implementation Task
@synthesize taskTitle, taskID;

#pragma mark memory management

- (id)initWithId:(NSUInteger)newID title:(NSString *)title
{
    self = [self init];
    
    if(self){
        self.taskID = newID;
        self.taskTitle = title;
    }
    
    return self;
}

- (void)dealloc
{
    [taskTitle release];
    [super dealloc];
}

#pragma public methods implementation

- (void)titleChanged:(NSString *)newTitle
{
    self.taskTitle = newTitle;
}

- (NSString *)currentTitle
{
    return taskTitle;
}

- (NSUInteger)currentId
{
    return taskID;
}


@end
