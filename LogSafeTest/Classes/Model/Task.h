//
//  Task.h
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//


@interface Task : NSObject

- (id)initWithId:(NSUInteger)newID title:(NSString *)title;

- (void)titleChanged:(NSString *)newTitle;
- (NSString *)currentTitle;

- (NSUInteger)currentId;

@end
