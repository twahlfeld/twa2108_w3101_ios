//
//  ViewController.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "MasterNoteViewController.h"
#import "NoteTableViewCell.h"
#import "NoteList.h"
#import "NoteData.h"

@interface MasterNoteViewController ()

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;
@property (strong, nonatomic) NoteList *listOfNotes;

@end

@implementation MasterNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.listOfNotes = [NoteList noteSingleton];
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
    return 5;//[self.listOfNotes getNumberOfNote];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"noteDetailViewSegue"])
        NSLog(@"FUCKING SEGUE BITCH");
    else
        NSLog(@"SOME OTHER BULLSHIT");
}

@end
