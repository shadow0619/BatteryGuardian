//
//  BatteryGuardianAppDelegate.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "BatteryGuardianAppDelegate.h"
#import "AllBatteriesViewController.h"
#import "BatteryInfo.h"

@implementation BatteryGuardianAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	
/*Test Code - Should fix this up so it logs the first time.*/

    NSManagedObjectContext *context = [[BatteryGuardianContext alloc] init].managedObjectContext;
    NSError *error;
	
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"BatteryInfo" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if( [fetchedObjects count] == 0 )
	{
	
		BatteryInfo *batteryInfo1 = [NSEntityDescription insertNewObjectForEntityForName:@"BatteryInfo"inManagedObjectContext:context];
		batteryInfo1.batteryDescription =  @"SPC 2200mAh";
		batteryInfo1.name = @"1-1";
		batteryInfo1.lastChargedDate = [NSDate date];

		BatteryInfo *batteryInfo2 = [NSEntityDescription
								 insertNewObjectForEntityForName:@"BatteryInfo"
								 inManagedObjectContext:context];
		batteryInfo2.batteryDescription =  @"Orion 3300mAh";
		batteryInfo2.name = @"2-2";
		batteryInfo2.lastChargedDate = [NSDate date];
	}
	
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

    for (BatteryInfo *info in fetchedObjects) {
        NSLog(@"Description: %@", info.batteryDescription);
        
        NSLog(@"Date Last Charged: %@", info.lastChargedDate);
	}
/*END Test Code*/
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
