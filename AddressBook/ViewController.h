//
//  ViewController.h
//  AddressBook
//
//  Created by Sinosoft on 9/22/13.
//  Copyright (c) 2013 com.Sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>

@property(strong,nonatomic) UITextView* textView;

@property(strong,nonatomic) ABPeoplePickerNavigationController* picker;

-(IBAction)address:(id)sender;

-(IBAction)jump2Contack:(id)sender;

@end
