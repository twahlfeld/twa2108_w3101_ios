//
//  ViewController.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "ViewController.h"
#import "NoteTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *noteTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.noteTableView.delegate = self;
    self.noteTableView.dataSource = self;
    
    
    // Add a comment
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma make - Tableview Data Source Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noteDataArray.count;
}

#pragma mark - TableView Delegate Methods
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Deleting note at position : %ld", indexPath.row);
}

@end
