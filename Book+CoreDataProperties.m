//
//  Book+CoreDataProperties.m
//  手动创建CoreData
//
//  Created by 赵金鹏 on 2016/10/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "Book+CoreDataProperties.h"

@implementation Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Book"];
}

@dynamic name;
@dynamic price;

@end
