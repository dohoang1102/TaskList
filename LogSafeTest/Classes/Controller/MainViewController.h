//
//  MainViewController.h
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "AddViewController.h"
#import "TaskCustomCell.h"

@interface MainViewController : UIViewController <AddViewControllerDelegate, TaskCustomCellDelegate>
{
    IBOutlet TaskCustomCell *loadedCell;
}

@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIButton *addButton;
@property (retain, nonatomic) IBOutlet UIButton *editButton;

@property (retain, nonatomic) IBOutlet UIView *actionsView;

- (IBAction)showTouched:(id)sender;
- (IBAction)editTouched:(id)sender;
- (IBAction)addTouched:(id)sender;
@end
