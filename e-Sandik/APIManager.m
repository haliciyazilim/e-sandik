//
//  APIManager.m
//  e-Sandik
//
//  Created by Eren Halici on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "APIManager.h"
#import "Voter.h"
#import "Neighbour.h"

@implementation APIManager

static APIManager *sharedInstance = nil;

#pragma mark - Singleton and init methods

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)init
{
    self = [super initWithHostName:@"bilisim.chp.org.tr"
                customHeaderFields:@{@"x-client-identifier" : @"iOS",
                                            @"Content-Type" : @"text/xml"}];
    
    if (self) {
        // Initialization code here.
        [self useCache];
    }
    
    return self;
}

+ (APIManager *)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark - Caching

- (NSString*) cacheDirectoryName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"eSandikAPICache"];
    return cacheDirectoryName;
}

#pragma mark - Helpers

- (NSString *)pathForOperation:(NSString *)operation {
    return [NSString stringWithFormat:@"MobilService.asmx?op=%@", operation];
}

- (NSString *)createSoapRequestForTckNo:(NSString *)tckNo {
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SandikYeriSorgula xmlns=\"http://tempuri.org/\"><tckn>%@</tckn></SandikYeriSorgula></soap:Body></soap:Envelope>",tckNo];
}

#pragma mark - Voters

- (MKNetworkOperation *)getVoterWithTckNo:(NSString *)tckNo
                             onCompletion:(VoterBlock)completionBlock
                                  onError:(ErrorBlock)errorBlock {

    if (tckNo == nil || [tckNo isEqualToString:@""]) {
        tckNo = @"17129369222";
    }
    
    MKNetworkOperation *op = [self operationWithPath:[self pathForOperation:@"SandikYeriSorgula"]
                                              params:@{@"xmlData" : [self createSoapRequestForTckNo:tckNo]}
                                          httpMethod:@"POST"];
    
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        return [postDataDict objectForKey:@"xmlData"];
    } forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *responseString = [completedOperation responseString];
        NSRange range1 = [responseString rangeOfString:@"<SandikYeriSorgulaResult>"];
        NSRange range2 = [responseString rangeOfString:@"</SandikYeriSorgulaResult>"];
        NSRange range = {NSMaxRange(range1), range2.location-range1.location-range2.length+1};
        NSData *responseJSON = [[responseString substringWithRange:range] dataUsingEncoding:NSUTF8StringEncoding];
 
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseJSON options:0 error:nil];
        if([[responseDictionary valueForKey:@"HataKodu"] integerValue] == 1){
            NSError *apiError = [NSError errorWithDomain:@"APIError"
                                                           code:-101
                                                       userInfo:@{NSLocalizedDescriptionKey : [responseDictionary valueForKey:@"HataAciklamasi"]}];
            errorBlock(apiError);
        }
        else{
            completionBlock([Voter voterFromDictionary:responseDictionary]);
        }
        DLog(@"%@", responseDictionary);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (error.domain == NSURLErrorDomain && error.code == -1009) {
            NSError *connectionError = [NSError errorWithDomain:@"ConnectionError"
                                                           code:-102
                                                       userInfo:@{NSLocalizedDescriptionKey : @"İnternet bağlantısı sağlanamadı, lütfen bağlantı ayarlarınızı kontrol ederek tekrar deneyiniz."}];
            errorBlock(connectionError);
        } else {
            NSLog(@"%@", error);
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
