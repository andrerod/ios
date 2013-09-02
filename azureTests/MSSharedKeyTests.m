//
//  MSSharedKeyTests.m
//  azure
//
//  Created by André Rodrigues on 8/21/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "MSSharedKeyTests.h"

@implementation MSSharedKeyTests

- (void)setUp
{
    [super setUp];
    
    _subject = [[MSSharedKey alloc] initWithAccount: @"account" AndAccessKey: @"accesskey"];
    STAssertNotNil(_subject, @"Could not create MSSharedKey.");
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGetCanonicalizedHeaders
{
    MSWebResource* webResource = [[MSWebResource alloc] init];
    [webResource->headers setObject:@"value1" forKey:@"x-ms-header"];
    [webResource->headers setObject:@"value2" forKey:@"Content-Type"];

    NSString *canonicalizedResources = [_subject getCanonicalizedHeaders: webResource];

    STAssertEqualObjects(@"x-ms-header:value1\n", canonicalizedResources, @"the canonicalized headers did not match");
}

@end
