//
//  MessageCenter.m
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import "MessageCenter.h"
#import <EventKit/EventKit.h>
#import "configManager.h"
#import "ConfigInfo.h"
@interface MessageCenter()

-(void) removeNotification:(NSString*)batteryName app:(UIApplication*)app;
-(void) removeCalendar:(NSString *)batteryName eventStore:(EKEventStore*)eventStore calendarEntries:(NSArray*)calendarEntries;

@end

@implementation MessageCenter

-(void) batteryCharge:(NSString *)batteryName
{
    //Make the notify date
    NSDateComponents *dateComp = [[NSDateComponents alloc]init];
    dateComp.day = [[NSUserDefaults standardUserDefaults] integerForKey:@"mltNumDays"];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *notDate = [cal dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
    
    //Determine which option is selected on how to be notified
    if([[[NSUserDefaults standardUserDefaults] stringForKey:(@"mltAlertTypes")] isEqual: @"calendar"])
    {
        [[self class] calendarBatteryCharge:[NSString stringWithFormat:@"%@ needs to be charged!!!!",batteryName] whenToNotify:notDate];
    }
    if([[[NSUserDefaults standardUserDefaults] stringForKey:(@"mltAlertTypes")]  isEqual: @"notification"])
    {
        [[self class] notifyBatteryCharge:[NSString stringWithFormat:@"%@ needs to be charged!!!!",batteryName] whenToNotify:notDate];
    }
    
}

+(void) notifyBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn
{
    //Iterate through all local notifications and remove the existing one for this battery if it exists
    UIApplication *app = [UIApplication sharedApplication];
    [[self class] removeNotification:batteryName app:app];
    
    //Build the local notification
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertBody: [NSString stringWithFormat:@"%@ needs to be charged!!!", batteryName]];
    [localNot setFireDate:(notifyOn)];
    [localNot setTimeZone:[NSTimeZone defaultTimeZone]];
    [localNot setAlertAction: @"View"];
    
    //call the sharedapplication instance to schedule a local notification
    [app scheduleLocalNotification:localNot];
}

+(void) calendarBatteryCharge:(NSString*)batteryName whenToNotify:(NSDate*) notifyOn
{
    //Iterate through and remove any notifications for this battery in case the user changes the notification setting
    UIApplication *app = [UIApplication sharedApplication];
    [[self class] removeNotification:batteryName app:app];
    
    //Iterate through all local calendar entries and remove the existing one for this battery if it exists
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //Set the future date, calendar, Predicate and finally fill the array to use for the controller
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.day = -1;
    NSDate *startDate = [calendar dateByAddingComponents:comp toDate:[NSDate date]options:0];
    comp.year = 1;
    NSDate *endDate = [calendar dateByAddingComponents:comp toDate:[NSDate date] options:0];
    NSPredicate *pred = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *calendarEntries = [eventStore eventsMatchingPredicate:pred];
    
    [[self class] removeCalendar:batteryName eventStore:eventStore calendarEntries:calendarEntries];

    
    //Create the event
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = [NSString stringWithFormat:@"%@ needs to be chared!!!!", batteryName];
    event.startDate = notifyOn;
    event.endDate = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:event.startDate];
    
    //Set the calendar and submit the event
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];

}

+(void) removeNotification:(NSString*)batteryName app:(UIApplication*)app
{
    NSArray *notifications = [app scheduledLocalNotifications];
    
    for(UILocalNotification *localNot in notifications)
    {
        if([localNot.alertBody hasPrefix:(batteryName)])
        {
            [app cancelLocalNotification:(localNot)];
        }
    }
}

+(void) removeCalendar:(NSString *)batteryName eventStore:(EKEventStore*)eventStore calendarEntries:(NSArray*)calendarEntries
{
    for(EKEvent *eve in calendarEntries)
    {
        //If an entry is found that starts with the battery name remove it.
        if([eve.title hasPrefix:(batteryName)])
        {
            NSError *err;
            [eventStore removeEvent:eve span:EKSpanThisEvent commit:YES error:&err];
        }
    }
}

@end
