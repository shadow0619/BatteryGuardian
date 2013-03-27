//
//  MessageCenter.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import <Foundation/Foundation.h>

@interface MessageCenter : NSObject

-(NSArray*) notifyBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn;

-(NSArray*) calendarBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn;

@end
