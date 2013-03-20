//
//  AllBatteriesViewController.h
//  BatteryGuardian
//
//  Created by brian on 3/17/13.
//
//

#import <UIKit/UIKit.h>

@interface AllBatteriesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *batteryInfos;
@property (weak, nonatomic) IBOutlet UITableView *tableViewController;

@end
