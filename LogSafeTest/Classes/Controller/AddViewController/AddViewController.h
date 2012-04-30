//
//  AddViewController.h
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

@protocol AddViewControllerDelegate;

@class Task;

@interface AddViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, assign) id<AddViewControllerDelegate> delegate;

- (IBAction)textDidChanged:(id)sender;

@end


@protocol AddViewControllerDelegate <NSObject>

- (void)taskAdded:(Task *)t;
- (NSUInteger)currentTaskID;

@end