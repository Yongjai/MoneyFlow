//
//  LineGraphViewController.m
//  Money_Flow
//
//  Created by YongJai on 26/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "LineGraphViewController.h"
#import "Income.h"
#import "Outgoing.h"
#import <Realm/Realm.h>


@interface LineGraphViewController (){
    int previousStepperValue;
    int totalNumber;
}
@end

@implementation LineGraphViewController{
    RLMResults<Income*> *incomeList;
    RLMResults<Outgoing*> *outgoingList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    incomeList = [Income allObjects];
    outgoingList = [Outgoing allObjects];
    _isIncome = YES;
    
//    RLMResults<Income *> *sortedPrice = [Income objectsWhere:@""];

    
    _arrayOfIncomeValues = [incomeList valueForKey:@"price"];
    _arrayOfIncomeDates = [incomeList valueForKey:@"time"];
    _arrayOfOutgoingValues = [outgoingList valueForKey:@"price"];
    _arrayOfOutgoingDates = [outgoingList valueForKey:@"time"];
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.graphView.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    self.graphView.enableTouchReport = YES;
    self.graphView.enablePopUpReport = YES;
    self.graphView.enableYAxisLabel = YES;
    self.graphView.autoScaleYAxis = YES;
    self.graphView.alwaysDisplayDots = NO;
    self.graphView.enableReferenceXAxisLines = YES;
    self.graphView.enableReferenceYAxisLines = YES;
    self.graphView.enableReferenceAxisFrame = YES;
    
    // Draw an average line
    self.graphView.averageLine.enableAverageLine = YES;
    self.graphView.averageLine.alpha = 0.6;
    self.graphView.averageLine.color = [UIColor darkGrayColor];
    self.graphView.averageLine.width = 2.5;
    self.graphView.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.graphView.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.graphView.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.graphView.formatStringForValues = @"%.1f";
    
  

    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated {
//    [_graphView setNeedsDisplay];
//    NSLog(@"리로드");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    if (!_isIncome) {
        return (int)[self.arrayOfOutgoingValues count];
    } else {
        return (int)[self.arrayOfIncomeValues count];
    }
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    if (!_isIncome ) {
        return [[self.arrayOfOutgoingValues objectAtIndex:index] doubleValue];
    } else {
        return [[self.arrayOfIncomeValues objectAtIndex:index] doubleValue];
    }
}

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)labelForOutgoingDateAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfOutgoingDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd";
    NSString *label = [df stringFromDate:date];
    return label;
}


- (NSString *)labelForIncomeDateAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfIncomeDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd";
    NSString *label = [df stringFromDate:date];
    return label;
}


- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    if (!_isIncome) {
        NSString *label1 = [self labelForOutgoingDateAtIndex:index];

        return [label1 stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    } else {
        NSString *label2 = [self labelForIncomeDateAtIndex:index];

        return [label2 stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    }
}
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    cell.dateLabel.text = [formatter stringFromDate: incomes.time];
//


- (IBAction)outgoingBtnClicked:(id)sender {
    _isIncome = NO;
    
    [_graphView reloadGraph];
}

- (IBAction)incomeBtnClicked:(id)sender {
    _isIncome = YES;
    
    [_graphView reloadGraph];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
