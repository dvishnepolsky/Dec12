//
//  TableViewController.m
//  Correct
//
//  Created by dImo on 12/12/13.
//  Copyright (c) 2013 nyuguest. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@end

@implementation TableViewController

- (id) initWithStyle: (UITableViewStyle) style
{
	self = [super initWithStyle: style];
	if (self) {
		// Custom initialization
		lines = [NSMutableArray arrayWithObjects:
			@"Mondya",
			@"wynter",
			@"greatful",
			@"harrass",
			@"indispensible",
			@"noticeable",
			@"seperate",
			@"supercede",
			@"untill",
			@"wierd",
			nil
		];
		cellReuseIdentifier = @"correct";
	}
	return self;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass: [UITableViewCell class]
		forCellReuseIdentifier: cellReuseIdentifier];

	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
	// Return the number of rows in the section.
	return lines.count;
}

- (UITableViewCell *) tableView: (UITableView * )tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
	UITableViewCell *cell =
	[tableView dequeueReusableCellWithIdentifier: cellReuseIdentifier forIndexPath: indexPath];

	// Configure the cell...
	cell.textLabel.text = [lines objectAtIndex: indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    reloadRowsAtIndexPaths:withRowAnimation:
	return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL) tableView: (UITableView *) tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return YES;
}
*/

/*
// Override to support editing the table view.
- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *) indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
		[tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationFade];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
}
*/

/*
// Override to support rearranging the table view.
- (void) tableView: (UITableView *) tableView moveRowAtIndexPath: (NSIndexPath *) fromIndexPath toIndexPath: (NSIndexPath *) toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL) tableView: (UITableView *) tableView canMoveRowAtIndexPath: (NSIndexPath *) indexPath
{
	// Return NO if you do not want the item to be re-orderable.
	return YES;
}
*/

#pragma mark - Table view delegate

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
	if (selected) {
		//Arrive here if user was already editing one cell and then touched another.
		//Stop editing the first cell before we begin to edit the second one.
		[self textFieldShouldReturn: textField];
		[self textFieldDidEndEditing: textField];
	}
	selected = indexPath;
	
	//Add a UITextField to the selected cell.
	//The initial text of the text field must coincide with the text of the textLabel.
	UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
	UIFont *font = cell.textLabel.font;
	CGFloat dy = (cell.contentView.bounds.size.height - font.lineHeight) / 2;
	
	CGRect frame = CGRectMake(
		cell.textLabel.frame.origin.x,
		cell.textLabel.frame.origin.y + dy,
		cell.contentView.bounds.size.width,
		cell.contentView.bounds.size.height - dy
	);
	
	textField = [[UITextField alloc] initWithFrame: frame];
	textField.delegate = self;
	textField.backgroundColor = cell.textLabel.backgroundColor;
	textField.textColor = cell.textLabel.textColor;
	textField.text = cell.textLabel.text;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	cell.textLabel.text = @" ";
	textField.font = font;
	[cell.contentView addSubview: textField];
	[textField becomeFirstResponder];   //show the keyboard
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
}

#pragma mark -
#pragma mark protocol UITextFieldDelegate

//Called when return key is pressed, or when user starts editing a different cell.
//Decide if the app should accept this input and hide the keyboard.

- (BOOL) textFieldShouldReturn: (UITextField *) t
{
	[t resignFirstResponder];	//Hide keyboard.
	return YES;	//The text field should do its default behavior.
}

//Called when keyboard is hidden.
//Process the text that was input.

- (void) textFieldDidEndEditing: (UITextField *) t
{
	[lines replaceObjectAtIndex: selected.row withObject: t.text];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: selected];
	cell.textLabel.text = t.text;
	[t removeFromSuperview];
	selected = nil;
	textField = nil;
}


@end
