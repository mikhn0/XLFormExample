//
//  PopupQuestion.h
//
//  Created by Виктория on 17/04/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopupQuestion;

typedef void (^popupquestion_handler_block)(PopupQuestion* popup, BOOL accepted);

@interface PopupQuestion : UIView

@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* button1;
@property (nonatomic, strong) NSString* button2;

+ (PopupQuestion*) createWithMessage:(NSString*)message;

- (void) showWithDismissed:(popupquestion_handler_block)dismissed;
- (void) hide;

@end
