//
//  DMStudent.h
//  TableEditingTest
//
//  Created by sublio on 08/04/16.
//  Copyright (c) 2016 sublio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DMStudent : NSObject


@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat averageGrade;


+(DMStudent*) randomStudent;

@end
