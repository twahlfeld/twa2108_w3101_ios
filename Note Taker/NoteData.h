//
//  NoteData.h
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const DEFAULT_TITLE = @"Note Title";
static NSString *const DEFAULT_TEXT = @"Note Title";
static NSString *const DEFAULT_IMAGE = @"defaultImage";

@interface NoteData : NSObject <NSCoding>

@property (strong, nonatomic) NSString *noteTitle;
@property (strong, nonatomic) NSString *noteText;
@property (strong, nonatomic) UIImage *noteImage;

-(id)initWithNoteData:(NSString *)title noteBody:(NSString *)text image:(UIImage *)image;

@end
