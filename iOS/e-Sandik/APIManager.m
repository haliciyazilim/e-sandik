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

- (MKNetworkOperation *)createNetworkOperationForOperation:(NSString *)operationName
                                             andParameters:(NSDictionary *)parameters
                                              onCompletion:(CompletionBlock)completionBlock
                                                   onError:(ErrorBlock)errorBlock {
    __block NSString *parametersString = @"";
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        parametersString = [parametersString stringByAppendingFormat:@"<%@>%@</%@>", key, obj, key];
        stop = NO;
    }];
    
    
    NSString *xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><%@ xmlns=\"http://tempuri.org/\">%@</%@></soap:Body></soap:Envelope>", operationName, parametersString, operationName];
    
    
    
    MKNetworkOperation *op = [self operationWithPath:[self pathForOperation:operationName]
                                              params:@{@"xmlData" : xmlString}
                                          httpMethod:@"POST"];
    
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        return [postDataDict objectForKey:@"xmlData"];
    }
                                 forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *responseDictionary = [self getDictionaryFromResponse:[completedOperation responseString]
                                                              forOperation:operationName];
        
        if([[responseDictionary valueForKey:@"hataKodu"] integerValue] == 1){
            NSError *apiError = [NSError errorWithDomain:@"APIError"
                                                    code:-101
                                                userInfo:@{NSLocalizedDescriptionKey : [responseDictionary valueForKey:@"hataAciklamasi"]}];
            errorBlock(apiError);
        }
        else{
            completionBlock(responseDictionary);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (error.domain == NSURLErrorDomain && error.code == -1009) {
            NSError *connectionError = [NSError errorWithDomain:@"ConnectionError"
                                                           code:-102
                                                       userInfo:@{NSLocalizedDescriptionKey : @"İnternet bağlantısı sağlanamadı, ayarlarınızı kontrol ederek tekrar deneyiniz."}];
            errorBlock(connectionError);
        } else {
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:op];
    return op;
}

- (NSDictionary *) getDictionaryFromResponse:(NSString *)response
                                forOperation:(NSString *)operation {
    NSRange range1 = [response rangeOfString:[NSString stringWithFormat:@"<%@Result>", operation]];
    NSRange range2 = [response rangeOfString:[NSString stringWithFormat:@"</%@Result>", operation]];
    NSRange range = {NSMaxRange(range1), range2.location-range1.location-range2.length+1};
    NSData *responseJSON = [[response substringWithRange:range] dataUsingEncoding:NSUTF8StringEncoding];
    
    id responseObject = [NSJSONSerialization JSONObjectWithData:responseJSON options:0 error:nil];
    
    if (!responseObject) {
        return @{ @"hataKodu" : @"1",
                  @"hataAciklamasi" : [NSString stringWithFormat:@"Result is not a proper JSON object. It is: %@", [response substringWithRange:range]]};
    }
    
    if ([responseObject isKindOfClass:[NSArray class]]) {
        return @{ @"hataKodu" : @"0",
                  @"result" : responseObject };
    } else {
        if ([responseObject objectForKey:@"HataKodu"]) {
            return @{ @"hataKodu" : @"1",
                      @"hataAciklamasi" : [responseObject objectForKey:@"HataAciklamasi"],
                      @"result" : responseObject};
        } else {
            return @{ @"hataKodu" : @"0",
                      @"result" : responseObject};
        }
    }
}


- (NSString *)createSoapRequestForTckNo:(NSString *)tckNo {
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SandikYeriSorgula xmlns=\"http://tempuri.org/\"><tckn>%@</tckn></SandikYeriSorgula></soap:Body></soap:Envelope>",tckNo];
}

#pragma mark - Voters

- (MKNetworkOperation *)loginWithTckNo:(NSString *)tckNo
                           andPassword:(NSString *)password
                          onCompletion:(LoginBlock)loginBlock
                               onError:(ErrorBlock)errorBlock {
    if ([tckNo characterAtIndex:0] == '0') {
        tckNo = [tckNo substringFromIndex:1];
    }
    
    return [self createNetworkOperationForOperation:@"ESANDIK_Login"
                                      andParameters:@{@"telNo_TCKN" : tckNo,
                                                      @"Sifre" : password  }
                                       onCompletion:^(NSDictionary *responseDictionary) {
                                           if ([responseDictionary[@"result"][@"LoginDurumu"] boolValue] == true) {
                                               loginBlock([responseDictionary[@"result"][@"TCKN"] stringValue]);
                                           } else {
                                               errorBlock([NSError errorWithDomain:@"LoginError"
                                                                              code:-110
                                                                          userInfo:@{NSLocalizedDescriptionKey : @"Hatalı kullanıcı adı veya şifre girdiniz. Lütfen tekrar deneyin."}]);
                                           }
                                       }
                                            onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
}

- (MKNetworkOperation *)getVoterWithTckNo:(NSString *)tckNo
                             onCompletion:(VoterBlock)completionBlock
                                  onError:(ErrorBlock)errorBlock {

    if (tckNo == nil || [tckNo isEqualToString:@""]) {
        tckNo = @"00000000000";
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
                                                       userInfo:@{NSLocalizedDescriptionKey : @"İnternet bağlantısı sağlanamadı, ayarlarınızı kontrol ederek tekrar deneyiniz."}];
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
