//
//  FISEventDetailViewController.h
//  tasksToday
//
//  Created by Cenker Demir on 6/20/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISEventDetailViewController : UIViewController

@property (strong, nonatomic) NSString *eventList;

@property (weak, nonatomic) IBOutlet UITextView *textViewForEvents;

@end
