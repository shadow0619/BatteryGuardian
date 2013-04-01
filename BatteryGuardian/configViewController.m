//
//  configViewController.m
//  BatteryGuardian
//
//  Created by Brian Picard on 3/31/13.
//
//

#import "configViewController.h"
#import "configManager.h"

@interface configViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segNotificationType;
@property (weak, nonatomic) IBOutlet UISlider *sldNotifyDays;
@property (weak, nonatomic) IBOutlet UILabel *lblNotifyDays;

@end

@implementation configViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Read the current config and set the values
    configManager *mgr = [[configManager alloc] init];
    ConfigInfo *ci = mgr.config;
    [self.sldNotifyDays setValue:[ci.noDaysToNotify floatValue]];
    [self.lblNotifyDays setText:[NSString stringWithFormat:@"%@",ci.noDaysToNotify]];
     if([ci.notificationType isEqualToString:@"calendar"])
     {
         [self.segNotificationType setSelectedSegmentIndex:1];
     }
     if([ci.notificationType isEqualToString:@"notification"])
     {
         [self.segNotificationType setSelectedSegmentIndex:0];
     }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)notifyDays_Changed:(id)sender
{
    [self.lblNotifyDays setText: [NSString stringWithFormat:@"%.0f", self.sldNotifyDays.value]];
    
    //Build a config to update
    configManager *mgr = [[configManager alloc]init];
    mgr.config.noDaysToNotify = [NSNumber numberWithInt:(int)self.sldNotifyDays.value];
    
    //Create a config manager and push the new config to update.
    [mgr configUpdate];
}
- (IBAction)segNotificationType_Changed:(id)sender
{
    configManager *mgr = [[configManager alloc]init];
    
    if(self.segNotificationType.selectedSegmentIndex == 0)
        mgr.config.notificationType = @"notification";
    if(self.segNotificationType.selectedSegmentIndex == 1)
        mgr.config.notificationType = @"calendar";
    
    //Create a config manager and push the new config to update.
    [mgr configUpdate];
}

@end
