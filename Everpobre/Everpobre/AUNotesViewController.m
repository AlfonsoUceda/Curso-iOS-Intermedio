//
//  AUNotasViewController.m
//  Everpobre
//
//  Created by Joshka on 15/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "AUNotesViewController.h"
#import "Note.h"
#import "Note+Creation.h"

@interface AUNotesViewController ()
@property (strong) NSManagedObjectContext *context;
@end

@implementation AUNotesViewController

- (id)initWithStyle:(UITableViewStyle)style context:(NSManagedObjectContext *)context
{
    if (self = [super initWithStyle:style]) {
        self.context = context;
        self.title = @"Notes";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(onChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)onChange:(NSNotification*)notification
{
    NSDictionary *dic = notification.userInfo;
    
    NSLog(@"Objetos añadidos %@", [dic objectForKey:NSInsertedObjectsKey]);
    NSLog(@"Objetos eliminados %@", [dic objectForKey:NSDeletedObjectsKey]);
    NSLog(@"Objetos modificados %@", [dic objectForKey:NSUpdatedObjectsKey]);
    
    NSError *error = nil;
    
    if([self.context save:&error] == NO)
    {
        // ERROR
        NSLog(@"Error al guardar %@", [error localizedDescription]);
    }
}

- (void)addNote:(id)sender
{
    // creamos una nueva instancia
    Note *newNote = [Note noteWithContext:self.context];
    
    NSError *error;
    
    if([self.context save:&error] == NO)
    {
        // Cascó
        NSLog(@"Cascó nota %@: %@", newNote, [error localizedDescription]);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        
    cell.textLabel.text = note.title;
    NSLocale *esLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setLocale:esLocale];
    
    cell.detailTextLabel.text = [formatter stringFromDate:note.creationDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Note *deletedNote = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.context deleteObject:deletedNote];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
