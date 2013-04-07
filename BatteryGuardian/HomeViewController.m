//
//  HomeViewController.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "hiddenViewViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    /*
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedGesture:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionUp);
    [self.view addGestureRecognizer:swipeGesture];
*/
}


-(IBAction) swipedGesture:(id)sender
{
    NSLog(@"swiped");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
