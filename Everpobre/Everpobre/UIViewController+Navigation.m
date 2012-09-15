//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Joshka on 15/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (UIViewController*)inNavigationController
{
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self];
    
    return navVC;
}

@end
