//
//  AUNoteViewController.m
//  Everpobre
//
//  Created by Joshka on 16/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUNoteViewController.h"
#import "AUPhotoViewController.h"

@interface AUNoteViewController ()

@end

@implementation AUNoteViewController
@synthesize titleView;
@synthesize noteTextView;


- (id)initWithModel:(Note*)note
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.model = note;
        self.title = @"Note";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view from its nib.
    self.titleView.text = self.model.title;
    self.noteTextView.text = self.model.text;
    self.noteTextView.layer.cornerRadius = 10;
    
    // Nos subcribimos a la notificación del teclado.
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(onDisplayKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(onHideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
    
    // Añadimos una barra al teclado
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Hide" style:UIBarButtonItemStyleBordered target:self action:@selector(hideKeyboard:)];
    
    toolbar.items = @[button];
    
    self.noteTextView.inputAccessoryView = toolbar;
}

-(void)viewDidUnload
{
    [self setTitleView:nil];
    [self setNoteTextView:nil];
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.model.title = self.titleView.text;
    self.model.text = self.noteTextView.text;
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)displayPhoto:(id)sender {
    AUPhotoViewController *photoVC = [[AUPhotoViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:photoVC animated:YES];
}

- (IBAction)displayMap:(id)sender {
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)onDisplayKeyboard:(NSNotification*)notification
{
    NSLog(@"%@", notification);
    
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        CGRect newFrame = self.noteTextView.frame;
        newFrame.size.height = 100;
        self.noteTextView.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)onHideKeyboard:(NSNotification*)notification
{
    NSLog(@"%@", notification);
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        CGRect newFrame = self.noteTextView.frame;
        newFrame.size.height = 200;
        self.noteTextView.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
}
@end
