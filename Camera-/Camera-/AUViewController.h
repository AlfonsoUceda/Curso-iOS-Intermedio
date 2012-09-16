//
//  AUViewController.h
//  Camera-
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) UIImage *photoModel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)takePhoto:(id)sender;

@end
