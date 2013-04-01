//
//  configManager.m
//  BatteryGuardian
//
//  Created by Brian Picard on 3/31/13.
//
//
#import "BatteryGuardianAppDelegate.h"
#import "configManager.h"
#import "ConfigInfo.h"


@implementation configManager

static configManager *sharedInstance;

@synthesize config;

-(id)init
{
    //Should be removed or dealt with to kill requrest if requesting a second instance
    if(sharedInstance)
    {
        
    }
    
    //Get the delegate to get the managedObjectContext
    BatteryGuardianAppDelegate *del = [[BatteryGuardianAppDelegate alloc] init];
    NSManagedObjectContext *context = del.managedObjectContext;
    NSError *err;
    
    //Fetch the config, if there are no entries then add one.
    NSFetchRequest *fetchTheConfig = [[NSFetchRequest alloc]init];
    NSEntityDescription *entDesc = [NSEntityDescription entityForName:@"ConfigInfo" inManagedObjectContext:context];
    [fetchTheConfig setEntity:entDesc];
    NSArray *fetchedConfigs = [context executeFetchRequest:fetchTheConfig error:&err];
    
    //If there are no entries add one and continue
    if([fetchedConfigs count] < 1)
    {
        ConfigInfo *cfg = [NSEntityDescription insertNewObjectForEntityForName:@"ConfigInfo" inManagedObjectContext:context];
        cfg.noDaysToNotify = [NSNumber numberWithInteger:30];
        cfg.notificationType = @"calendar";
        if(![context save:&err])
        {
            NSLog(@"Couldn't save: %@", [err localizedDescription]);
        }
        fetchedConfigs = [[NSArray alloc] initWithObjects:cfg,nil];
            
    }
    
    //Set the internal value of the config
    for(ConfigInfo *info in fetchedConfigs)
    {
        config = info;
    }
    self = [super init];
    sharedInstance = self;
    return self;
}

+(configManager *) sharedConfigManagerDelegate
{
    return sharedInstance;
}

-(ConfigInfo *) config
{
    return config;
}

-(void) configUpdate
{
    //Get the delegate to get the managedObjectContext
    BatteryGuardianAppDelegate *del = [[BatteryGuardianAppDelegate alloc] init];
    NSManagedObjectContext *context = del.managedObjectContext;
    NSError *err;
    
    //Fetch the config, if there are no entries then add one.
    NSFetchRequest *fetchTheConfig = [[NSFetchRequest alloc]init];
    NSEntityDescription *entDesc = [NSEntityDescription entityForName:@"ConfigInfo" inManagedObjectContext:context];
    [fetchTheConfig setEntity:entDesc];
    NSArray *fetchedConfigs = [context executeFetchRequest:fetchTheConfig error:&err];
    
    //Loop through and delete all configs
    for(ConfigInfo *ci in fetchedConfigs)
    {
        [context deleteObject:ci];
    }
    
    //Add the new config back
    ConfigInfo *cfg = [NSEntityDescription insertNewObjectForEntityForName:@"ConfigInfo" inManagedObjectContext:context];
    cfg.noDaysToNotify = self.config.noDaysToNotify;
    cfg.notificationType = self.config.notificationType;
    if(![context save:&err])
    {
        NSLog(@"Couldn't save: %@", [err localizedDescription]);
    }        
}

@end
