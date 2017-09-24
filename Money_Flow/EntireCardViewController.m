//
//  EntireCardViewController.m
//  Money_Flow
//
//  Created by YongJai on 19/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "EntireCardViewController.h"
#import "EntireCardTableViewCell.h"

#import "Income.h"
#import "Outgoing.h"
#import <Realm/Realm.h>


@interface EntireCardViewController ()

@end

@implementation EntireCardViewController{
    RLMResults<Income*> *incomeList;
    RLMResults<Outgoing*> *outgoingList;
    __weak IBOutlet UITableView *CardTableView;
    __weak IBOutlet UISegmentedControl *segmentedControl;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    incomeList = [Income allObjects];
    outgoingList = [Outgoing allObjects];
    _isOutgoing = YES;
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];

//    NSLog(@"%@", [incomeList objectsWhere:@"Income.@price > 1000"]);

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [CardTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataChanging {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isOutgoing) {
        return outgoingList.count;
    } else {
        return incomeList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isOutgoing) {
        EntireCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Outgoing *outgoings = [outgoingList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.titleLabel.text = @"지출";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        cell.dateLabel.text = [formatter stringFromDate:outgoings.time];
        cell.priceLabel.text = [NSString stringWithFormat:@"%ld ₩", (long)outgoings.price];
        cell.categoryLabel.text = outgoings.category;
        
        return cell;
    } else {
        EntireCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Income *incomes = [incomeList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.titleLabel.text = @"수입";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        cell.dateLabel.text = [formatter stringFromDate: incomes.time];
        cell.priceLabel.text = [NSString stringWithFormat:@"%ld ₩" ,(long)incomes.price];
        cell.categoryLabel.text = incomes.category;

        return cell;
    }
}
- (IBAction)segmentedCotrolClicked:(id)sender {
    if (segmentedControl.selectedSegmentIndex == 0) {
        _isOutgoing = YES;
        [self reloadCardTable];
    } else if(segmentedControl.selectedSegmentIndex == 1) {
        _isOutgoing = NO;
        [self reloadCardTable];
    }
}


- (void) reloadCardTable {
    [CardTableView reloadData];
    [self viewWillAppear:YES];
}

//- (IBAction)outgoingBtnClicked:(id)sender {
//    _isOutgoing = YES;
//
//    [self reloadCardTable];
//}
//
//
//- (IBAction)incomeBtnClicked:(id)sender {
//    _isOutgoing = NO;
//
//    [self reloadCardTable];
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
