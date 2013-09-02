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

#import "MSHmacSha256SignTests.h"
#import "MSHmacSha256Sign.h"

@implementation MSHmacSha256SignTests

- (void)setUp
{
    [super setUp];
    
    _subject = [[MSHmacSha256Sign alloc] initWithAccessKey: @"Buggy"];
    STAssertNotNil(_subject, @"Could not create MSHmacSha256Sign.");
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
