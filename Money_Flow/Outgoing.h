//
//  Outgoing.h
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

@interface Outgoing : RLMObject

@property NSString *uuid;
@property NSDate* time;
@property NSInteger price;
@property NSString* category;

- (void)outgoingAdd;
- (void)outgoingRemove;

@end
