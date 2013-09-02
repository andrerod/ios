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

#import "MSHmacSha256Sign.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation MSHmacSha256Sign
-(id)initWithAccessKey: (NSString *)accessKey
{
    self = [super init];
    if (self) {
        self->_accessKey = accessKey;
        self->_decodedAccessKey = [NSString stringWithFormat:@"%@",[Base64 decode:accessKey]];
    }
    
    return self;
}

- (NSString *)sign: (NSString *)stringToSign {
    const char *cKey = [_decodedAccessKey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [stringToSign cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [Base64 encode:HMAC];
    
    NSLog(@"Encoded hash: %@", hash);
    return hash;
}

@end
