//
//  EntireCardViewController.h
//  Money_Flow
//
//  Created by YongJai on 19/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntireCardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//@property (weak, nonatomic) NSMutableDictionary *incomeDataArr;
//@property (weak, nonatomic) NSMutableDictionary *outgoingDataArr;

@property (nonatomic) BOOL isOutgoing;

@end
