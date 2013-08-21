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
    
    _subject = [[MSSharedKey alloc] initWithAccount: @"account" AndAccessKey: @"accesskey";
    STAssertNotNil(_subject, @"Could not create MSSharedKey.");
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSign
{
    NSString *result = [_subject sign :@"DELETE\n\n0\n\n\n\n\n\n\n\n\nx-ms-date:Thu, 01 Aug 2013 13:49:05 GMTx-ms-version:2012-02-12\n/ciserversdk/cont1\nrestype:container"];
    
    STAssertEqualObjects(@"xxMmN2Ykt5fbCFfXhPKIyYvar4fRlTxUGBx0C9BpkgU=", result, @"the signatures did not match");
}

@end
