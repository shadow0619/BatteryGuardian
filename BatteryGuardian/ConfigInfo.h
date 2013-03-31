//
//  ConfigInfo.h
//  BatteryGuardian
//
//  Created by Brian Picard on 3/31/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ConfigInfo : NSManagedObject

@property (nonatomic, retain) NSString * notificationType;
@property (nonatomic, retain) NSNumber * noDaysToNotify;

@end
