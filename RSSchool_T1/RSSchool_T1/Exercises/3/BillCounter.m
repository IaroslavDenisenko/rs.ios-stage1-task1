#import "BillCounter.h"

@implementation BillCounter

// Complete the following fuction
- (NSString*)compareResultForBill:(NSArray<NSNumber*>*)bill notIncludingElementWithIndex:(NSInteger)index withGivenSum:(NSNumber*)sum {
    
    NSInteger itemKCost = [bill[index] integerValue];
    
    NSInteger summ = 0;
    
    for (NSNumber *number in bill) {
        
        summ += [number integerValue];
    }
    
    NSInteger annasPay = (summ - itemKCost) / 2;
    
    NSString *result = nil;
    
    NSInteger refund = [sum integerValue] - annasPay;
    
    if ( refund == 0) {
        
        result = @"Bon Appetit";
        
    } else {

        result = [NSString stringWithFormat:@"%ld", refund];
    }
    
    return result;
}

@end
