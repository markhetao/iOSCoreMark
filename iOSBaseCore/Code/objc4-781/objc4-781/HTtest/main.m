//
//  main.m
//  HTtest
//
//  Created by asetku on 2020/9/11.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

// HTPerson本类
@interface HTPerson : NSObject

@property (nonatomic, copy) NSString *ht_name;
@property (nonatomic, assign) int ht_age;

- (void)ht_func1;
- (void)ht_func3;
- (void)ht_func2;

+ (void)ht_classFunc;

@end

@implementation HTPerson

+ (void)load { NSLog(@"%s",__func__); };

- (void)ht_func1 { NSLog(@"%s",__func__); };
- (void)ht_func3 { NSLog(@"%s",__func__); };
- (void)ht_func2 { NSLog(@"%s",__func__); };

+ (void)ht_classFunc { NSLog(@"%s",__func__); };

@end

// HTPerson CatA分类
@interface HTPerson (CatA)

@property (nonatomic, copy) NSString * catA_name;
@property (nonatomic, copy) NSString * catA_age;

- (void)catA_func1;
- (void)catA_func3;
- (void)catA_func2;

+ (void)catA_classFunc;

@end

@implementation HTPerson(CatA)

- (void)catA_func1 { NSLog(@"%s",__func__); };
- (void)catA_func3 { NSLog(@"%s",__func__); };
- (void)catA_func2 { NSLog(@"%s",__func__); };

+ (void)catA_classFunc { NSLog(@"%s",__func__); };

+ (void)load { NSLog(@"%s",__func__); };

@end

// HTPerson CatB分类
@interface HTPerson (CatB)

@property (nonatomic, copy) NSString * catB_name;
@property (nonatomic, copy) NSString * catB_age;

- (void)catB_func1;
- (void)catB_func3;
- (void)catB_func2;

+ (void)catB_classFunc;

@end

@implementation HTPerson(CatB)

- (void)catB_func1 { NSLog(@"%s",__func__); };
- (void)catB_func3 { NSLog(@"%s",__func__); };
- (void)catB_func2 { NSLog(@"%s",__func__); };

+ (void)catB_classFunc { NSLog(@"%s",__func__); };

+ (void)load { NSLog(@"%s",__func__); };

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        HTPerson * person = [HTPerson alloc];

    }
    return 0;
}
