//
//  MSWebResource.m
//  azure
//
//  Created by André Rodrigues on 8/21/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "MSWebResource.h"

@implementation MSWebResource
- (id)init
{
    self = [super init];
    if (self)
    {
        self->headers = [[NSMutableDictionary alloc] init];
    }
    return self;
}
@end
