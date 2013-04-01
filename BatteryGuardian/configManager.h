//
//  configManager.h
//  BatteryGuardian
//
//  Created by Brian Picard on 3/31/13.
//
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"


@interface configManager : NSObject

@property (nonatomic,retain)ConfigInfo *config;

-(void) configUpdate;

+(configManager *) sharedConfigManagerDelegate;

@end
