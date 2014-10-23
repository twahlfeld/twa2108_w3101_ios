//
//  NoteData.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "NoteData.h"

@implementation NoteData

-(instancetype)init
{
    return [self initWithNoteData:DEFAULT_TITLE noteBody:DEFAULT_TEXT image:[UIImage imageNamed:DEFAULT_IMAGE]];
}

-(id)initWithNoteData:(NSString *)title noteBody:(NSString *)text image:(UIImage *)image
{
    self = [super init];
    if(self) {
        self.noteTitle = title;
        self.noteText = text;
        self.noteImage = image;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.noteTitle forKey:@"title"];
    [aCoder encodeObject:self.noteText forKey:@"text"];
    [aCoder encodeObject:self.noteImage forKey:@"image"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithNoteData:[aDecoder decodeObjectForKey:@"title"] noteBody:[aDecoder decodeObjectForKey:@"text"] image:[aDecoder decodeObjectForKey:@"image"]];
}

@end
