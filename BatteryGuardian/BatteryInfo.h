//
//  BatteryInfo.h
//  BatteryGuardian
//
//  Created by Drew Thomas on 3/19/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BatteryInfo : NSManagedObject

@property (nonatomic, retain) NSString * batteryDescription;
@property (nonatomic, retain) NSString * lastChargedDate;

@end
