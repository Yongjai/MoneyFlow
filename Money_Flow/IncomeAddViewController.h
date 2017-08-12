//
//  IncomeAddViewController.h
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Income.h"


@interface IncomeAddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property NSArray *categoryArray;
@property Income *editSomething;
@property BOOL isEdit;

@end
