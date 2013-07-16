//
//  CXPassKit.m
//  
//
//  Created by ChrisXu on 13/7/2.
//
//

#import "CXPassKit.h"
#import "AFHTTPRequestOperation.h"

@interface CXPassKit ()

@end

@implementation CXPassKit
+ (PKPass *)passInDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier
{
    if ([PKPassLibrary isPassLibraryAvailable])
    {
        NSString *path = [passTypeIdentifier stringByAppendingString:@".pkpass"];
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSData *data = [NSData dataWithContentsOfFile:[documentPath stringByAppendingPathComponent:path]];
        
        NSError *error = nil;
        
        PKPass *pass = [[PKPass alloc] initWithData:data error:&error];
        
        return (error == nil) ? pass : nil;
    }
    else
    {
        return nil;
    }
}

+ (PKPass *)passInPassBookWithPassTypeIdentifier:(NSString *)passTypeIdentifier
{
    if ([PKPassLibrary isPassLibraryAvailable])
    {
        PKPass *tPass = nil;
        for (PKPass *pass in [CXPassKit passesInPassBook])
        {
            if ([pass.passTypeIdentifier isEqualToString:passTypeIdentifier])
            {
                tPass = pass;
                return tPass;
            }
        }
    }
    return nil;
}

+ (NSArray *)passesInDocument
{
    NSMutableArray *passes = [NSMutableArray array];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *passFiles = [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:documentPath
                          error:nil];
    
    //3 loop over the resource files
    for (NSString* passFile in passFiles) {
        if ( [passFile hasSuffix:@".pkpass"] ) {
            [passes addObject: passFile];
        }
    }
    
    return passes;
}

+ (NSArray *)passesInPassBook
{
    PKPassLibrary *passLib = [[PKPassLibrary alloc] init];
    
    return [passLib passes];
}

+ (BOOL)hasPassFileAtDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier
{
    NSString *path = [passTypeIdentifier stringByAppendingString:@".pkpass"];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSData *data = [NSData dataWithContentsOfFile:[documentPath stringByAppendingPathComponent:path]];
    
    NSError *error = nil;
    
    return (data != nil);
}

+ (BOOL)hasPassInPassbookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
{
    return ([CXPassKit passInPassBookWithPassTypeIdentifier:passTypeIdentifier] != nil);
}

+ (void)downloadWithPassTypeIdentifier:(NSString *)passTypeIdentifier fromURL:(NSURL *)url compelectionBlock:(downloadCompelectionBlock)block;
{
    if (passTypeIdentifier == nil || url == nil)
    {
        if (block)
        {
            block(NO,@"missing input.");
        }
        return;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pkpass",passTypeIdentifier]];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block)
        {
            NSString *msg = [NSString stringWithFormat:@"Success to download pass from:%@",url];
            block(YES,msg);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *msg = [NSString stringWithFormat:@"Failure to download pass from:%@",url];
        block(NO,msg);
    }];
    
    [operation start];
}

+ (void)presentPassWithPassTypeIdentifier:(NSString *)passTypeIdentifier delegateViewController:(UIViewController *)delegateVC;
{
    if ([PKPassLibrary isPassLibraryAvailable] && delegateVC && passTypeIdentifier)
    {
        NSString *path = [NSString stringWithFormat:@"%@.pkpass",passTypeIdentifier];
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSData *data = [NSData dataWithContentsOfFile:[documentPath stringByAppendingPathComponent:path]];
        NSError *error;
        
        if (data)
        {
            PKPass *pass = [[PKPass alloc] initWithData:data error:&error];
            
            if (pass)
            {
                PKAddPassesViewController *vc = [[PKAddPassesViewController alloc] initWithPass:pass];
                [vc setDelegate:(id)delegateVC];
                [delegateVC presentViewController:vc animated:YES completion:nil];
            }
        }
    }
}

+ (void)removePassWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
{
    //init a pass library
    PKPassLibrary* passLib = [[PKPassLibrary alloc] init];
    
    [passLib removePass:[CXPassKit passInPassBookWithPassTypeIdentifier:passTypeIdentifier]];    
}

@end
