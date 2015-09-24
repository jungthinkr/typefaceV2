#import "ListOfFriends.h"
#import <Parse/Parse.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Reachability.h"
#import "Contacts/Contacts.h"
@interface ListOfFriends ()
{
    UIButton *addFriendButton;
    UIButton *sendInviteButton;
    Reachability *internetReachableFoo;
}

@property (weak, nonatomic) IBOutlet UILabel *refresh;
@property (weak, nonatomic) IBOutlet UIButton *syncContacts;
@property (strong, nonatomic) IBOutlet UIButton *addFriend;
@property (strong, nonatomic) IBOutlet UIButton *syncContactsbutton;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong,nonatomic) NSMutableArray *filteredSearchArray;
@property (nonatomic, strong) NSMutableArray *arrContactsData;
@property (nonatomic, strong) NSMutableArray *arrSort;
@property (nonatomic, strong) NSMutableArray *arrNumbers;
@property (nonatomic, strong) NSMutableArray *insideFriends;
@property (nonatomic, strong) NSMutableArray *outsideFriends;
@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *friendsList;
@property (nonatomic, strong) NSMutableArray *test;
@property (nonatomic, strong) NSMutableArray *test2;
@property (nonatomic, strong) NSMutableArray *test3;

//@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;

@end

@implementation ListOfFriends

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllContact];
    NSLog(@"hiii %ld", (long)CNEntityTypeContacts);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //PFUser *currentUser = [PFUser currentUser];
    if ([PFUser currentUser]) {
        NSLog(@"Current user: %@", [PFUser currentUser].username);
        [self ListCheck];
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    _refresh.hidden = YES;

  
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Search bar
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array

    [self.filteredSearchArray removeAllObjects];
    self.filteredSearchArray = [[NSMutableArray alloc] init];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[cd] %@",searchText];
    [self.filteredSearchArray addObjectsFromArray: [_names filteredArrayUsingPredicate:predicate]];
    if (self.filteredSearchArray  == nil) {
        [self.filteredSearchArray addObject: @"hi"];
    }
    NSLog(@"%@", _names);
    NSLog(@"%@", self.filteredSearchArray);
 
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - get Contacts
/*
- (void)syncContacts {

    CFErrorRef *error = NULL;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, error);
    
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
                CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBookRef);
                
                for(int i = 0; i < numberOfPeople; i++) {
                    NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                                            initWithObjects:@[@"", @"", @""]
                                                            forKeys:@[@"firstName", @"lastName", @"number"]];
                    ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
                    // Use a general Core Foundation object.
                    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
                    
                    // Get the first name.
                    if (generalCFObject) {
                        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"firstName"];
                        CFRelease(generalCFObject);
                    }
                    
                    // Get the last name.
                    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
                    if (generalCFObject) {
                        [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"lastName"];
                        CFRelease(generalCFObject);
                    }
                    
                    
                    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
                    
                    for (CFIndex j = 0; j < ABMultiValueGetCount(phoneNumbers); j++) {
                        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phoneNumbers, j);
                        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phoneNumbers, j);
                        
                        if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                            [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                        }
                        
                        else if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                            [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                        }
                        else if (CFStringCompare(currentPhoneLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
                            [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                        }
                        
                        CFRelease(currentPhoneLabel);
                        CFRelease(currentPhoneValue);
                    }
                    CFRelease(phoneNumbers);
                    
                    // Initialize the array if it's not yet initialized.
                    if (_arrContactsData == nil) {
                        _arrContactsData = [[NSMutableArray alloc] init];
                    }
                    if(_arrNumbers == nil) {
                        _arrNumbers = [[NSMutableArray alloc] init];
                    }
                    if(_arrSort == nil) {
                        _arrSort = [[NSMutableArray alloc] init];
                    }
                    if(_names == nil ) {
                        _names = [[NSMutableArray alloc] init];
                    }
                    if ([[contactInfoDict objectForKey:@"firstName"] isEqualToString:@""])
                    {NSLog(@"empty");}
                    else
                    {[_names addObject:[NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]]];
                        
                        [[PFUser currentUser] addUniqueObject:[NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]] forKey: @"names"];
                        [[PFUser currentUser] saveInBackground];
                        // Add the dictionary to the array.
                        
                        [_arrSort addObject:contactInfoDict];
                        [_arrNumbers addObject:[self formatNumber:[contactInfoDict objectForKey:@"number"]]];
                        [[PFUser currentUser] addUniqueObject:[self formatNumber:[contactInfoDict objectForKey:@"number"]] forKey: @"numbersarray"];
                    }
                    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"firstName"
                                                                                 ascending:YES];
                    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortByName];
                    _arrContactsData = [_arrSort sortedArrayUsingDescriptors:sortDescriptors];
                    
                    
                    
                    
                    
                    
                }
                
                [self updateNumbers];
                
                
            } else {
                [self performSegueWithIdentifier:@"showLogin" sender:self];
                //SEND BACK TO LOG IN SCREEN
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBookRef);
        
        for(int i = 0; i < numberOfPeople; i++) {
            NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                                    initWithObjects:@[@"", @"", @""]
                                                    forKeys:@[@"firstName", @"lastName", @"number"]];
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            // Use a general Core Foundation object.
            CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            
            // Get the first name.
            if (generalCFObject) {
                [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"firstName"];
                CFRelease(generalCFObject);
            }
            
            // Get the last name.
            generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
            if (generalCFObject) {
                [contactInfoDict setObject:(__bridge NSString *)generalCFObject forKey:@"lastName"];
                CFRelease(generalCFObject);
            }
            
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for (CFIndex j = 0; j < ABMultiValueGetCount(phoneNumbers); j++) {
                CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phoneNumbers, j);
                CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phoneNumbers, j);
                
                if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                    [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                }
                
                else if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                    [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                }
                else if (CFStringCompare(currentPhoneLabel, kABWorkLabel, 0) == kCFCompareEqualTo) {
                    [contactInfoDict setObject:(__bridge NSString *)currentPhoneValue forKey:@"number"];
                }
                
                CFRelease(currentPhoneLabel);
                CFRelease(currentPhoneValue);
            }
            CFRelease(phoneNumbers);
            // Initialize the array if it's not yet initialized.
            if (_arrContactsData == nil) {
                _arrContactsData = [[NSMutableArray alloc] init];
            }
            if(_arrNumbers == nil) {
                _arrNumbers = [[NSMutableArray alloc] init];
            }
            if(_arrSort == nil) {
                _arrSort = [[NSMutableArray alloc] init];
            }
            if(_names == nil ) {
                _names = [[NSMutableArray alloc] init];
            }
            if ([[contactInfoDict objectForKey:@"firstName"] isEqualToString:@""])
            {NSLog(@"empty");}
            else
            {[_names addObject:[NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]]];
                
                [[PFUser currentUser] addUniqueObject:[NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]] forKey: @"names"];
                [[PFUser currentUser] saveInBackground];
                // Add the dictionary to the array.
                
                [_arrSort addObject:contactInfoDict];
                [_arrNumbers addObject:[self formatNumber:[contactInfoDict objectForKey:@"number"]]];
                [[PFUser currentUser] addUniqueObject:[self formatNumber:[contactInfoDict objectForKey:@"number"]] forKey: @"numbersarray"];
            }
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"firstName"
                                                                         ascending:YES];
            NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObject:sortByName];
            _arrContactsData = [_arrSort sortedArrayUsingDescriptors:sortDescriptors];
            
            
            
        }
        NSLog(@"This is arrNumbers %@", _arrNumbers);
        [self updateNumbers];
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    
    _syncContacts.hidden = YES;
    
    
    
    
    
}
*/



-(void)getAllContact
{

    _test = [[NSMutableArray alloc]init];
    _test2 = [[NSMutableArray alloc]init];
    _test3 = [[NSMutableArray alloc]init];

    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
        [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            NSLog(@"%@", contact);
            NSString *name = [NSString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
            NSString *phone = [NSString string];
            
            for (CNLabeledValue *value in contact.phoneNumbers) {
                
                if ([value.label isEqualToString:@"_$!<Mobile>!$_"])
                {
                    CNPhoneNumber *phoneNum = value.value;
                    phone = phoneNum.stringValue;
                }
                
                if ([phone isEqualToString:@""])
                {
                    if ([value.label isEqualToString:@"_$!<Home>!$_"])
                    {
                    CNPhoneNumber *phoneNum = value.value;
                    phone = phoneNum.stringValue;
                    }
                }
                if ([phone isEqualToString:@""])
                {
                    if ([value.label isEqualToString:@"_$!<Work>!$_"])
                    {
                        CNPhoneNumber *phoneNum = value.value;
                        phone = phoneNum.stringValue;
                    }
                }

            }
            [_test addObject:name];
            [_test2 addObject:phone];
                
        }];
    }
   for(int i = 0; i < _test.count; i++){
        NSMutableDictionary *contactInfoDict = [[NSMutableDictionary alloc]
                                                initWithObjects:@[@"", @""]
                                                forKeys:@[@"name", @"number"]];
        [contactInfoDict setObject:_test[i] forKey: @"name"];
        [contactInfoDict setObject:_test2[i] forKey: @"number"];
        [_test3 addObject: contactInfoDict];
    }
    NSLog(@"%@",_test3);
}




