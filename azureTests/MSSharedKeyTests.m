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

- (void)testGetCanonicalizedResource
{
    
}

- (void)testSignRequest
{
    /*
    var webResource = WebResource.get('container');
    webResource.withQueryOption(QueryStringConstants.RESTYPE, 'container');
    webResource.withHeader(HeaderConstants.CONTENT_TYPE, '');
    webResource.withHeader(HeaderConstants.STORAGE_VERSION_HEADER, HeaderConstants.TARGET_STORAGE_VERSION);
    webResource.withHeader(HeaderConstants.DATE_HEADER, 'Fri, 23 Sep 2011 01:37:34 GMT');
    
    sharedkey.signRequest(webResource, function () {
        assert.equal(webResource.headers[HeaderConstants.AUTHORIZATION], 'SharedKey devstoreaccount1:Y5R86+6XE5MH602SIyjeTwlJuQjbawv20PT4kb/F/04=');

        */
}

@end
