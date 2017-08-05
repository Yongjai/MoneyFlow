//
//  OutgoingTableViewCell.h
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutgoingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *outgoingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *outgoingCategoryLabel;

@end
