//
//  AddEditBatteryViewController.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "AddEditBatteryViewController.h"
#import "MessageCenter.h"
#import "BatteryGuardianAppDelegate.h"
#import "BatteryInfo.h"
#import "AllBatteriesViewController.h"

@interface AddEditBatteryViewController ()

@property (weak, nonatomic) UITextField *txtBatteryName;
@property (weak, nonatomic) UITextField *txtBatteryDesc;
@property (weak, nonatomic) UILabel *lblLastTimeCharged;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;


@end

@implementation AddEditBatteryViewController



-(void) viewDidLoad
{
    [super viewDidLoad];
        
    //Set the value passed from the previous view
    self.txtBatteryName.text = self.batteryName;
    
    //create a fetch request for the batteryinfo for the selected item
//    BatteryGuardianAppDelegate *del = [BatteryGuardianAppDelegate sharedAppDelegate];
    
    if(self.isAdd)
    {
        self.txtBatteryName.enabled = YES;
        self.lblLastTimeCharged.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    }else
    {
        NSManagedObjectContext *context = [[BatteryGuardianContext alloc] init].managedObjectContext;
    
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BatteryInfo"     inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",self.batteryName];
        [fetchRequest setPredicate:predicate];
        [fetchRequest setEntity:entity];
    
        //execute the fetch
        NSError *err;
        NSArray *batteryInfos = [context executeFetchRequest:fetchRequest error:&err];
        for(BatteryInfo *bi in batteryInfos)
        {
            self.lblLastTimeCharged.text = [NSString stringWithFormat:@"%@",bi.lastChargedDate];
            self.txtBatteryDesc.text = bi.batteryDescription;
        }
    }
    [self registerForKeyboardNotifications];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(self.txtBatteryDesc == textField)
        [self.txtBatteryDesc resignFirstResponder];
    if(self.txtBatteryName == textField)
        [self.txtBatteryDesc becomeFirstResponder];
    return YES;
}

- (IBAction)cmdSave_Clicked:(id)sender 
{
    //Get the context to perform either an update or a add
    BatteryGuardianContext *bGContext = [[BatteryGuardianContext alloc] init];
    NSManagedObjectContext *context = bGContext.managedObjectContext;
    NSError *err;
    
    if(self.isAdd)
    {
        BatteryInfo *bi = [NSEntityDescription insertNewObjectForEntityForName:@"BatteryInfo"  inManagedObjectContext:context];
        bi.name = self.txtBatteryName.text;
        bi.batteryDescription = self.txtBatteryDesc.text;
        bi.lastChargedDate = [NSDate date];
        
        if (![context save:&err]) {
            NSLog(@"Whoops, couldn't save: %@", [err localizedDescription]);
        }
        
        MessageCenter *msg = [[MessageCenter alloc]init];
        [msg batteryCharge:self.txtBatteryName.text];
    }else
    {
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cmdCharged_clicked:(id)sender
{
    
    
    //Set a new notification
    MessageCenter *msg = [[MessageCenter alloc]init];
    [msg batteryCharge:self.txtBatteryName.text];
    
    
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

@end