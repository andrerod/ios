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

#import "MSSharedKey.h"

@implementation MSSharedKey
-(id)initWithAccount: (NSString *)account AndAccessKey: accessKey
{
    self = [super init];
    if (self) {
        self->_account = account;
        self->_accessKey = accessKey;
        
        self->_signer = [[MSHmacSha256Sign alloc] initWithAccessKey: accessKey];
    }
    
    return self;
}

-(NSString *)getValueToAppend: (NSString *)header
{
    if (header != nil) {
        return [NSString stringWithFormat:@"%@\n", header];
    }

    return @"\n";
}

-(void)signRequest: (MSWebResource *)webResource
{
    // TODO: fix issue with casing for header names
    NSString * stringToSign = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@%@",
                               webResource->httpVerb,
                               [self getValueToAppend:[webResource->headers objectForKey:@"content-encoding"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"content-language"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"content-length"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"content-md5"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"content-type"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"if-modified-since"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"if-match"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"if-none-match"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"if-unmodified-since"]],
                               [self getValueToAppend:[webResource->headers objectForKey:@"range"]],
                               [self getCanonicalizedHeaders:webResource],
                               [self getCanonicalizedResource:webResource]];
    
    NSString * signature = [self->_signer sign:stringToSign];
    
    [webResource->headers setObject:@"authorization" forKey:[NSString stringWithFormat:@"SharedKey %@:%@",
                                                             self->_account, signature]];
}

-(NSString *)getCanonicalizedResource: (MSWebResource *)webResource
{
    NSString * path = @"/";
    if (webResource->path != nil && webResource->path.length > 0) {
        path = webResource->path;
    }
    
    NSString * canonicalizedResource = [NSString stringWithFormat:@"/%@%@", self->_account, path];
    
    // Get the raw query string values for signing
    if (webResource->queryString != nil) {
        NSMutableArray *queryStringValues = [NSMutableArray array];
        
        // Build the canonicalized resource by sorting the values by name.
        for(NSString * queryOption in webResource->queryString)
        {
            [queryStringValues addObject:queryOption];
        }
        
        [queryStringValues sortUsingSelector:@selector(compare:)];
        
        for (NSString * queryOption in queryStringValues)
        {
            canonicalizedResource = [canonicalizedResource stringByAppendingString: [NSString stringWithFormat:@"\n%@:%@", [queryOption lowercaseString], [webResource->queryString objectForKey:queryOption]]];
        }
    }
    
    return canonicalizedResource;
}

-(NSString *)getCanonicalizedHeaders: (MSWebResource *)webResource
{
    NSMutableArray *canonicalizedHeadersArray = [NSMutableArray array];
    
    for(NSString * header in webResource->headers)
    {
        if([header hasPrefix:@"x-ms-"]) {
            [canonicalizedHeadersArray addObject:header];
        }
    }
    
    [canonicalizedHeadersArray sortUsingSelector:@selector(compare:)];
    
    NSString *canonicalizedHeaders = @"";
    for (NSString * header in canonicalizedHeadersArray)
    {
        canonicalizedHeaders = [canonicalizedHeaders stringByAppendingString: [NSString stringWithFormat:@"%@:%@\n", [header lowercaseString], [[webResource->headers objectForKey:header] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
    }
    
    return canonicalizedHeaders;
}
@end
