//
//  MSHmacSha256Sign.h
//  azure
//
//  Created by André Rodrigues on 7/31/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSHmacSha256Sign : NSObject {
    NSString * accessKey;
    NSString * decodedAccessKey;
}

-(id)initWithAccessKey:(NSString *)accessKey_;
- (NSData *)sign:(NSString *)stringToSign;
@end
