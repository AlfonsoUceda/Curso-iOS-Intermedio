//
//  AUViewController.m
//  NCC1701
//
//  Created by Joshka on 14/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUViewController.h"

@interface AUViewController ()

@end

@implementation AUViewController
@synthesize spaceView;
@synthesize shipView;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Crear un reconocedor de Tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    
    // Lo añadimos a la vista
    [self.view addGestureRecognizer:tap];
    
    // Crear un reconocedor de Swipe
    UISwipeGestureRecognizer *swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toogleHyperspace:)];
    
    [self.view addGestureRecognizer:swiper];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSpaceView:nil];
    [self setShipView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)onTap:(UIGestureRecognizer*)tap
{
    // primero ver en que estado está el tab, lo suyo es que se haya reconocido.
    if(tap.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint newCenter = [tap locationInView:self.spaceView];
        
        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut |
                                         UIViewAnimationOptionAllowUserInteraction |
                                         UIViewAnimationOptionBeginFromCurrentState;
        
        [UIView animateWithDuration:1.2
                              delay:0
                            options:options
                         animations:^{
                             // Estado final
                             self.shipView.center = newCenter;
                             
                         } completion:^(BOOL finished) {
                             // Una vez terminada la animación
                             
                         }];
        
    
        
        [UIView animateWithDuration:0.6
                              delay:0
                            options:options
                         animations:^{
                             // Rotación
                             self.shipView.transform = CGAffineTransformMakeRotation(M_PI);
                             
                         } completion:^(BOOL finished) {
                             // Una vez terminada la animación
                             [UIView animateWithDuration:0.6
                                                   delay:0
                                                 options:options
                                              animations:^{
                                                  // Rotación
                                                  self.shipView.transform = CGAffineTransformIdentity;
                                                  
                                              } completion:^(BOOL finished) {
                                                  // Una vez terminada la animación
                                                  
                                              }];
                             
                         }];
    }
}

- (void)toogleHyperspace:(UISwipeGestureRecognizer*)swiper
{
    if(swiper.state == UIGestureRecognizerStateRecognized)
    {
        [UIView animateWithDuration:1
                              delay:0
                            options:0
                         animations:^{
                             
                             if (self.shipView.alpha)
                             {
                                 self.shipView.alpha = 0;
                             }
                             else
                             {
                                 self.shipView.alpha = 1;
                             }
                             
                         } completion:^(BOOL finished) {
                             // Una vez terminada la animación
                             
                         }];
    }
}

@end
