//
//  ViewController.m
//  Note Taker
//
//  Created by Theodore Ahlfeld on 10/22/14.
//  Copyright (c) 2014 Theodore Ahlfeld. All rights reserved.
//

#import "MasterNoteViewController.h"
#import "NoteTableViewCell.h"
#import "NoteDetailViewController.h"
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
    self.noteTableView.delegate = self;
    self.noteTableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.listOfNotes = [NoteList noteSingleton];
    [self.listOfNotes loadNotes];
    [self.noteTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noteCell" forIndexPath:indexPath];
    NoteData *thisNote = [self.listOfNotes getNoteAtIndex:indexPath.row];
    if(thisNote) {
        cell.noteTitle.text = [thisNote noteTitle];
        cell.noteText.text = [thisNote noteText];
        cell.noteImageView.image = [thisNote noteImage];
        cell.noteTime.text = [self stringOfDateAndTime:[thisNote noteTime]];
    }
    
    return cell;
}

-(NSString *)stringOfDateAndTime:(NSDate *)time
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    return [NSString stringWithFormat:@"%@ %@", [dateFormat stringFromDate:time], [timeFormat stringFromDate:time]];
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
    return [self.listOfNotes getNumberOfNotes];
}

#pragma mark - TableView Delegate Methods
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listOfNotes removeNoteFromNoteList:indexPath.row];
        [self.listOfNotes saveNotes];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *noteIndexPath = [self.noteTableView indexPathForSelectedRow];
    NoteDetailViewController *ndvc = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"noteDetailViewSegue"]) {
        ndvc.thisNote = [self.listOfNotes getNoteAtIndex:noteIndexPath.row];
    } else {
        ndvc.thisNote = nil;
    }
}

@end
