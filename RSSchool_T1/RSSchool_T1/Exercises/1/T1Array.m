#import "T1Array.h"

@implementation T1Array

// Complete the following fuction
- (NSArray *)convertToHappy:(NSArray *)sadArray {
    
    if (sadArray.count > 2) {
    
        NSMutableArray *mutableArray = [sadArray mutableCopy];
        
        for (int i = 1; i < mutableArray.count - 1; i++) {
            
            if ([mutableArray[i] intValue] > [mutableArray[i-1] intValue] + [mutableArray [i+1] intValue]) {
                
                [mutableArray removeObjectAtIndex:i];
                
                i = 1;
            }
        }
        
        NSArray *newArray = [mutableArray copy];
        
        return newArray;
    }
    
    return sadArray;
}

@end
