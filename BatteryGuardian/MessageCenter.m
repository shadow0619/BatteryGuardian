//
//  MessageCenter.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "MessageCenter.h"

@implementation MessageCenter

-(void) notifyBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn
{
    //Build the local notification
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertBody: [NSString stringWithFormat:@"%@ needs to be charged!!!", batteryName]];
    [localNot setFireDate:(notifyOn)];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNot setAlertAction: @"View"];
    
    //call the sharedapplication instance to schedule a local notification
    UIApplication *app = [UIApplication sharedApplication];
    [app scheduleLocalNotification:localNot];
}

-(void) calendarBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn
{
    //Build the local notification
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertBody: [NSString stringWithFormat:@"%@ needs to be charged!!!", batteryName]];
    [localNot setFireDate:(notifyOn)];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNot setAlertAction: @"View"];
    
    //call the sharedapplication instance to schedule a local notification
    UIApplication *app = [UIApplication sharedApplication];
    [app scheduleLocalNotification:localNot];
}
@end
