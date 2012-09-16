//
//  AUPhotoViewController.h
//  Everpobre
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface AUPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)trashPhoto:(id)sender;

@property (strong, nonatomic) Note *model;

-(id)initWithModel:(Note*)note;

@end