- (IBAction)logout:(id)sender {
    [PFUser logOut];
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier: @"showLogin" sender:self];
    }
    
}



#pragma mark - GET CONTACTS FROM PARSE

- (void)updateNumbers
{
    if (_insideFriends == nil) {
        _insideFriends = [[NSMutableArray alloc] init];
    }
    if(_outsideFriends == nil) {
        _outsideFriends = [[NSMutableArray alloc] init];
    }

    [[PFUser currentUser] unpinInBackground];

    PFQuery *query = [PFUser query];
    [query whereKey:@"username" containedIn:_arrNumbers];

   _insideFriends = [query findObjects];
    [_insideFriends addObject:[PFUser currentUser]];
     NSLog(@"%@", _insideFriends);
    NSUInteger *index = 0;

    for (id data in _arrContactsData)
    {
        NSLog(@"enter for loop");

            if ( [[[_insideFriends objectAtIndex:index] objectForKey:@"username"] isEqualToString: [self formatNumber:[data objectForKey:@"number"]]]) {
            
            [[PFUser currentUser] addUniqueObject:data forKey: @"insideFriends"];
           
            
            /// send push to all inside friends
            // Create our Installation query
            PFQuery *pushQuery = [PFUser query];
            [pushQuery whereKey:@"username" equalTo:[self formatNumber:[data objectForKey:@"number"]]];
            
            // Send push notification to query
            [PFPush sendPushMessageToQueryInBackground:pushQuery
                                           withMessage:@"A Friend joined the app!"];
            index++;
            }
        
            else{
            
            [[PFUser currentUser] addUniqueObject:data forKey: @"outsideFriends"];
            [[PFUser currentUser] saveInBackground];

            [[PFUser currentUser] pinInBackground];
            
            }// end else
        
    } // end for loop
    

    [[PFUser currentUser] saveInBackground];
           dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"begin reload");
        [self.tableView reloadData];
    });
    
    
    [self.refreshControl endRefreshing];
    
    // open up refresh control
    if(self.refreshControl == nil)
    {
        _refresh.hidden = NO;
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor grayColor];
        self.refreshControl.tintColor = [UIColor whiteColor];
        [self.refreshControl addTarget:self
                            action:@selector(syncContacts:)
                  forControlEvents:UIControlEventValueChanged];
    }

}

