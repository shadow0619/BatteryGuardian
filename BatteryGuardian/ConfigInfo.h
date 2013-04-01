//
//  ConfigInfo.h
//  BatteryGuardian
//
//  Created by Brian Picard on 4/1/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ConfigInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * noDaysToNotify;
@property (nonatomic, retain) NSString * notificationType;

@end
