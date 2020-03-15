#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    
    int count = [n intValue];
    int maxChanges = [k intValue];
    int indexLeft = 0;
    int indexRight = count - 1;
    int diffNumber = 0;
    
    NSMutableString *string = [s mutableCopy];
    
    for (int i = indexLeft, j = indexRight; j >= i; i++, j--) {
        
        if ([s characterAtIndex:i] != [s characterAtIndex:j]) {
            
            diffNumber++;
        }
    }
    
    if (diffNumber > maxChanges) {
        
        return @"-1";
    }
    
    for (int i = indexLeft, j = indexRight; j >= i; i++, j--) {
        
        
        if (maxChanges <= 0) {
            
            break;
        }
        
        if ([s characterAtIndex:i] == [s characterAtIndex:j]) {
            
            if (maxChanges > 1 && maxChanges - 2 >= diffNumber && [s characterAtIndex:i] != '9') {
                
                [string replaceCharactersInRange:NSMakeRange(i, 1) withString:@"9"];
                [string replaceCharactersInRange:NSMakeRange(j, 1) withString:@"9"];
                maxChanges -= 2;
            }
            
        } else {
            
            if (maxChanges > 1 && maxChanges - 2 >= diffNumber - 1) {
            
                if ([s characterAtIndex:i] != '9') {
                    
                    [string replaceCharactersInRange:NSMakeRange(i, 1) withString:@"9"];
                    maxChanges--;
                }
                if ([s characterAtIndex:j] != '9') {
                    
                    [string replaceCharactersInRange:NSMakeRange(j, 1) withString:@"9"];
                    maxChanges--;
                }
                
            } else {
                
                char maximum = MAX([s characterAtIndex:i], [s characterAtIndex:j]);
                NSString *maxValue = [NSString stringWithFormat:@"%c", maximum];
                [string replaceCharactersInRange:NSMakeRange(i, 1) withString:maxValue];
                [string replaceCharactersInRange:NSMakeRange(j, 1) withString:maxValue];
                maxChanges--;
            }
            
            diffNumber--;
        }
        
        if (i == j && maxChanges > 0) {
            
            [string replaceCharactersInRange:NSMakeRange(j, 1) withString:@"9"];
            maxChanges--;
        }
    }
    
    return [string copy];
}

@end
