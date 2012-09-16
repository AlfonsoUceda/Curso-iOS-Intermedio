//
//  AUViewController.m
//  Camera-
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUViewController.h"

@interface AUViewController ()

@end

@implementation AUViewController
@synthesize photoView;
@synthesize photoModel;

- (void)viewDidLoad:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setPhotoView:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.photoView.image = self.photoModel;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // Habemus camera
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImageViewControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *aFoto = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.photoModel = aFoto;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
