#import "Parser.h"

@implementation Parser

// Complete the parseString function below.
- (NSArray <NSString*>*)parseString:(NSString*)string {
    
    NSMutableArray *strings = [NSMutableArray array];
    
    NSMutableArray *openTagRanges        = [self matchRangesOfString:string forPattern:@"<"];
    NSMutableArray *closeTagRanges       = [self matchRangesOfString:string forPattern:@">"];
    NSMutableArray *openParenthesRanges  = [self matchRangesOfString:string forPattern:@"\\("];
    NSMutableArray *closeParenthesRanges = [self matchRangesOfString:string forPattern:@"\\)"];
    NSMutableArray *openBracketRanges    = [self matchRangesOfString:string forPattern:@"\\["];
    NSMutableArray *closeBracketRanges   = [self matchRangesOfString:string forPattern:@"\\]"];

    
    NSArray *tagStrings       = [self stringWithOpenRanges:openTagRanges
                                            andCloseRanges:closeTagRanges
                                                  ofString:string];
    
    NSArray *parenthesStrings = [self stringWithOpenRanges:openParenthesRanges
                                            andCloseRanges:closeParenthesRanges
                                                  ofString:string];
    
    NSArray *bracketStrings   = [self stringWithOpenRanges:openBracketRanges
                                            andCloseRanges:closeBracketRanges
                                                  ofString:string];
    
    [strings addObjectsFromArray:tagStrings];
    [strings addObjectsFromArray:parenthesStrings];
    [strings addObjectsFromArray:bracketStrings];
    
    [strings sortUsingComparator:^NSComparisonResult(NSString *string1, NSString * string2) {
        
        NSUInteger range1 = [string rangeOfString:string1].location;
        NSUInteger range2 = [string rangeOfString:string2].location;
        
        if (range1 > range2) {
            
            return NSOrderedDescending;
        }
        if (range1 < range2) {
            
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];

    return [strings copy];
}

- (NSMutableArray <NSValue *> *)matchRangesOfString:(NSString *)string forPattern:(NSString *)pattern {
    
    NSMutableArray *ranges = nil;
    
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];
    if (error) {
        
        NSLog(@"Couldn't create regex with given string and options");
        
    } else {
        
        NSArray *matches = [regex matchesInString:string
                                          options:0
                                            range:NSMakeRange(0, [string length])];

        if (matches) {
            
            ranges = [NSMutableArray array];
            
            for (NSTextCheckingResult *match in matches) {

                 NSRange matchRange = [match range];
                
                [ranges addObject:[NSValue valueWithRange:matchRange]];
            }
            
        } else {

            NSLog(@"No matches for pattern %@", pattern);
            
        }
    }
    return ranges;
}


- (NSArray <NSString *> *)stringWithOpenRanges:(NSMutableArray <NSValue *> *)openRanges
                    andCloseRanges:(NSMutableArray <NSValue *> *)closeRanges
                          ofString:(NSString *)string {
    
    NSMutableArray *strings = [NSMutableArray array];
    
    if (openRanges && closeRanges) {
        
        for (NSValue *closeRange in closeRanges) {
            
            NSUInteger closeRangeLocation = [closeRange rangeValue].location;
            
            for (NSInteger i = openRanges.count - 1; i >= 0; i--) {
                
                NSUInteger openRangeLocation = [openRanges[i] rangeValue].location;
                
                if (openRangeLocation < closeRangeLocation) {
                    
                    NSRange stringRange = NSMakeRange(openRangeLocation + 1, closeRangeLocation - openRangeLocation - 1);
                    
                    NSString *resultString = [string substringWithRange:stringRange];
                    
                    [strings addObject:resultString];
                    
                    [openRanges removeObjectAtIndex:i];
                    
                    break;
                }
            }
        }
    }
    
    return [strings copy];
}

@end
