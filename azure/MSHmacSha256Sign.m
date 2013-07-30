//
//  MSHmacSha256Sign.m
//  azure
//
//  Created by André Rodrigues on 7/31/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "MSHmacSha256Sign.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation MSHmacSha256Sign
-(id)initWithAccessKey:(NSString *)accessKey_
{
    self = [super init];
    if (self) {
        self->accessKey = accessKey_;
        
        // TODO: encode to base64
        self->decodedAccessKey = accessKey_;
    }

    return self;
}

- (NSData *) sign:(NSString *) stringToSign {
    const char *cKey  = [accessKey cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [stringToSign cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    return [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
}

/*
 function HmacSha256Sign(accessKey) {
 this._accessKey = accessKey;
 this._decodedAccessKey = new Buffer(this._accessKey, 'base64');
 }
 
 HmacSha256Sign.prototype.sign = function (stringToSign) {
 // Encoding the Signature
 // Signature=Base64(HMAC-SHA256(UTF8(StringToSign)))
 
 return crypto.createHmac('sha256', this._decodedAccessKey).update(stringToSign, 'utf-8').digest('base64');
 };
}
*/

@end
