//
//  CXPassKit.h
//  
//
//  Created by ChrisXu on 13/7/2.
//
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

typedef void (^downloadCompletionBlock)(BOOL success,NSString *msg);
typedef void (^presentCompletionBlock)(BOOL success,NSString *msg, NSError *error);

@interface CXPassKit : NSObject

+ (PKPass *)passInDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (PKPass *)passInPassBookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

+ (NSArray *)passesInDocument;
+ (NSArray *)passesInPassBook;

+ (BOOL)hasPassFileAtDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (BOOL)hasPassInPassbookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

+ (void)downloadWithPassTypeIdentifier:(NSString *)passTypeIdentifier fromURL:(NSURL *)url completion:(downloadCompletionBlock)block;

+ (void)presentPassWithPassTypeIdentifier:(NSString *)passTypeIdentifier delegateViewController:(UIViewController *)delegateVC completion:(presentCompletionBlock)block;

+ (void)removePassWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

@end
