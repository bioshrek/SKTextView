//
//  SKTextView.m
//  SKTextView
//
//  Created by Shrek Wang on 10/31/14.
//
//

#import "SKTextView.h"

#import "SKTextAttachment.h"

@interface SKTextView () <NSTextStorageDelegate>

@end

@implementation SKTextView

#pragma mark - life cycle

#pragma mark - NSTextStorageDelegate

- (void)textStorage:(NSTextStorage *)textStorage didProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta {
    //FLOG(@"textStorage:didProcessEditing:range:changeInLength: called");
    __block NSMutableDictionary *dict;
    
    [textStorage enumerateAttributesInRange:editedRange options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         
         dict = [[NSMutableDictionary alloc] initWithDictionary:attributes];
         
         // Iterate over each attribute and look for attachments
         [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
             
             if ([[key description] isEqualToString:NSAttachmentAttributeName]) {
                 //FLOG(@" textAttachment found");
                 //FLOG(@" textAttachment class is %@", [obj class]);
                 
                 NSTextAttachment *attachment = obj;
                 SKTextAttachment *skAttachment;
                 
                 if (attachment.image) {
                     //FLOG(@" attachment.image found");
                     skAttachment = [[SKTextAttachment alloc] initWithData:UIImagePNGRepresentation(attachment.image) ofType:attachment.fileType];
                 }
                 else {
                     //FLOG(@" attachment.image is nil");
                     skAttachment = [[SKTextAttachment alloc] initWithData:attachment.fileWrapper.regularFileContents ofType:attachment.fileType];
                 }
                 
                 [dict setValue:skAttachment forKey:key];
             }
             
         }];
         
         [textStorage setAttributes:dict range:range];
         
     }];
}

@end