-(void)ListCheck
{
    PFQuery *query= [PFUser query];
    [query whereKey:@"outsideFriends" equalTo:@0];
    if (query == nil)
    {
        NSLog(@"It is empty");
        
    }
    else
    {
        NSLog(@"It is not empty");
        [self createList];
        _syncContactsbutton.hidden = YES;
    }
}

-(void)createList
{
    PFQuery *query = [PFUser query];
    [query fromLocalDatastore];
    PFObject *user = [query getFirstObject];
    _insideFriends = [user objectForKey: @"insideFriends"];
    _outsideFriends = [user objectForKey:@"outsideFriends"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [self.refreshControl endRefreshing];
    // open up refresh control
    if(self.refreshControl == nil)
    {
        _refresh.hidden = NO;
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.backgroundColor = [UIColor grayColor];
        self.refreshControl.tintColor = [UIColor whiteColor];
        [self.refreshControl addTarget:self
                                action:@selector(syncContacts:)
                      forControlEvents:UIControlEventValueChanged];
    }
  

}

#pragma mark - Hash number
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    
    
 
    
    NSInteger length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        
    }
    
    
    return mobileNumber;
}

#pragma mark - Table View
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
     UILabel* headerLabel = [[UILabel alloc] init];
    if(section == 0)
    {
                headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
                headerLabel.backgroundColor = [UIColor clearColor];
                headerLabel.textColor = [UIColor whiteColor];
                headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
                headerLabel.text = @"Friends Inside";
                headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    headerLabel.text = @"Friends Outside";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    }
    // 3. Add a label

    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
        {
            return [self.filteredSearchArray count];
        }
    
    else{
        if(section == 0)
            {
            return [[PFUser currentUser][@"insideFriends"]  count];
            }

        else
            {
            return [[PFUser currentUser][@"outsideFriends"]  count];
            }
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }

    if(tableView == self.searchDisplayController.searchResultsTableView )
        {
            cell.textLabel.text = [self.filteredSearchArray objectAtIndex:indexPath.row];
            return cell;
        }
    
    else
    {
        NSUInteger section = [indexPath section];
     //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        if(section == 0)
        {
            NSDictionary *contactInfoDict = [[PFUser currentUser][@"insideFriends"] objectAtIndex:indexPath.row];
            NSLog(@"%@", contactInfoDict);
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]];
            // add friend button
            PFQuery *query = [PFQuery queryWithClassName:@"Friends"];
            [query whereKey:@"numbersarray" equalTo:[contactInfoDict objectForKey:@"number"]] ;
            PFObject *oFriend = [query getFirstObject];
         
            PFRelation *relation = [oFriend relationForKey:@"Friendsinside"];
            PFQuery *query2 = [relation query];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    // The find succeeded.
                    NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                    // Do something with the found objects
                    for (PFObject *object in objects) {
                        NSLog(@"%@", object.objectId);
                    }
                } else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            addFriendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            addFriendButton.frame = CGRectMake(213.0f, 5.0f, 100.0f, 30.0f);
            [addFriendButton setTitle:@"Add Friend " forState:UIControlStateNormal];
           // [cell addSubview:addFriendButton];
            /*[addFriendButton addTarget:self
                            action:@selector(addFriend:)
                  forControlEvents:UIControlEventTouchUpInside];*/
      
            return cell;
        }
        
        else // section = 1
        {
           
            
         
            NSDictionary *contactInfoDict = [[PFUser currentUser][@"outsideFriends"] objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [contactInfoDict objectForKey:@"firstName"], [contactInfoDict objectForKey:@"lastName"]];
           
            PFQuery *query = [PFUser query];
            [query whereKey:@"numbersarray" equalTo: [self formatNumber:[contactInfoDict objectForKey:@"number"]]];
            
            [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
                if (!error) {
                    // The count request succeeded. Log the count
                    NSLog(@"Found %d mutual friends ", count);
                    sendInviteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    sendInviteButton.frame = CGRectMake(200, 5.0f, 100.0f, 30.0f);
                    [sendInviteButton setTitle: [NSString stringWithFormat:@"%d Friends",count] forState:UIControlStateNormal];
                    
                    [cell addSubview:sendInviteButton];
                } else {
                    // The request failed
                }
            }];
        
            
           

            return cell;
        }
    }
}



#pragma mark - test connection
- (IBAction)checkinternet:(id)sender {
    
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            break;
            
        case ReachableViaWWAN:
            NSLog(@"We have a 3G connection");
            break;
            
        case ReachableViaWiFi:
            NSLog(@"We have WiFi.");
            break;
            
        default:
            break;
    }
}


@end
