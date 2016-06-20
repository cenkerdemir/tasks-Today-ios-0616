//
//  FISViewController.m
//  tasksToday
//
//  Created by Joe Burgess on 6/19/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import <EventKit/EventKit.h>

@interface FISViewController ()
@property (strong, nonatomic) NSArray *lastYearsEvents;
@property (strong, nonatomic) NSArray *nextYearsEvents;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestCalendarPermission];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *eventsTitleList = @"";
    
    if ([segue.identifier isEqualToString:@"nextYear"]) {
        //get the list of the titles of next years' events and set it to the textview of the destination
        self.nextYearsEvents = [self getNextYearsEvents];
        for (NSUInteger i = 0; i < [self.nextYearsEvents count]; i++) {
            NSString *eventTitle = [self.nextYearsEvents[i] title];
            eventsTitleList = [eventsTitleList stringByAppendingString:[NSString stringWithFormat: @"%@", eventTitle]];
        }
        FISEventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.eventList = eventsTitleList;
    }
    else if ([segue.identifier isEqualToString:@"lastYear"]) {
        //get the list of the titles of next years' events and set it to the textview of the destination
        self.lastYearsEvents = [self getLastYearsEvents];
        for (NSUInteger i=0; i < [self.lastYearsEvents count]; i++) {
            NSString *eventTitle = [self.lastYearsEvents[i] title];
            eventsTitleList = [eventsTitleList stringByAppendingString:[NSString stringWithFormat:@"%@", eventTitle]];
        }
        FISEventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.eventList = eventsTitleList;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//written by joe Burgess. copied it for the lab as it was permitted and recommended
- (NSArray *)getNextYearsEvents {
    EKEventStore *store = [[EKEventStore alloc] init];
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = 1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:[NSDate date]
                                                            endDate:oneYearFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    return events;
}

//written by joe Burgess. copied it for the lab as it was permitted and recommended
- (NSArray *)getLastYearsEvents {
    EKEventStore *store = [[EKEventStore alloc] init];
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start date components
    
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = -1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneYearFromNow
                                                            endDate:[NSDate date]
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    return events;
}

//written by joe Burgess. copied it for the lab as it was permitted and recommended
- (void)requestCalendarPermission {
    
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {}];
}


@end
