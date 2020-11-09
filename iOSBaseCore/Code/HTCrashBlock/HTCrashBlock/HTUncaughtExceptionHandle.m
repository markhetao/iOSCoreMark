//
//  HTUncaughtExceptionHandle.m
//  HTCrashBlock
//
//  Created by ht on 2020/10/18.
//

#import "HTUncaughtExceptionHandle.h"

@implementation HTUncaughtExceptionHandle

/// 创建崩溃回调函数
void LGExceptionHandlers(NSException *exception) {
    NSLog(@" **** 崩溃回调 ****");
    NSLog(@"%s",__func__);
}

// 设置crash回调函数
+ (void)installUncaughtSignalExceptionHandler {
    
    NSSetUncaughtExceptionHandler(&LGExceptionHandlers);
    
}

@end
