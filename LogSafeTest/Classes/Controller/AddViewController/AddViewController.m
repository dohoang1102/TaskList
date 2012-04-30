//
//  AddViewController.m
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012 Hot Apps Factroy. All rights reserved.
//

#import "AddViewController.h"
#import "Task.h"

@implementation AddViewController
{
    NSUInteger currentID;
}

@synthesize numberLabel;
@synthesize textField;
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [numberLabel release];
    [textField release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title  = NSLocalizedString(@"AddViewController.title", nil);

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addTouched)]autorelease];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.textField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    currentID = [delegate currentTaskID];
    self.numberLabel.text = [NSString stringWithFormat:NSLocalizedString(@"AddViewController.idText", nil), currentID];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setNumberLabel:nil];
    [self setTextField:nil];
}

- (void)addTouched
{
    [delegate taskAdded:[[[Task alloc]initWithId:currentID title:self.textField.text]autorelease]];
    
    //back to previous controller
    [textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textDidChanged:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = ![textField.text isEqualToString:@""];
}

@end
