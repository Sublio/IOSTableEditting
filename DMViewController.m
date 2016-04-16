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
    self.tableView.allowsSelectionDuringEditing = NO;
    
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
    
    
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(actionAddSection:)];
    self.navigationItem.leftBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

-(void) actionEdit:(UIBarButtonItem*) sender {
    
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    
    if (self.tableView.editing){
        
        item = UIBarButtonSystemItemDone;
        
    }
    
    
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    [self.navigationItem setRightBarButtonItem:editButton animated: YES];
    
    
}


- (void) actionAddSection: (UIBarButtonItem*) sender {
    
    DMGroup* group = [[DMGroup alloc]init];
    group.name = [NSString stringWithFormat:@"Group #%d", [self.groupsArray count] + 1];
    
    group.students = @[[DMStudent randomStudent], [DMStudent randomStudent]];
    
    
    
    NSInteger newSectionIndex = 0;
    
    [self.groupsArray insertObject:group atIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    NSIndexSet* insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    [self.tableView insertSections:insertSections
                  withRowAnimation:[self.groupsArray count] % 2 ?  UITableViewRowAnimationLeft: UITableViewRowAnimationRight];

    [self.tableView endUpdates];
    
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    double delayInSeconds = 0.3;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime,dispatch_get_main_queue(), ^(void){
        
        if([[UIApplication sharedApplication]isIgnoringInteractionEvents]){
            
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    DMGroup* group = [self.groupsArray objectAtIndex:section];
    return [group.students count] + 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row ==0){
        
        static NSString* addStudentIdentifier = @"AddStudentCell";
        
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:addStudentIdentifier];
        
        if(!cell){
            
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:addStudentIdentifier];
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.text = @"Tap to add  new student";
            
        }

        return cell;
        
    }else{
        
        static NSString* studentIdentifier = @"StudentCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
        
        if(!cell){
            
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
            
        }
        
        
        
        DMGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        DMStudent* student = [group.students objectAtIndex:indexPath.row - 1];
        
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
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return [self.groupsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [[self.groupsArray objectAtIndex:section] name];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row >0;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    DMGroup* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    DMStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row -1];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];

    if(sourceIndexPath.section ==destinationIndexPath.section){
        
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1  withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
        
    }else{
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        DMGroup* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
        
    }
    
    
    
    
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return indexPath.row ==0 ? UITableViewCellEditingStyleNone: UITableViewCellEditingStyleDelete;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return NO;
}


- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    
    
    if (proposedDestinationIndexPath.row ==0){
        
        return sourceIndexPath;
    } else {
        
        return proposedDestinationIndexPath;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row ==0){
        
        DMGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
        NSMutableArray* tempArray = nil;
        if(group.students){
            
            tempArray =[NSMutableArray arrayWithArray:group.students];
        }else{
            
            tempArray = [NSMutableArray array];
            
        }
        
        
        NSInteger newStudentIndex = 0;
        
        [tempArray insertObject:[DMStudent randomStudent] atIndex:newStudentIndex];
        
        
        group.students = tempArray;
        
        
        
        
        
        [self.tableView beginUpdates];
        
       
        
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
        
        
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        double delayInSeconds = 0.3;
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,dispatch_get_main_queue(), ^(void){
            
            if([[UIApplication sharedApplication]isIgnoringInteractionEvents]){
                
                
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
            
        });

        
    }
    
    
    
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"Remove";
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        
        DMGroup* sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
        DMStudent* student = [sourceGroup.students objectAtIndex:indexPath.row -1];
        NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
        [tempArray removeObject:student];
        
        sourceGroup.students = tempArray;
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [tableView endUpdates];
        
        
        
    }
    
    
}


@end
