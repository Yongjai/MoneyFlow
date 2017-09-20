//
//  MainViewController.m
//  Money_Flow
//
//  Created by YongJai on 27/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//
//ViewController
#import "MainViewController.h"
#import "IncomeAddViewController.h"
#import "IncomeTableViewCell.h"
#import "OutgoingAddViewController.h"
#import "OutgoingTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


//Realm
#import "Income.h"
#import "Outgoing.h"
#import <Realm/Realm.h>


@interface MainViewController () {
    OutgoingAddViewController *outgoingAddViewController;
    IncomeAddViewController *incomeAddViewController;
}
@end

@implementation MainViewController {
    RLMResults<Income*> *incomeList;
    RLMResults<Outgoing*> *outgoingList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self calculateBalance];
    outgoingAddViewController.isEdit = YES;
    incomeAddViewController.isEdit = YES;
    
    incomeList = [Income allObjects];
    outgoingList = [Outgoing allObjects];
    
    [self presentFirstCalendar];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(prev:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    
    NSNotificationCenter *incomeNoti = [NSNotificationCenter defaultCenter];
    [incomeNoti addObserver:self selector:@selector(reloadIncomeTableView) name:@"INCOME_ADDED" object:nil];
    
    NSNotificationCenter *outgoingNoti = [NSNotificationCenter defaultCenter];
    [outgoingNoti addObserver:self selector:@selector(reloadOutgoingTableView) name:@"OUTGOING_ADDED" object:nil];
    
    NSNotificationCenter *balanceLabelNoti = [NSNotificationCenter defaultCenter];
    [balanceLabelNoti addObserver:self selector:@selector(viewDidLoad) name:@"ADDED" object:nil];
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
    
    NSDateFormatter *day = [[NSDateFormatter alloc]init];
    [day setDateFormat:@"YYYYMd"];
    NSString *today = [day stringFromDate:[NSDate date]];
    
    UILabel *yearMonth = [[UILabel alloc]initWithFrame:CGRectMake(87, 15, 200, 50)];
    [yearMonth setFont:[UIFont systemFontOfSize:30]];
    [yearMonth setText:[NSString stringWithFormat:@"%ld년 %ld월", (long)_year, (long)_month]];
    [yearMonth setTextColor:[UIColor blackColor]];
    yearMonth.textAlignment = NSTextAlignmentCenter;
    yearMonth.tag = 32;
    [self.view addSubview:yearMonth];
    
    for (int i = 0; i < 7; i ++) {
        NSArray *dayNameArr = [NSArray arrayWithObjects:@"일", @"월", @"화", @"수", @"목", @"금", @"토", nil];
        UILabel *dayNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(13 + (50 * i), 50 , 40, 40)];
        dayNameLabel.textAlignment = NSTextAlignmentCenter;
        [dayNameLabel setFont:[UIFont systemFontOfSize:15]];
        [dayNameLabel setText:dayNameArr[i]];
        [dayNameLabel setTextColor:[UIColor grayColor]];
        [self.view addSubview:dayNameLabel];
    }
    
    for (int startDay = 1; startDay <= _dayNum; startDay++) {
        UIButton *dayNumBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        NSString *date = [NSString stringWithFormat:@"%ld%ld%d", (long)_year, (long)_month, startDay];
        NSUInteger xCoord = (newWeekDay * 50) + 13;
        NSUInteger yCoord = (count * 45) + yVal;
        newWeekDay++;
        
        if (newWeekDay > 6) {
            newWeekDay = 0;
            count++;
        }
        
        dayNumBtn.frame = CGRectMake(xCoord, yCoord, 40, 40);
        [dayNumBtn setTitle:[NSString stringWithFormat:@"%d",startDay]forState:UIControlStateNormal];
        [dayNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dayNumBtn.layer.shadowColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f] CGColor];
        dayNumBtn.layer.shadowOffset = CGSizeMake(0, 2.0f);
        dayNumBtn.layer.shadowOpacity = 1.0f;
        dayNumBtn.layer.shadowRadius = 0.0f;
        dayNumBtn.layer.masksToBounds = NO;
        dayNumBtn.layer.cornerRadius = 4.0f;
        
        if ([date isEqualToString:today]) {
            dayNumBtn.backgroundColor = [UIColor redColor];
        } else {
            dayNumBtn.backgroundColor = [UIColor colorWithRed:171 green:178 blue:186 alpha:1.0f];
        }
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_outgoingTableView]) {
        return [outgoingList count];
    } else {
        return [incomeList count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_outgoingTableView]) {
        OutgoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Outgoing *outgoings = [outgoingList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.priceLabel.text = [NSString stringWithFormat:@"%ld", (long)outgoings.price];
        cell.categoryLabel.text = outgoings.category;
        
        return cell;
    } else {
        IncomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Income *incomes = [incomeList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.priceLabel.text = [NSString stringWithFormat:@"%ld" ,(long)incomes.price];
        cell.categoryLabel.text = incomes.category;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_outgoingTableView]) {
        Outgoing *outgoings = [[Outgoing alloc] init];
        outgoings = [outgoingList objectAtIndex:indexPath.row];
        NSLog(@"%@", outgoings);
        
        outgoingAddViewController.editSomething = outgoings;
        OutgoingAddViewController *outgoingVC = [[OutgoingAddViewController alloc] initWithNibName:@"OutgoingView" bundle:nil];
        outgoingVC.isEdit = YES;
        [self presentViewController:outgoingVC animated:YES completion:nil];
    } else {
        Income *incomes = [[Income alloc]init];
        incomes = [incomeList objectAtIndex:indexPath.row];
        incomeAddViewController.editSomething = incomes;
        IncomeAddViewController *incomeVC = [[IncomeAddViewController alloc] initWithNibName:@"IncomeView" bundle:nil];
        incomeVC.isEdit = YES;
        [self presentViewController:incomeVC animated:YES completion:nil];
    }
}


- (void)reloadIncomeTableView {
    [_incomeTableView reloadData];
}

- (void)reloadOutgoingTableView {
    [_outgoingTableView reloadData];
}

////////////////
// Add Button //
///////////////
- (IBAction)clickedOutgoingAddBtn:(id)sender {
    OutgoingAddViewController *outgoingVC = [[OutgoingAddViewController alloc] initWithNibName:@"OutgoingView" bundle:nil];
    [self presentViewController:outgoingVC animated:YES completion:nil];
}

- (IBAction)clickedIncomeAddBtn:(id)sender {
    IncomeAddViewController *incomeVC = [[IncomeAddViewController alloc] initWithNibName:@"IncomeView" bundle:nil];
    [self presentViewController:incomeVC animated:YES completion:nil];
}


////////////////////
// Calculate Data //
////////////////////

- (void)calculateBalance {
    RLMResults *incomePrices = [Income allObjects];
    RLMResults *outgoingPrices = [Outgoing allObjects];
    
    _incomeTotalArr = [incomePrices valueForKey:@"price"];
    _outgoingTotalArr = [outgoingPrices valueForKey:@"price"];
    
    NSInteger incomeSum = 0;
    NSInteger outgoingSum = 0;
    
    for (NSNumber *incomes in _incomeTotalArr) {
        incomeSum += [incomes intValue];
    }
    
    for (NSNumber *outgoings in _outgoingTotalArr) {
        outgoingSum += [outgoings intValue];
    }
    
    NSInteger balance = incomeSum - outgoingSum;
    _balanceLabel.text = [NSString stringWithFormat:@"%ld", balance];
}


@end
