//
//  AUPhotoViewController.m
//  Everpobre
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUPhotoViewController.h"

@interface AUPhotoViewController ()

@end

@implementation AUPhotoViewController
@synthesize photoView;


-(id)initWithModel:(Note*)note
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.model = note;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photoView.image = [UIImage imageWithData:self.model.photoData];
    
    if (self.photoView.image == nil) {
        self.photoView.image = [UIImage imageNamed:@"photo_placeholder.png"];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)trashPhoto:(id)sender {
    [UIView animateWithDuration:1 delay:0 options:0 animations:^{
        // Quitarle el alpha
        self.photoView.alpha = 0.0;
    } completion:^(BOOL finished){
        
        // Quito la image
        self.photoView.image = [UIImage imageNamed:@"photo_placeholder.png"];
        self.model.photoData = nil;
        
        // Al terminar vuelvo a ponersela
        self.photoView.alpha = 1.0;
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.model.photoData = UIImagePNGRepresentation(image);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

@end
