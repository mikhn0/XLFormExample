//
//  AddPhotoViewController.m
//  TestModelAlliance
//
//  Created by Виктория on 13.02.16.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "AddPhotoCell.h"
#import "PopupQuestion.h"
#import "MyLoadingIndicator.h"


NSString * const FormRowAddPhoto = @"FormRowAddPhoto";

@interface AddPhotoCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *deletePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UICollectionView *photosCollection;
@property (weak, nonatomic) IBOutlet MyLoadingIndicator *loadinInd;


@end

@implementation AddPhotoCell

+ (void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([AddPhotoCell class]) forKey:FormRowAddPhoto];
}

#pragma mark - XLFormDescriptorCell

- (void)configure
{
    [super configure];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)update
{
    [super update];
}

#pragma mark - Action

- (void)addPhoto:(id)sender {
    [self.delegate addPhoto];
}

- (IBAction)deletePhoto:(UIButton*)sender {
    NSInteger row = [self.photosCollection indexPathForCell:(UICollectionViewCell*)sender.superview.superview].row;
    
    PopupQuestion *question = [PopupQuestion createWithMessage:@"Are you sure to delete photo?"];
    [question showWithDismissed:^(PopupQuestion *popup, BOOL accepted) {
        if( accepted ) {
            [self.photos removeObjectAtIndex:row];
            
            [self.photosCollection reloadData];
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.photos addObject:[NSNull null]];
    if ( 1 == self.photos.count ) {
        [self.photosCollection reloadData];
    } else {
        //---------
    }
    self.photosCollection.userInteractionEnabled = NO;
    [self.photos replaceObjectAtIndex:(self.photos.count - 1) withObject:image];
    [self.photosCollection reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.photos.count - 1) inSection:0]]];
    self.photosCollection.userInteractionEnabled = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imageController:(ImageViewController *)controller deletePhotoAtIndex:(NSInteger)index completion:(void (^)(NSArray *))completion {
    [self.photos removeObjectAtIndex:index];
    
    [self.photosCollection reloadData];
    
    completion(self.photos);
}

//--------------------------------------------------------------
#pragma mark - collection view


- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CGSize size;
    
    CGFloat width = 70;
    if ( row == self.photos.count ) {
        width = 120;
    }
    
    size = CGSizeMake(width, 70);
    
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    UICollectionViewCell *cell = nil;
    if( row == self.photos.count ) {
        cell = [cv dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
    } else {
        // photo
        id photo = [self.photos objectAtIndex:row];
        
        cell = [cv dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
        
        self.photo.image = nil;
        self.photo.image = [photo isKindOfClass:[UIImage class]] ? (UIImage *)photo : nil;
        self.loadinInd.hidden = nil != self.photo.image;
    }

    
    return cell;
}


- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    if( row == self.photos.count ) {
        [self addPhoto:nil];
    } else {
            // SHOW DETAIL IMAGE
//        ImageViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//        controller.delegate = self;
//        controller.images = self.photos;
//        controller.currentIndex = row;
//        controller.canDelete = YES;
//        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
