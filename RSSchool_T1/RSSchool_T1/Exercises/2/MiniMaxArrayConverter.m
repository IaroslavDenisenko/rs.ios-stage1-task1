#import "MiniMaxArrayConverter.h"

@implementation MiniMaxArrayConverter

// Complete the convertFromArray function below.
- (NSArray<NSNumber*>*)convertFromArray:(NSArray<NSNumber*>*)array {
    
    NSMutableArray *sumArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        NSInteger sum = 0;
        
        for (NSNumber *number in array) {
            
            if ([array indexOfObject:number] != i) {
                sum += [number intValue];
            }
        }
        
        [sumArray addObject:[NSNumber numberWithLong:sum]];
    }
    
    [sumArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSArray *result = @[sumArray.firstObject, sumArray.lastObject];
    
    return result;
}

@end
