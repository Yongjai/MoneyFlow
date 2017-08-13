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



////Bug Report////
//셀 선택해서 수정하는 기능을 추가하다가 갑자기 outgoingView가 까맣게 변함//
//완전히 까맣게 변하는 것도 아니라서 이상함... 마치 위에 까만 뷰를 껴놓은것처럼 변함//
//////////////////


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawCategoryBtn];
    if(_editSomething){
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
        } else {
            outgoing.uuid = _editSomething.uuid;
        }
        [outgoing outgoingAdd];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"%@", outgoing);
}



- (void)drawCategoryBtn {
    _categoryArray = [[NSArray alloc] initWithObjects:@"음식", @"쇼핑", @"교통", @"자기개발", @"기타", nil];
    for(int i = 0; i < [_categoryArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        NSUInteger xCoord = (i * 60) + 50;
        //        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor greenColor].CGColor;
        button.backgroundColor = [UIColor greenColor];
        button.frame = CGRectMake(xCoord, 270.0, 50.0, 30.0);
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
