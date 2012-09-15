//
//  Note+Creation.m
//  Everpobre
//
//  Created by Joshka on 15/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "Note+Creation.h"

@implementation Note (Creation)

+ (id)noteWithContext:(NSManagedObjectContext*)context
{
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    note.creationDate = [NSDate date];
    
    return note;
}

@end
