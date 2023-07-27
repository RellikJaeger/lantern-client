// Objective-C API for talking to github.com/getlantern/android-lantern/internalsdk Go package.
//   gobind -lang=objc github.com/getlantern/android-lantern/internalsdk
//
// File is generated by gobind. Do not edit.

#ifndef __Internalsdk_H__
#define __Internalsdk_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"


@class InternalsdkValue;
@protocol InternalsdkDB;
@class InternalsdkDB;
@protocol InternalsdkModel;
@class InternalsdkModel;
@protocol InternalsdkQueryable;
@class InternalsdkQueryable;
@protocol InternalsdkResult;
@class InternalsdkResult;
@protocol InternalsdkRows;
@class InternalsdkRows;
@protocol InternalsdkTx;
@class InternalsdkTx;
@protocol InternalsdkValueArray;
@class InternalsdkValueArray;

@protocol InternalsdkDB <NSObject>
- (id<InternalsdkTx> _Nullable)begin:(NSError* _Nullable* _Nullable)error;
- (BOOL)close:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkModel <NSObject>
- (InternalsdkValue* _Nullable)invokeMethod:(NSString* _Nullable)method arguments:(id<InternalsdkValueArray> _Nullable)arguments error:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkQueryable <NSObject>
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkResult <NSObject>
/**
 * LastInsertId returns the integer generated by the database
in response to a command. Typically this will be from an
"auto increment" column when inserting a new row. Not all
databases support this feature, and the syntax of such
statements varies.
 */
- (BOOL)lastInsertId:(int64_t* _Nullable)ret0_ error:(NSError* _Nullable* _Nullable)error;
/**
 * RowsAffected returns the number of rows affected by an
update, insert, or delete. Not every database or database
driver may support this.
 */
- (BOOL)rowsAffected:(int64_t* _Nullable)ret0_ error:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkRows <NSObject>
- (BOOL)close:(NSError* _Nullable* _Nullable)error;
- (BOOL)next;
- (BOOL)scan:(id<InternalsdkValueArray> _Nullable)dest error:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkTx <NSObject>
- (BOOL)commit:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (BOOL)rollback:(NSError* _Nullable* _Nullable)error;
@end

@protocol InternalsdkValueArray <NSObject>
- (InternalsdkValue* _Nullable)get:(long)index;
- (long)len;
- (void)set:(long)index value:(InternalsdkValue* _Nullable)value;
@end

@interface InternalsdkValue : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
@property (nonatomic) long type;
@property (nonatomic) NSString* _Nonnull string;
@property (nonatomic) long int_;
@property (nonatomic) BOOL bool_;
@end

FOUNDATION_EXPORT const int64_t InternalsdkTypeBool;
FOUNDATION_EXPORT const int64_t InternalsdkTypeInt;
FOUNDATION_EXPORT const int64_t InternalsdkTypeString;

FOUNDATION_EXPORT id<InternalsdkModel> _Nullable InternalsdkNewModel(NSString* _Nullable name, id<InternalsdkDB> _Nullable mdb, NSError* _Nullable* _Nullable error);

@class InternalsdkDB;

@class InternalsdkModel;

@class InternalsdkQueryable;

@class InternalsdkResult;

@class InternalsdkRows;

@class InternalsdkTx;

@class InternalsdkValueArray;

@interface InternalsdkDB : NSObject <goSeqRefInterface, InternalsdkDB> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (id<InternalsdkTx> _Nullable)begin:(NSError* _Nullable* _Nullable)error;
- (BOOL)close:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
@end

@interface InternalsdkModel : NSObject <goSeqRefInterface, InternalsdkModel> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (InternalsdkValue* _Nullable)invokeMethod:(NSString* _Nullable)method arguments:(id<InternalsdkValueArray> _Nullable)arguments error:(NSError* _Nullable* _Nullable)error;
@end

@interface InternalsdkQueryable : NSObject <goSeqRefInterface, InternalsdkQueryable> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
@end

/**
 * Result is a duplicate of sql.Result to allow binding with gomobile
 */
@interface InternalsdkResult : NSObject <goSeqRefInterface, InternalsdkResult> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
/**
 * LastInsertId returns the integer generated by the database
in response to a command. Typically this will be from an
"auto increment" column when inserting a new row. Not all
databases support this feature, and the syntax of such
statements varies.
 */
- (BOOL)lastInsertId:(int64_t* _Nullable)ret0_ error:(NSError* _Nullable* _Nullable)error;
/**
 * RowsAffected returns the number of rows affected by an
update, insert, or delete. Not every database or database
driver may support this.
 */
- (BOOL)rowsAffected:(int64_t* _Nullable)ret0_ error:(NSError* _Nullable* _Nullable)error;
@end

@interface InternalsdkRows : NSObject <goSeqRefInterface, InternalsdkRows> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (BOOL)close:(NSError* _Nullable* _Nullable)error;
- (BOOL)next;
- (BOOL)scan:(id<InternalsdkValueArray> _Nullable)dest error:(NSError* _Nullable* _Nullable)error;
@end

@interface InternalsdkTx : NSObject <goSeqRefInterface, InternalsdkTx> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (BOOL)commit:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkResult> _Nullable)exec:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (id<InternalsdkRows> _Nullable)query:(NSString* _Nullable)query args:(id<InternalsdkValueArray> _Nullable)args error:(NSError* _Nullable* _Nullable)error;
- (BOOL)rollback:(NSError* _Nullable* _Nullable)error;
@end

@interface InternalsdkValueArray : NSObject <goSeqRefInterface, InternalsdkValueArray> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (InternalsdkValue* _Nullable)get:(long)index;
- (long)len;
- (void)set:(long)index value:(InternalsdkValue* _Nullable)value;
@end

#endif
