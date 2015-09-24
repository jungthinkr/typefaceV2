

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface enterNumberViewController : UIViewController <UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)LogIn:(id)sender;
- (IBAction)enterCode:(id)sender;
- (IBAction)backButton:(id)sender;

@end
