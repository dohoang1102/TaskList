//
//  TaskCustomCell.m
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

#import "TaskCustomCell.h"
#import "Task.h"

@interface TaskCustomCell()

- (void)refreshUI;

@end


@implementation TaskCustomCell
@synthesize tf,segmentedControl;
@synthesize task;
@synthesize delegate;


#pragma mark - memory management

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [tf release];
    [segmentedControl release];
    [task release];
    [super dealloc];
}

#pragma mark - Overriden setters

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setTask:(Task *)aTask
{
    if(task == aTask){
        return;
    }
    
    [task release];
    task = [aTask retain];
    aTask = nil;
    
    [self refreshUI];
}


#pragma mark - private methods

- (void)refreshUI
{
    self.tf.text = [task currentTitle];
}

#pragma mark - CallBacks

- (IBAction)segmentChoosen:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    
    switch (seg.selectedSegmentIndex) {
            
        case 0:
            self.tf.enabled = YES;
            [self.tf becomeFirstResponder];
            break;
            
        case 3:
            [delegate reduceCellForTask:task];
            seg.selectedSegmentIndex = -1;
            break;
            
        case 1:
        case 2:
        default:
            break;
    }
}

#pragma mark - Text Field delegate methods implementation

- (IBAction)textFieldEndedEditing:(id)sender
{
    //resigning the keyboard and notifying the delegate of the changes
    [tf resignFirstResponder];
    
    [task titleChanged:tf.text];
    self.tf.enabled = NO;
    [delegate reduceCellForTask:task];
    
    segmentedControl.selectedSegmentIndex = -1;
}


@end
