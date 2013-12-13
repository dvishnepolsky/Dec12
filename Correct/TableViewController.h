//
//  TableViewController.h
//  Correct
//
//  Created by dImo on 12/12/13.
//  Copyright (c) 2013 nyuguest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController: UITableViewController <UITextFieldDelegate> {
	NSMutableArray *lines;
	NSString *cellReuseIdentifier;

	//The currenly selected cell (or nil) and its text field.
	NSIndexPath *selected;
	UITextField *textField;
}

@end
