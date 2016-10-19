//
//  Person+CoreDataProperties.m
//  手动创建CoreData
//
//  Created by 赵金鹏 on 2016/10/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic age;
@dynamic name;
@dynamic book;

@end
