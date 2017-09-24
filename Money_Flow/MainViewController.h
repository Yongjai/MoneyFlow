//
//  MainViewController.h
//  Money_Flow
//
//  Created by YongJai on 27/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSUInteger dayNum;
@property NSUInteger weekday;
@property NSUInteger month;
@property NSUInteger year;

@property (weak, nonatomic) NSMutableArray *incomeTotalArr;
@property (weak, nonatomic) NSMutableArray *outgoingTotalArr;

@property (weak, nonatomic) IBOutlet UITableView *outgoingTableView;
@property (weak, nonatomic) IBOutlet UITableView *incomeTableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end
