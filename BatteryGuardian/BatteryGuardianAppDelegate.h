//
//  BatteryGuardianAppDelegate.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//
@class AllBatteriesViewController;

#import <UIKit/UIKit.h>
#import "BatteryGuardianContext.h"

@interface BatteryGuardianAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
