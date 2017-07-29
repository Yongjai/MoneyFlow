//
//  MainViewController.m
//  Money_Flow
//
//  Created by YongJai on 27/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//
//ViewController
#import "MainViewController.h"
#import "IncomeTableViewCell.h"
#import "OutgoingTableViewCell.h"
#import "IncomeAddViewController.h"
#import "OutgoingAddViewController.h"

//Realm Data Model
#import "Income.h"
#import "Outgoing.h"
#import <Realm/Realm.h>


@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inputTableView.dataSource = self;
    _outputTableView.dataSource = self;
    [self presentFirstCalendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

///////////////////
// Calendar Part //
///////////////////
- (void)createCalendar {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:_month];
    [components setYear:_year];
    NSDate * newDate = [calendar dateFromComponents:components];
    NSDateComponents *newComponents = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
    _weekday=[newComponents weekday];
    
    _dayNum = [self getCurrentDateInfo:newDate];
    NSUInteger newWeekDay = _weekday - 1;
    
    int yVal = 40;
    int count = 1;
    
    UILabel *yearMonth = [[UILabel alloc]initWithFrame:CGRectMake(112, 10, 150, 50)];
    [yearMonth setFont:[UIFont systemFontOfSize:20]];
    [yearMonth setText:[NSString stringWithFormat:@"%ld년 %ld월", (long)_year, (long)_month]];
    [yearMonth setTextColor:[UIColor blackColor]];
    yearMonth.textAlignment = NSTextAlignmentCenter;
    yearMonth.tag = 32;
    [self.view addSubview:yearMonth];
    
    UILabel *dayName = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 375, 30)];
    [dayName setFont:[UIFont systemFontOfSize:8]];
    [dayName setText:[NSString stringWithFormat:@"일        월       화       수       목       금      토"]];
    [dayName setTextColor:[UIColor blackColor]];
    dayName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dayName];
    
    for (int startDay = 1; startDay <= _dayNum; startDay++) {
        UIButton *dayNumBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        if (startDay % 2 == 0) {
            dayNumBtn.backgroundColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1.0];
        }
        
        dayNumBtn.layer.borderWidth = 1.0f;
        dayNumBtn.layer.borderColor = [UIColor grayColor].CGColor;
        
        NSUInteger xCoord = (newWeekDay * 50) + 13;
        NSUInteger yCoord = (count * 40) + yVal;
        newWeekDay++;
        
        if (newWeekDay > 6) {
            newWeekDay = 0;
            count++;
        }
        
        dayNumBtn.frame = CGRectMake(xCoord, yCoord, 50, 40);
        [dayNumBtn setTitle:[NSString stringWithFormat:@"%d",startDay]forState:UIControlStateNormal];
        [dayNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dayNumBtn.tag = startDay;
        
        [self.view addSubview:dayNumBtn];
    }
}

- (void)presentFirstCalendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    _year = [components year];
    _month = [components month];
    
    [self createCalendar];
}

- (void)prevButton {
    UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [prevBtn setFrame:CGRectMake(30, 50, 55, 55)];
    [prevBtn setTitle:@"<< prev" forState:UIControlStateNormal];
    [prevBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [prevBtn addTarget:self action:@selector(prev:) forControlEvents:UIControlEventTouchUpInside];
    prevBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:prevBtn];
}

- (void)nextButton {
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextBtn setFrame:CGRectMake(290, 50, 55, 55)];
    [nextBtn setTitle:@"next >>" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:nextBtn];
}

- (void)next:(id)sender {
    _month++;
    [self removeTag];
    [self updateCalNow];
}

- (void)prev:(id)sender {
        _month--;
        [self removeTag];
        [self updateCalNow];
}

- (void)updateCalNow {
    if (_month > 12) {
        _month = 1;
        _year++;
    } else if (_month < 1) {
        _month = 12;
        _year--;
    }
    [self createCalendar];
}

- (NSUInteger)getCurrentDateInfo:(NSDate *)myDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (void)removeTag {
    int x = 1;
    while (x <= 40) {
        [[self.view viewWithTag:x]removeFromSuperview];
        x++;
    }
}


////////////////////
// TableView Part //
////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    static NSString *outputCellIdentifier = @"outgoingCell";
    static NSString *inputCellIdentifier = @"incomeCell";
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (tableView == _outputTableView) {
        cell = [_outputTableView dequeueReusableCellWithIdentifier:outputCellIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"Outgoing Table :%ld", indexPath.row];
    } else {
        cell = [_inputTableView dequeueReusableCellWithIdentifier:inputCellIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"Income Table :%ld", indexPath.row];
    }
    
    return cell;
}

////////////////
// Add Button //
///////////////
- (IBAction)clickedOutgoingAddBtn:(id)sender {
    OutgoingAddViewController* outgoingVC = [[OutgoingAddViewController alloc] initWithNibName:@"OutgoingView" bundle:nil];
    [self presentViewController:outgoingVC animated:YES completion:nil];
}

- (IBAction)clickedIncomeAddBtn:(id)sender {
    IncomeAddViewController* incomeVC = [[IncomeAddViewController alloc] initWithNibName:@"IncomeView" bundle:nil];
    [self presentViewController:incomeVC animated:YES completion:nil];
}




@end
