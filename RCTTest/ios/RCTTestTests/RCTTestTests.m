//
//  RCTTestTests.m
//  RCTTestTests
//

//  Created by 童万华 on 2017/12/5.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TYNumberOperations.h"
#import "TestSortModel.h"
#import "OCMock.h"
@interface RCTTestTests : XCTestCase

@end

@implementation RCTTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//三个步骤(Given/When/Then)
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    
}

-(void)testNumberOperation {
    int a = 10;
    int b = 20;
    NSInteger sum = [TYNumberOperations sum:a b:b];
    XCTAssertEqual(sum, 30,@"两个整数相加的和相等");
}
-(void)testSelectSortDesciptor {
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@6,@4,@8,@2,nil];
    
    NSMutableArray *sortedArray = [TestSortModel selectSort:array];
    
    NSArray *expArray = @[@2,@4,@6,@8];
    XCTAssertEqualObjects(sortedArray,expArray,@"排序ok");
}
-(void)testBubbleSortDesciptor {
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@6,@4,@8,@2,nil];
    
    NSMutableArray *sortedArray = [TestSortModel bubbleSort:array];
    
    NSArray *expArray = @[@2,@4,@6,@8];
    XCTAssertEqualObjects(sortedArray,expArray,@"排序ok");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
       NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@6,@4,@8,@2,nil];
        [TestSortModel selectSort:array];
    }];
}

@end
