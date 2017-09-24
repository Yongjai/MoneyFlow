//
//  IncomeAddViewController.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "IncomeAddViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface IncomeAddViewController ()

@end
    
@implementation IncomeAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawCategoryBtn];
    if (_isEdit){
        self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)_editSomething.price];
        NSLog(@"edit");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedDismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickedCategoryBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.backgroundColor = [UIColor redColor];
    _category = btn.titleLabel.text;
}

- (IBAction)clickedInputBtn:(id)sender {
    Income *income = [[Income alloc] init];
    income.price = [_priceTextField.text intValue];
    income.time = [NSDate date];
    income.category = _category;
    
    if (!_isEdit) {
        income.uuid = [[NSUUID UUID] UUIDString];
        NSLog(@"not editting status");

    } else {
        income.uuid = _editSomething.uuid;
        NSLog(@"edit Test");

    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDED" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [income incomeAdd];
    
}

- (void)drawCategoryBtn {
    _categoryArray = [[NSArray alloc] initWithObjects:@"월급", @"용돈", @"기타", nil];

    for(int i = 0; i < [_categoryArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        NSUInteger xCoord = (i * 60) + 50;
        [button addTarget:self action:@selector(clickedCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];

        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.backgroundColor = [UIColor grayColor];
        button.frame = CGRectMake(xCoord, 270.0, 50, 30);
        [button setTitle:[NSString stringWithFormat:@"%@", _categoryArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}


@end
