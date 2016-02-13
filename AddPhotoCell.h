//
//  AddPhotoViewController.h
//  TestModelAlliance
//
//  Created by Виктория on 13.02.16.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormBaseCell.h"

extern NSString * const FormRowAddPhoto;

extern NSString *const kSunday;
extern NSString *const kMonday;
extern NSString *const kTuesday;
extern NSString *const kWednesday;
extern NSString *const kThursday;
extern NSString *const kFriday;
extern NSString *const kSaturday;

@protocol AddPhotoCellDelegate <NSObject>

- (void)addPhoto;

@optional
- (void)deletePhoto;

@end

@interface AddPhotoCell : XLFormBaseCell

@property (nonatomic, strong) NSMutableArray *photos;
@property (weak, nonatomic) id <AddPhotoCellDelegate> delegate;

@end
