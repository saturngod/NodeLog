//
//  socketLog.h
//  Realtimelog
//
//  Created by Htain Lin Shwe on 20/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeLogConfig.h"
#import "GCDAsyncSocket.h"

@interface nodeLog : NSObject <GCDAsyncSocketDelegate>
+(id)shared;
-(void)logFile:(char*)sourceFile lineNumber:(int)lineNumber
        format:(NSString*)format, ...;
@end


#ifdef DEBUG
#define NodeLog(s,...) \
[[nodeLog shared] logFile:__FILE__ lineNumber:__LINE__ \
format:(s),##__VA_ARGS__]
#else
#define NodeLog(s,...)
#endif