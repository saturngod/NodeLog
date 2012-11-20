//
//  ViewController.m
//  Realtimelog
//
//  Created by Htain Lin Shwe on 20/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "ViewController.h"
#import "nodeLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TEST");
    NodeLog(@"Testing %d",56);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendLog:(id)sender {
    NodeLog(@"Send to the server at %@",[NSDate date]);
}


@end
