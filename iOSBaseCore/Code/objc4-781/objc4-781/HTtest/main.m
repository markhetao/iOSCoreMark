//
//  main.m
//  HTtest
//
//  Created by asetku on 2020/9/11.
//

#import <Foundation/Foundation.h>
#import "HTPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        HTPerson * p1 = [HTPerson alloc];
        HTPerson * p2 = [p1 init];
        HTPerson * p3 = [p1 init];
        HTPerson * p4 = [HTPerson new];
        
        NSLog(@"%@ %p %p", p1, p1, &p1);
        NSLog(@"%@ %p %p", p2, p2, &p2);
        NSLog(@"%@ %p %p", p3, p3, &p3);
        NSLog(@"%@ %p %p", p4, p4, &p4);
    }
    return 0;
}
