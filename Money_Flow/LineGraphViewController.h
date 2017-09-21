//
//  LineGraphViewController.h
//  Money_Flow
//
//  Created by YongJai on 26/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface LineGraphViewController : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *graphView;

@property (strong, nonatomic) NSMutableArray *arrayOfIncomeValues;
@property (strong, nonatomic) NSMutableArray *arrayOfOutgoingValues;
@property (strong, nonatomic) NSMutableArray *arrayOfOutgoingDates;
@property (strong, nonatomic) NSMutableArray *arrayOfIncomeDates;

@property (strong, nonatomic) NSMutableArray *arrayOfDates;
@property (weak, nonatomic) IBOutlet UILabel *labelValues;
@property (weak, nonatomic) IBOutlet UILabel *labelDates;

@property (nonatomic) BOOL isIncome;


@end
