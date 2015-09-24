
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Parse/Parse.h>
#import "enterNumberViewController.h"
@interface ListOfFriends : UITableViewController <ABPeoplePickerNavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate>

//- (IBAction)syncContacts:(id)sender;
- (IBAction)logout:(id)sender;


- (IBAction)checkinternet:(id)sender;


@property (nonatomic, strong) PFObject *friend;
@end
