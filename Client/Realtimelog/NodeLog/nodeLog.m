//
//  socketLog.m
//  Realtimelog
//
//  Created by Htain Lin Shwe on 20/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "nodeLog.h"

@interface nodeLog ()
@property (nonatomic,strong) GCDAsyncSocket* asyncSocket;
@end

@implementation nodeLog
@synthesize asyncSocket = _asyncSocket;

static nodeLog *shared = nil;

+ (nodeLog*)shared
{
    if (shared == nil) {
        shared = [[super alloc] init];
    }
    
    return shared;
}


-(id)init
{
    self = [super init];
    if(self)
    {
        _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError* err;
        if([self.asyncSocket connectToHost:LOG_SERVER_HOST onPort:LOG_SERVER_POST error:&err])
        {
            
        }
        else {
            NSLog(@"ERROR %@",[err description]);
        }

    }
    return self;
}

- (void)logFile:(char*)sourceFile lineNumber:(int)lineNumber
        format:(NSString*)format, ...;
{
	va_list ap;
	NSString *print,*file;

	va_start(ap,format);
	file=[[NSString alloc] initWithBytes:sourceFile
                                  length:strlen(sourceFile)
                                encoding:NSUTF8StringEncoding];
	print=[[NSString alloc] initWithFormat:format arguments:ap];
	va_end(ap);

	NSString* str = [NSString stringWithFormat:@"%s:%d %@",[[file lastPathComponent] UTF8String],lineNumber,print];
    
    [self.asyncSocket writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];

	return;
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    //no need to send data
    //so, it didn't add listen the socket
    NSLog(@"Connected");
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    //Write Data is done
}
@end
