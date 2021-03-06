//
//  NoteList.h
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/23/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteData.h"

@interface NoteList : NSObject

@property NSMutableArray *listOfNotes;

+(instancetype)noteSingleton;
-(void)addNoteToNoteList:(NSString *)title noteBody:(NSString *)noteBody image:(UIImage *)image time:(NSDate *)time;
-(void)removeNoteFromNoteList:(NSInteger)index;
-(NoteData *)getNoteAtIndex:(NSInteger)index;
-(void)saveNotes;
-(void)loadNotes;
-(NSInteger)getNumberOfNotes;

@end
