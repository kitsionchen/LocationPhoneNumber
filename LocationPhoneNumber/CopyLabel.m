//
//  CopyLabel.m
//  LocationPhoneNumber
//
//  Created by chenzefeng on 11-12-4.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CopyLabel.h"

@implementation CopyLabel

- (void)attachTapHandler {
    [self setUserInteractionEnabled:YES];
    UIGestureRecognizer *tapGestureRecognizer = 
    [[UITapGestureRecognizer alloc] 
     initWithTarget:self 
     action:@selector(handleTap:)];
    
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self attachTapHandler];
}

- (void)handleTap:(UIGestureRecognizer *)recognizer {
    if (self.text.length > 0) {
        [self becomeFirstResponder];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}

- (void)copy:(id)sender {
    [UIPasteboard generalPasteboard].string = self.text;
}

@end
