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
    //Iterate through all local notifications and remove the existing one for this battery if it exists
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *notifications = [app scheduledLocalNotifications];

    for(UILocalNotification *localNot in notifications)
    {
        if([localNot.alertBody hasPrefix:(batteryName)])
        {
            [app cancelLocalNotification:(localNot)];
        }
    }
    
    
    //Build the local notification
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertBody: [NSString stringWithFormat:@"%@ needs to be charged!!!", batteryName]];
    [localNot setFireDate:(notifyOn)];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNot setAlertAction: @"View"];
    
    //call the sharedapplication instance to schedule a local notification
    [app scheduleLocalNotification:localNot];
}

-(void) calendarBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn
{
    //Iterate through all local notifications and remove the existing one for this battery if it exists
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *notifications = [app scheduledLocalNotifications];
    
    for(UILocalNotification *localNot in notifications)
    {
        if([localNot.alertBody hasPrefix:(batteryName)])
        {
            [app cancelLocalNotification:(localNot)];
        }
    }
    
    
    //Build the local notification
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertBody: [NSString stringWithFormat:@"%@ needs to be charged!!!", batteryName]];
    [localNot setFireDate:(notifyOn)];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNot setAlertAction: @"View"];
    
    //call the sharedapplication instance to schedule a local notification
    [app scheduleLocalNotification:localNot];
}
@end
