//
//  HTUncaughtExceptionHandle.h
//  HTCrashBlock
//
//  Created by ht on 2020/10/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTUncaughtExceptionHandle : NSObject

+ (void)installUncaughtSignalExceptionHandler;

@end

NS_ASSUME_NONNULL_END
