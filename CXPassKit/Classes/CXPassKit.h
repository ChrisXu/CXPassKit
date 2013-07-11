//
//  CXPassKit.h
//  
//
//  Created by ChrisXu on 13/7/2.
//
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

typedef void (^downloadCompelectionBlock)(BOOL success,NSString *msg);

@interface CXPassKit : NSObject

+ (PKPass *)passInDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (PKPass *)passInPassBookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

+ (NSArray *)passesInDocument;
+ (NSArray *)passesInPassBook;

+ (BOOL)hasPassFileAtDocumentWithPassTypeIdentifier:(NSString *)passTypeIdentifier;
+ (BOOL)hasPassInPassbookWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

+ (void)downloadWithPassTypeIdentifier:(NSString *)passTypeIdentifier fromURL:(NSURL *)url compelectionBlock:(downloadCompelectionBlock)block;

+ (void)presentPassWithPassTypeIdentifier:(NSString *)passTypeIdentifier delegateViewController:(UIViewController *)delegateVC;

+ (void)removePassWithPassTypeIdentifier:(NSString *)passTypeIdentifier;

@end
