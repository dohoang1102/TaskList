//
//  TaskCustomCell.h
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

@class Task;

@protocol TaskCustomCellDelegate;


@interface TaskCustomCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *tf;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, retain) Task *task;

@property (nonatomic, assign) id<TaskCustomCellDelegate> delegate;

- (IBAction)segmentChoosen:(id)sender;
- (IBAction)textFieldEndedEditing:(id)sender;

@end



@protocol TaskCustomCellDelegate <NSObject>

- (void)reduceCellForTask:(Task *)task;

@end
