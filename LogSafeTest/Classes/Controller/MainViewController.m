//
//  MainViewController.m
//  LogSafeTest
//
//  Created by Clément Rousselle on 4/30/12.
//  Copyright (c) 2012. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "MainViewController.h"
#import "Task.h"


#define CUSTOM_CELL_ID @"TaskCustomCell"

static const float kShowButtonHeight = 26.0;
static const float kCellHeight = 50.0;





@interface MainViewController()

@property (nonatomic, retain) NSMutableArray *itemsArray;
@property (nonatomic, retain) TaskCustomCell *loadedCell;
@property (nonatomic, retain) NSMutableDictionary *selectedIndexes;

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;

@end






@implementation MainViewController
@synthesize table;
@synthesize addButton;
@synthesize editButton;
@synthesize actionsView;
@synthesize itemsArray;
@synthesize loadedCell;
@synthesize selectedIndexes;

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [table release];
    [itemsArray release];
    [addButton release];
    [editButton release];
    [actionsView release];
    [loadedCell release];
    [selectedIndexes release];
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"MainViewController.title", nil);
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    itemsArray = [[NSMutableArray alloc]init];
    selectedIndexes = [[NSMutableDictionary alloc] init];
    
    //add some items to simulate already present tasks
    Task *first = [[Task alloc]initWithId:[itemsArray count] title:@"The first task of the list"];
    [itemsArray addObject:first];
    [first release];
    
    Task *second = [[Task alloc]initWithId:[itemsArray count] title:@"The second task of the list"];
    [itemsArray addObject:second];
    [second release];
    
    Task *third = [[Task alloc]initWithId:[itemsArray count] title:@"The third task of the list"];
    [itemsArray addObject:third];
    [third release];
    
    //placing the action view
    
    //taking count of the status bar & nav bar to place the subview
    CGFloat actionY = 460.0 - 44.0 - kShowButtonHeight;
    self.actionsView.frame = CGRectMake(0.0 ,  actionY , 320.0, 80.0);
    addButton.layer.cornerRadius = 4.0;
    editButton.layer.cornerRadius = 4.0;
    addButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    editButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    addButton.layer.borderWidth = 1.0;
    editButton.layer.borderWidth = 1.0;
    
    [self.view addSubview:actionsView];
    [self.view bringSubviewToFront:actionsView];
    
    //hiding table separators for empty cells
    UIView *footer =
    [[UIView alloc] initWithFrame:CGRectZero];
    self.table.tableFooterView = footer;
    [footer release];
    
}

- (void)viewDidUnload
{
    self.table = nil;
    self.itemsArray = nil;
    self.addButton = nil;
    self.editButton = nil;
    self.actionsView = nil;
    self.loadedCell = nil;
    self.selectedIndexes = nil;
    [super viewDidUnload];
}

#pragma mark - Table View Data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	if([self cellIsSelected:indexPath]) {
		return kCellHeight * 2.0;
	}
	
	// Cell isn't selected so return single height
	return kCellHeight;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskCustomCell *cell = (TaskCustomCell *) [tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL_ID];
    
	if(cell == nil)
	{
		[[NSBundle mainBundle]loadNibNamed:CUSTOM_CELL_ID owner:self options:nil];
		
		cell= [loadedCell retain];
		self.loadedCell =nil;
		[cell autorelease];
	}
    cell.delegate = self;
    cell.task = [itemsArray objectAtIndex:indexPath.row];
    
    return cell;
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//avoid edit the cell while making treatment on it
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ![self cellIsSelected:indexPath];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *tmp = [NSMutableArray arrayWithArray:itemsArray];
        [tmp removeObjectAtIndex:indexPath.row];
        self.itemsArray = tmp;
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if(fromIndexPath.row == toIndexPath.row){
        return ;
    }
    
    //reordering 
    NSString *originValue = [self.itemsArray objectAtIndex:fromIndexPath.row];
    
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.itemsArray];
    [tmp removeObjectAtIndex:fromIndexPath.row];
    [tmp insertObject:originValue atIndex:toIndexPath.row];
    self.itemsArray = tmp;

}

#pragma mark - Table View Delegate methods implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Deselect cell
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
	// Toggle 'selected' state
	BOOL isSelected = ![self cellIsSelected:indexPath];
	
	// Store cell 'selected' state keyed on indexPath
	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedIndexes setObject:selectedIndex forKey:indexPath];	
    
	//updating table view cells height
	[table beginUpdates];
	[table endUpdates];
}



#pragma mark - callbacks

- (IBAction)showTouched:(id)sender {
    
    UIButton *showButton = (UIButton *)sender;
    
    //showing
    if(!showButton.selected){
        CGRect frame = actionsView.frame;
        frame.origin.y -= (actionsView.frame.size.height - kShowButtonHeight);
        
        [UIView animateWithDuration:0.5 animations:^{
            actionsView.frame = frame;
        }];
    }
    //hiding
    else {
        CGRect frame = actionsView.frame;
        frame.origin.y += (actionsView.frame.size.height - kShowButtonHeight);
        
        [UIView animateWithDuration:0.5 animations:^{
            actionsView.frame = frame;
        }];

    }
    
    showButton.selected = !showButton.selected;
}

- (IBAction)editTouched:(id)sender {
    UIBarButtonItem *doneItem = [[[UIBarButtonItem alloc]initWithTitle:@"Edit Done" style:UIBarButtonItemStyleDone target:self action:@selector(editDoneTouched)]autorelease];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    [self.table setEditing:!table.editing animated:YES];
    
    if(!table.editing){
        self.navigationItem.rightBarButtonItem =  nil;
    }
}

- (IBAction)addTouched:(id)sender {
    
    AddViewController *addVC = [[AddViewController alloc]init];
    addVC.delegate = self;
    [self.navigationController pushViewController:addVC animated:YES];
    [addVC release];
    
}

- (void)editDoneTouched
{
    self.editButton.enabled = YES;
    [self.table setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = nil;
} 

#pragma mark - Add VC delegate method implementation

- (void)taskAdded:(Task *)t
{
    [self.itemsArray addObject:t];
    [table reloadData];
}

- (NSUInteger)currentTaskID
{
    return [itemsArray count] + 1;
}

#pragma mark - Custom delegate method implementation

- (void)reduceCellForTask:(Task *)task
{
    Task *t = nil;
    for (int i = 0; i < [itemsArray count] ; i++) {
        t = [itemsArray objectAtIndex:i];
        if([task currentId] == [t currentId]){
            //updating the selected state
            NSNumber *selectedIndex = [NSNumber numberWithBool:NO];
            [selectedIndexes setObject:selectedIndex forKey:[NSIndexPath indexPathForRow:i inSection:0]];
            [table beginUpdates];
            [table endUpdates];
            break;
        }
    }
}

#pragma mark - Cell resize stuff

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

@end
