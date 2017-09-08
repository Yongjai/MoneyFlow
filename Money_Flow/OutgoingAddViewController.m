//
//  OutgoingAddViewController.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "OutgoingAddViewController.h"

@interface OutgoingAddViewController ()

@end

@implementation OutgoingAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawCategoryBtn];
    if(_isEdit) {
        self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)_editSomething.price];
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
    Outgoing *outgoing = [[Outgoing alloc] init];
    outgoing.price = [self.priceTextField.text intValue];
    outgoing.time = [NSDate date];
    outgoing.category = @"outgoing";
    
    if (!_isEdit) {
        outgoing.uuid = [[NSUUID UUID] UUIDString];
        NSLog(@"not editting status");
    } else {
        outgoing.uuid = _editSomething.uuid;
        NSLog(@"edit Test");
    }
    
    [outgoing outgoingAdd];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ADDED" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)drawCategoryBtn {
    _categoryArray = [[NSArray alloc] initWithObjects:@"음식", @"쇼핑", @"교통", @"자기개발", @"기타", nil];
    for(int i = 0; i < [_categoryArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        NSUInteger xCoord = (i * 60) + 50;
        button.layer.borderColor = [UIColor greenColor].CGColor;
        button.backgroundColor = [UIColor greenColor];
        button.frame = CGRectMake(xCoord, 270, 50, 30);
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
