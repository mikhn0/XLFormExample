//
//  AddPlaceViewController.m
//  TestModelAlliance
//
//  Created by Виктория on 13.02.16.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "XLForm.h"
#import "AddPlaceViewController.h"
#import "FloatLabeledTextFieldCell.h"
#import "AddPhotoCell.h"
#import "UIImagePickerController.h"
#import "ImageViewController.h"

#define LIGHT_GREY_COLOR [UIColor colorWithRed:243.0/255.0 green:244.0/255.0 blue:248.0/255.0 alpha:1.0]

NSString *const kSwitchBool = @"switchBool";
NSString *const kTextView = @"textView";
NSString *const kButton = @"Button";
NSString *const kTextField = @"TextField";

static NSString * const kCustomRowAddCell = @"CustomRowAddPhoto";

@interface AddPlaceViewController () <AddPhotoCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageViewControllerDelegate>

@end

@implementation AddPlaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        XLFormDescriptor * form = [XLFormDescriptor formDescriptorWithTitle:@"Add location"];
        
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        
        // first section
        
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextField rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"Location name" forKey:@"textField.placeholder"];
        row.required = YES;
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textField.backgroundColor"];
        [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:15] forKey:@"textField.font"];
        [section addFormRow:row];
        
        //second section
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kSwitchBool rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Current location"];
        [row.cellConfigAtConfigure setObject:[UIColor purpleColor] forKey:@"switchControl.onTintColor"];
        [section addFormRow:row];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextField rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"My location" forKey:@"textField.placeholder"];
        row.required = YES;
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textField.backgroundColor"];
        [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:15] forKey:@"textField.font"];
        [section addFormRow:row];
        
        //thierd section
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextField rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"Link" forKey:@"textField.placeholder"];
        row.required = YES;
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textField.backgroundColor"];
        [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:15] forKey:@"textField.font"];
        [section addFormRow:row];
        
        //fourth section
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextField rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"Phone number" forKey:@"textField.placeholder"];
        row.required = YES;
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textField.backgroundColor"];
        [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:15] forKey:@"textField.font"];
        [section addFormRow:row];
        
        
        //fifth section
        
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        // AddPhoto
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowAddCell rowType:FormRowAddPhoto];
        [section addFormRow:row];
        
        //sixth section
        
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kTextView rowType:XLFormRowDescriptorTypeTextView];
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfigAtConfigure setObject:@"TEXT VIEW EXAMPLE" forKey:@"textView.placeholder"];
        [section addFormRow:row];
        
        //Button
        row = [XLFormRowDescriptor formRowDescriptorWithTag:kButton rowType:XLFormRowDescriptorTypeButton title:@"Save"];
        [row.cellConfigAtConfigure setObject:[UIColor clearColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor purpleColor] forKey:@"textLabel.color"];
        [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:40] forKey:@"textLabel.font"];
        [section addFormRow:row];
        
        self.form = form;
    }
    return self;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // change cell height of a particular cell
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:kTextField] || [[self.form formRowAtIndex:indexPath].tag isEqualToString:kSwitchBool])
    {
        return 60.0;
    } else if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:kTextView]) {
        
        return 150.0;
        
    } else if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:kButton]) {
        
        return 70.0;
        
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void) addPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
