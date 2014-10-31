//
//  SKTextAttachment.m
//  SKTextView
//
//  Created by Shrek Wang on 10/31/14.
//
//

#import "SKTextAttachment.h"

@implementation SKTextAttachment

#pragma mark - override

- (id)initWithData:(NSData *)contentData ofType:(NSString *)uti {
    //FLOG(@"initWithData called");
    //FLOG(@"uti is %@", uti);
    self = [super initWithData:contentData ofType:uti];
    
    if (self) {
        if (self.image == nil) {
            //FLOG(@" self.image is nil");
            self.image = [UIImage imageWithData:contentData];
        } else {
            NSLog(@" self.image is NOT nil");
        }
    }
    return self;
}

@end
