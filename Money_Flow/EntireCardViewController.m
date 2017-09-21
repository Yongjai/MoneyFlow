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
}



- (void)viewDidLoad {
    [super viewDidLoad];
    incomeList = [Income allObjects];
    outgoingList = [Outgoing allObjects];
    _count = 30;
    _string = @"A";

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [CardTableView reloadData];
    NSLog(@"리로드");
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
    if ([_string isEqualToString:@"A"]) {
        return outgoingList.count;
    } else {
        return incomeList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_string isEqualToString:@"A"]) {
        EntireCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Outgoing *outgoings = [outgoingList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.titleLabel.text = @"지출";
        cell.dateLabel.text = [NSString stringWithFormat:@"%@" ,outgoings.time];

        cell.priceLabel.text = [NSString stringWithFormat:@"%ld ₩", (long)outgoings.price];
        cell.categoryLabel.text = outgoings.category;
        NSLog(@"얘도 불림?");
        
        return cell;
    } else {
        EntireCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        Income *incomes = [incomeList objectAtIndex:indexPath.row];
        cell.priceLabel.layer.cornerRadius = 10;
        cell.priceLabel.clipsToBounds = YES;
        cell.categoryLabel.layer.cornerRadius = 10;
        cell.categoryLabel.clipsToBounds = YES;
        cell.titleLabel.text = @"수입";
        cell.dateLabel.text = [NSString stringWithFormat:@"%@" ,incomes.time];
        cell.priceLabel.text = [NSString stringWithFormat:@"%ld ₩" ,(long)incomes.price];
        cell.categoryLabel.text = incomes.category;
        NSLog(@"얘도 불림?22222");

        return cell;
    }
}

- (void) reloadCardTable {
    [CardTableView reloadData];
    [self viewWillAppear:YES];
}

- (IBAction)outgoingBtnClicked:(id)sender {
    _string = @"A";
    NSLog(@"%@", _string);

    [self reloadCardTable];
}


- (IBAction)incomeBtnClicked:(id)sender {
    _count = 100;
    _string = @"B";
    NSLog(@"%@", _string);

    [self reloadCardTable];
}

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
