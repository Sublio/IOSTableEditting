//
//  DMStudent.m
//  TableEditingTest
//
//  Created by sublio on 08/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import "DMStudent.h"

#import <UIKit/UIKit.h>

@implementation DMStudent




static NSString* firstNames[] = {
    
    
    @"Tran", @"Lenore", @"Bud",@"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireiile", @"Roma", @"Elise", @"Trang", @"Ty",
    @"Pierre", @"Floyd", @"Savanna", @"Arvilla", @"Whitney",
    @"Denver", @"Norbert", @"Meghan", @"Tandra", @"Jenise",
    @"Brent", @"ELenor", @"Sha", @"Jessie"
    
    
    
    
};


static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
    
    
};

static int nameCount = 50;



+(DMStudent*) randomStudent{
    
    
    
    DMStudent* student = [[DMStudent alloc]init];
    student.firstName = firstNames[arc4random () % nameCount ];
    student.lastName = lastNames[arc4random () % nameCount ];
    student.averageGrade = (CGFloat)(arc4random() % 301 + 200) /100;
    
    return student;
}

@end
