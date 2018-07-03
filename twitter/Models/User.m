//
//  User.m
//  twitter
//
//  Created by Nico Salinas on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        
        NSString *tempScreenName = dictionary[@"screen_name"];
        NSString *atSymbol = @"@";

        
        self.handle = [atSymbol stringByAppendingString:tempScreenName];
        
        // Initialize any other properties
    }
    return self;
}

@end
