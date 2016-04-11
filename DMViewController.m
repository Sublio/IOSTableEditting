//
//  DMViewController.m
//  TableEditingTest
//
//  Created by sublio on 08/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import "DMViewController.h"
#import "DMGroup.h"
#import "DMStudent.h"

@interface DMViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groupsArray;

@end

@implementation DMViewController



-(void) loadView{
    
    
    [super loadView];
    
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView* tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.groupsArray = [NSMutableArray array];
    
    for (int i = 0; i < arc4random() %6 + 5; i++){
        
        DMGroup* group = [[DMGroup alloc]init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        NSMutableArray* array = [NSMutableArray array];
        
        for (int j = 0; j< ((arc4random() %11)+15);j++){
            
            [array addObject:[DMStudent randomStudent]];
            
        }
        
        group.students = array;
        
        [self.groupsArray addObject:group];
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = @"Students";
    
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

-(void) actionEdit:(UIBarButtonItem*) sender {
    
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:NO];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    
    if (self.tableView.editing){
        
        item = UIBarButtonSystemItemDone;
        
    }
    
    
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    [self.navigationItem setRightBarButtonItem:editButton animated: YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    DMGroup* group = [self.groupsArray objectAtIndex:section];
    return [group.students count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    
    
    DMGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
    DMStudent* student = [group.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", student.firstName, student.lastName];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f",student.averageGrade];
    
    if(student.averageGrade >= 4.0){
        
        
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (student.averageGrade >= 3.0){
        
        
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    }else{
        
        cell.detailTextLabel.textColor = [UIColor redColor];
        
    }
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return [self.groupsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [[self.groupsArray objectAtIndex:section] name];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    DMGroup* sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
    DMStudent* student = [sourceGroup.students objectAtIndex:indexPath.row];
    */
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    DMGroup* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    DMStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];

    if(sourceIndexPath.section ==destinationIndexPath.section){
        
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = tempArray;
        
    }else{
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        DMGroup* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        
        [tempArray insertObject:student atIndex:destinationIndexPath.row];
        destinationGroup.students = tempArray;
        
    }
    
    
    
    
    
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return UITableViewCellEditingStyleNone;
}



@end
