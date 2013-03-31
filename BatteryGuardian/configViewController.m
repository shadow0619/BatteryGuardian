//
//  configViewController.m
//  BatteryGuardian
//
//  Created by Brian Picard on 3/31/13.
//
//

#import "configViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)notifyDays_Changed:(id)sender
{
    [self.lblNotifyDays setText: [NSString stringWithFormat:@"%.0f", self.sldNotifyDays.value]];
    //implement an update to the config
}
- (IBAction)segNotificationType_Changed:(id)sender
{
    //implement an update to the config
}

@end
