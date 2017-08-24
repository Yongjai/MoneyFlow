//
//  Income.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "Income.h"

@implementation Income {
    RLMRealm *realm;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    realm = [RLMRealm defaultRealm];
    
    return self;
}

+ (NSString *)primaryKey {
    return @"uuid";
}

- (void)incomeAdd {
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:self];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"INCOME_ADDED" object:nil];
}

- (void)incomeRemove {
    [realm transactionWithBlock:^{
        [realm deleteObject:self];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"INCOME_REMOVED" object:nil];
    
}


@end
