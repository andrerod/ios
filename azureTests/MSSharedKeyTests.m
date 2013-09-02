/**
 * Copyright (c) Microsoft.  All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
    MSWebResource* webResource = [[MSWebResource alloc] init];
    webResource->httpVerb = @"get";
    webResource->httpVerb = @"container";
    [webResource->queryString setObject:@"restype" forKey:@"container"];
    [webResource->headers setObject:@"content-type" forKey:@""];
    [webResource->headers setObject:@"x-ms-version" forKey:@"2011-08-18"];
    [webResource->headers setObject:@"date" forKey:@"Fri, 23 Sep 2011 01:37:34 GMT"];

    [_subject signRequest:webResource];
    
    STAssertEqualObjects(@"SharedKey devstoreaccount1:Y5R86+6XE5MH602SIyjeTwlJuQjbawv20PT4kb/F/04=", [webResource->headers objectForKey:@"authorization"], @"the authorization header is not valid");
}

@end
