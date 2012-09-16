//
//  AUNoteViewController.h
//  Camera-
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
- (IBAction)displayPhoto:(id)sender;
- (IBAction)displayMap:(id)sender;

@property (strong, nonatomic) Note *model;

-(id)initWithModel:(Note*)note;

@end
