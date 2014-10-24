//
//  NoteList.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/23/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "NoteList.h"

@implementation NoteList

+(instancetype)noteSingleton
{
    static NoteList *noteList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noteList = [[NoteList alloc] init];
    });
    return noteList;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listOfNotes = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addNoteToNoteList:(NSString *)title noteBody:(NSString *)noteBody image:(UIImage *)image time:(NSDate *)time
{
    NoteData *newNote = [[NoteData alloc] initWithNoteData:title noteBody:noteBody image:image time:time];
    [self.listOfNotes addObject:newNote];
}

-(void)removeNoteFromNoteList:(NSInteger)index
{
    [self.listOfNotes removeObjectAtIndex:index];
}

-(NoteData *)getNoteAtIndex:(NSInteger)index
{
    if(index >= 0 && index < self.listOfNotes.count)
        return self.listOfNotes[index];
    return nil;
}

-(void)saveNotes
{
    NSData *savedListOfNotes = [NSKeyedArchiver archivedDataWithRootObject:self.listOfNotes];
    NSString *saveLocation = [self filePath];
    [savedListOfNotes writeToFile:saveLocation atomically:YES];
}

-(void)loadNotes
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
        NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
        self.listOfNotes = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

-(NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"noteTaker"];
    return filePath;
}

-(NSInteger)getNumberOfNotes
{
    return self.listOfNotes.count;
}

@end
