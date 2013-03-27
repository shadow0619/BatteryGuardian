//
//  MessageCenter.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import <Foundation/Foundation.h>

@interface MessageCenter : NSObject

-(void) notifyBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn;

-(void) calendarBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn;

@end
