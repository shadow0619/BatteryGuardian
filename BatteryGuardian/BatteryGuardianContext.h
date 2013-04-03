//
//  BatteryGuardianContext.h
//  BatteryGuardian
//
//  Created by Drew Thomas on 4/2/13.
//
//

#import <CoreData/CoreData.h>

@interface BatteryGuardianContext : NSObject

@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (BOOL) saveContext;
@end
