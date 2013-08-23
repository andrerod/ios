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

- (void)testSign
{
    MSWebResource* webResource = [MSWebResource alloc];
    [webResource->headers setObject:@"value" forKey:@"x-ms-header"];
    [webResource->headers setObject:@"value" forKey:@"Content-Type"];

    NSString *canonicalizedResources = [_subject getCanonicalizedHeaders: webResource];

    STAssertEqualObjects(@"xxMmN2Ykt5fbCFfXhPKIyYvar4fRlTxUGBx0C9BpkgU=", canonicalizedResources, @"the canonicalized headers did not match");
}

@end
