//
//  PopupQuestion.m
//
//  Created by Виктория on 17/04/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "PopupQuestion.h"
#import "AppDelegate.h"


@interface PopupQuestion () {
	__weak IBOutlet UILabel* messageLabel;

	__strong popupquestion_handler_block completionBlock;

	CGFloat animationDuration;
	UIViewAnimationCurve animationCurve;
}

@end


@implementation PopupQuestion


//--------------------------------------------------------------
#pragma mark - lifecycle


+ (PopupQuestion*) createWithMessage:(NSString*)message {
	PopupQuestion* menu = (PopupQuestion*)[[[NSBundle mainBundle] loadNibNamed:@"PopupQuestion" owner:nil options:nil] objectAtIndex:0];
	menu.message = message;
	return menu;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	if( (self = [super initWithCoder:aDecoder]) ) {
//		REGISTER_OBSERVER(kKeyboardWillShow, notif_KeyboardShowing);
//		REGISTER_OBSERVER(kKeyboardWillHide, notif_KeyboardShowing);

		animationDuration = 0;
	}
	return self;
}


- (void) dealloc {
//	UNREGISTER_OBSERVER(kKeyboardWillShow);
//	UNREGISTER_OBSERVER(kKeyboardWillHide);
}


//--------------------------------------------------------------
#pragma mark - actions


- (IBAction) action_Yes:(id)sender {
	completionBlock(self, YES);
	[self hide];
}


- (IBAction) action_No:(id)sender {
	completionBlock(self, NO);
	[self hide];
}


//--------------------------------------------------------------
#pragma mark - notifications


- (void) notif_OrientationChanged:(NSNotification*)notif {
	animationDuration = 0.4;
	animationCurve = UIViewAnimationCurveEaseInOut;

	[self setNeedsLayout];
}


- (void) notif_KeyboardShowing:(NSNotification*)notif {
//	USE_APPLICATION;
//	animationDuration = application.keyboardDuration;
//	animationCurve = application.keyboardCurve;

	[self setNeedsLayout];
}


//--------------------------------------------------------------
#pragma mark - public api


- (void) setMessage:(NSString *)message {
	_message = message;
	messageLabel.text = _message;
}


- (void)showWithDismissed:(popupquestion_handler_block)dismissed {
	completionBlock = dismissed;
	messageLabel.text = self.message;
//	USE_APPLICATION;
//	[application.window addSubview:self];
}

- (void) hide {
	[self removeFromSuperview];
}


//--------------------------------------------------------------
#pragma mark - view


- (void) layoutSubviews {
	[super layoutSubviews];
//	USE_APPLICATION;

	if( animationDuration > 0 ) {
		[UIView beginAnimations:@"menu-rotation" context:nil];
		[UIView setAnimationDuration:animationDuration];
		[UIView setAnimationCurve:animationCurve];
	}

	float selfWidth = 0, selfHeight = 0;

	switch( application.deviceOrientation ) {

		case UIInterfaceOrientationPortraitUpsideDown:
			self.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(180) );
			selfWidth = self.superview.bounds.size.width;
			selfHeight = self.superview.bounds.size.height;
			break;

		case UIInterfaceOrientationLandscapeLeft:
			self.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(-90) );
			selfWidth = self.superview.bounds.size.height;
			selfHeight = self.superview.bounds.size.width;
			break;

		case UIInterfaceOrientationLandscapeRight:
			self.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(90) );
			selfWidth = self.superview.bounds.size.height;
			selfHeight = self.superview.bounds.size.width;
			break;

		default:
		case UIInterfaceOrientationPortrait:
			self.transform = CGAffineTransformIdentity;
			selfWidth = self.superview.bounds.size.width;
			selfHeight = self.superview.bounds.size.height;
			break;
	}

	self.frame = self.superview.bounds;

	if( animationDuration > 0 ) {
		[UIView commitAnimations];
	}
	animationDuration = 0;
}


@end
