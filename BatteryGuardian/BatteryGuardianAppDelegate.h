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

//+(BatteryGuardianAppDelegate *) sharedAppDelegate;

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, retain) IBOutlet AllBatteriesViewController *batteriesViewController;

//@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//- (NSURL *)applicationDocumentsDirectory;

@end
