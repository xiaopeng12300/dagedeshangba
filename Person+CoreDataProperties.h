//
//  Person+CoreDataProperties.h
//  手动创建CoreData
//
//  Created by 赵金鹏 on 2016/10/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Book *book;

@end

NS_ASSUME_NONNULL_END
