//
//  NoteData.h
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NoteData : NSObject

@property (strong, nonatomic) NSString *noteTitle;
@property (strong, nonatomic) NSString *noteText;
@property (strong, nonatomic) UIImage *noteImage;

@end
