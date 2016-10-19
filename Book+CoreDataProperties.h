//
//  Book+CoreDataProperties.h
//  手动创建CoreData
//
//  Created by 赵金鹏 on 2016/10/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "Book+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float price;

@end

NS_ASSUME_NONNULL_END
