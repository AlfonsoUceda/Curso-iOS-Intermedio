//
//  AUViewController.m
//  GCD
//
//  Created by Joshka on 14/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUViewController.h"

@interface AUViewController ()

@end

@implementation AUViewController
@synthesize photoView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.photoView.layer.cornerRadius = 10.0;
    self.photoView.clipsToBounds = YES;
}

- (void)viewDidUnload
{
    [self setPhotoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)download:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.starspage.net/Fashion/Bar-Refaeli-Agua-Bendita-2012-Swimwear/images/Bar%20Refaeli%20Agua%20Bendita%202012%20Swimwear%20Photoshoot%2035.jpg"];
    
    // Crear cola
    dispatch_queue_t download = dispatch_queue_create("downloader", NULL);
    
    __block NSData *dataBendita = nil;
    
    // añadir bloque
    dispatch_async(download, ^{
        
        // Esto se ejecuta en segundo plano
        dataBendita = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:dataBendita];
            
            self.photoView.image = image;
        });
    });
    
    dispatch_release(download);
}
@end
