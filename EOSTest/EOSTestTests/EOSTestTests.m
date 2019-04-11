//
//  EOSTestTests.m
//  EOSTestTests
//
//  Created by iMac on 2019/2/28.
//  Copyright © 2019年 iMac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCTest.h"
#import "EOSTest-Swift.h"

@interface EOSTestTests : XCTestCase

@end

@implementation EOSTestTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    OCTest *test = [[OCTest alloc] init];
    [test test];
    
    SwiftTest *test1 = [[SwiftTest alloc] init];
    [test1 test];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testEOSPrivateKey {
    
}

@end
