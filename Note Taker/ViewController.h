//
//  ViewController.h
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *noteDataArray;

@end

