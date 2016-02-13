//
//  MyLoadingIndicator.m
//
//  Created by Виктория on 4/2/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MyLoadingIndicator.h"

@interface MyLoadingIndicator()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MyLoadingIndicator

- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {

	if(self = [super initWithCoder:aDecoder]) {
		[self initialization];
	}

	return self;
}

-(void) initialization {
//	self.image = [UIImage imageNamed:@"IMG_Loading_Indicator"];
    self.image = [UIImage imageNamed:@"loading2"];
	self.backgroundColor = [UIColor clearColor];

	_imageView = [[UIImageView alloc]initWithFrame:self.bounds];
	_imageView.contentMode = UIViewContentModeScaleAspectFit;
	_imageView.image = _image;

	[self addSubview:_imageView];

	[self setAnimate:YES];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	_imageView.frame = self.bounds;
}

-(void)setAnimate:(BOOL)animate {

	if(animate) {

		if([[self.layer animationKeys] containsObject:@"MyLoadingIndicatorAnimation"]) {
			return;
		}

		CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		fullRotation.fromValue = [NSNumber numberWithFloat:0];
		fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
		fullRotation.duration = 1.;
		fullRotation.repeatCount = INFINITY;
		[self.layer addAnimation:fullRotation forKey:@"MyLoadingIndicatorAnimation"];
	}
	else {
		[self.layer removeAllAnimations];
	}
}

-(void)setHidden:(BOOL)hidden {
	[super setHidden:hidden];
	[self setAnimate:!hidden];
}

-(void)dealloc {
	[_imageView removeFromSuperview];
	_imageView = nil;
	_image = nil;
}

@end
