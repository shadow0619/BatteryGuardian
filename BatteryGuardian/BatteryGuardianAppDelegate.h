//
//  BatteryGuardianAppDelegate.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import <UIKit/UIKit.h>

@interface BatteryGuardianAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;

@end
