//
//  IncomeAddViewController.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "IncomeAddViewController.h"

@interface IncomeAddViewController ()

@end
    
@implementation IncomeAddViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawCategoryBtn];
    NSLog(@"dnsjkfnkjd");
    if (_isEdit){
        self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)_editSomething.price];
        NSLog(@"edit");
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedDismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickedInputBtn:(id)sender {
    Income *income = [[Income alloc] init];
    income.price = [_priceTextField.text intValue];
    income.time = [NSDate date];
    income.category = @"income";
    
    [income incomeAdd];
    
    if (!_isEdit) {
        income.uuid = [[NSUUID UUID] UUIDString];
    } else {
        income.uuid = _editSomething.uuid;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDED" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@", income);

}

- (void)drawCategoryBtn {
    _categoryArray = [[NSArray alloc] initWithObjects:@"월급", @"용돈", @"기타", nil];

    for(int i = 0; i < [_categoryArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        NSUInteger xCoord = (i * 60) + 50;
        
        
//        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor greenColor].CGColor;
        button.backgroundColor = [UIColor greenColor];
        button.frame = CGRectMake(xCoord, 270.0, 50, 30);
        [button setTitle:[NSString stringWithFormat:@"%@", _categoryArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
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
