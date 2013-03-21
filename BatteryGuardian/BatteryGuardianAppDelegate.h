//
//  BatteryGuardianAppDelegate.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//
@class AllBatteriesViewController;

#import <UIKit/UIKit.h>

@interface BatteryGuardianAppDelegate : UIResponder <UIApplicationDelegate>

+(BatteryGuardianAppDelegate *) sharedAppDelegate;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet AllBatteriesViewController *batteriesViewController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;

@end
