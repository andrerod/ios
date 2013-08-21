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

-(void)signRequest: (MSWebResource *)webResource
{
    
}

/*
SharedKey.prototype.signRequest = function (webResource, callback) {
    var getvalueToAppend = function (value) {
        if (azureutil.objectIsNull(value)) {
            return '\n';
        } else {
            return value + '\n';
        }
    };
    
    var stringToSign =
    webResource.httpVerb + '\n' +
    getvalueToAppend(webResource.headers[HeaderConstants.CONTENT_ENCODING]) +
    getvalueToAppend(webResource.headers[HeaderConstants.CONTENT_LANGUAGE]) +
    getvalueToAppend(webResource.headers[HeaderConstants.CONTENT_LENGTH]) +
    getvalueToAppend(webResource.headers[HeaderConstants.CONTENT_MD5]) +
    getvalueToAppend(webResource.headers[HeaderConstants.CONTENT_TYPE]) +
    getvalueToAppend(webResource.headers[HeaderConstants.DATE]) +
    getvalueToAppend(webResource.headers[HeaderConstants.IF_MODIFIED_SINCE]) +
    getvalueToAppend(webResource.headers[HeaderConstants.IF_MATCH]) +
    getvalueToAppend(webResource.headers[HeaderConstants.IF_NONE_MATCH]) +
    getvalueToAppend(webResource.headers[HeaderConstants.IF_UNMODIFIED_SINCE]) +
    getvalueToAppend(webResource.headers[HeaderConstants.RANGE]) +
    this._getCanonicalizedHeaders(webResource) +
    this._getCanonicalizedResource(webResource);
    
    var signature = this.signer.sign(stringToSign);
    
    webResource.withHeader(HeaderConstants.AUTHORIZATION, 'SharedKey ' + this.storageAccount + ':' + signature);
    callback(null);
};

SharedKey.prototype._getCanonicalizedResource = function (webResource) {
    var path = '/';
    if (webResource.path) {
        path = webResource.path;
    }
    
    var canonicalizedResource = '/' + this.storageAccount + path;
    
    // Get the raw query string values for signing
    var queryStringValues = webResource.queryString;
    
    // Build the canonicalized resource by sorting the values by name.
    if (queryStringValues) {
        var paramNames = [];
        Object.keys(queryStringValues).forEach(function (n) {
            paramNames.push(n);
        });
        
        paramNames = paramNames.sort();
        Object.keys(paramNames).forEach(function (name) {
            canonicalizedResource += '\n' + paramNames[name] + ':' + queryStringValues[paramNames[name]];
        });
    }
    
    return canonicalizedResource;
};

SharedKey.prototype._getCanonicalizedHeaders = function (webResource) {
    // Build canonicalized headers
    var canonicalizedHeaders = '';
    if (webResource.headers) {
        var canonicalizedHeadersArray = [];
        for (var header in webResource.headers) {
            if (header.indexOf(HeaderConstants.PREFIX_FOR_STORAGE_HEADER) === 0) {
                canonicalizedHeadersArray.push(header);
            }
        }
        
        canonicalizedHeadersArray.sort();
        
        _.each(canonicalizedHeadersArray, function (currentHeader) {
            canonicalizedHeaders += currentHeader.toLowerCase() + ':' + webResource.headers[currentHeader] + '\n';
        });
    }
    
    return canonicalizedHeaders;
};
 
 */

@end
