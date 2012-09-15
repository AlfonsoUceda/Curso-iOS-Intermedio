//
//  Note+Creation.h
//  Everpobre
//
//  Created by Joshka on 15/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "Note.h"

@interface Note (Creation)

+ (id)noteWithContext:(NSManagedObjectContext*)context;

@end
