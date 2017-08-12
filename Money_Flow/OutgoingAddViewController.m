//
//  OutgoingAddViewController.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "OutgoingAddViewController.h"
#import "Outgoing.h"

@interface OutgoingAddViewController ()

@end

@implementation OutgoingAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    outgoing.price = self.priceTextField.text;
    outgoing.time = [NSDate date];
    outgoing.category = @"test";
    outgoing.uuid = [[NSUUID UUID] UUIDString];
    [outgoing outgoingAdd];
    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"%@", outgoing);
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
