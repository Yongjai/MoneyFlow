//
//  Outgoing.m
//  Money_Flow
//
//  Created by YongJai on 28/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "Outgoing.h"

@implementation Outgoing{
    RLMRealm *realm;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (!self) return nil;
//    
//    realm = [RLMRealm defaultRealm];
//    
//    return self;
//}

//- (NSString *)primaryKey {
//    return @"pk";
//}

- (void)outgoingAdd {
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:self];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OUTGOING_ADDED" object:nil];
    NSLog(@"added");
}

- (void)outgoingRemove {
    [realm transactionWithBlock:^{
        [realm deleteObject:self];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OUTGOING_REMOVED" object:nil];
}


@end
