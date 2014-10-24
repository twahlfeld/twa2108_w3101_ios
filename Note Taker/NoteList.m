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

-(NoteData *)getNoteAtIndex:(NSInteger)index
{
    if(index > 0 && index < self.listOfNotes.count)
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
    NSData *loadedListOfNote = [[NSData alloc] initWithContentsOfFile:[self filePath]];
    self.listOfNotes = [NSKeyedUnarchiver unarchiveObjectWithData:loadedListOfNote];
}

-(NSString *)filePath
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    return [documentDirectory stringByAppendingString:@"Note_Taker"];
}

-(NSInteger)getNumberOfNotes
{
    return self.listOfNotes.count;
}

@end
