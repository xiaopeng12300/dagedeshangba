//
//  ViewController.m
//  手动创建CoreData
//
//  Created by 赵金鹏 on 2016/10/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "ViewController.h"
#import "Person+CoreDataClass.h"
#import "Book+CoreDataClass.h"
#import <CoreData/CoreData.h>
@interface ViewController ()

@property (strong, nonatomic)   NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *bookText;
@property (weak, nonatomic) IBOutlet UITextField *priceText;

@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image.image = [UIImage imageNamed:@"7"];
    self.view.backgroundColor = [UIColor yellowColor];
//    创建模型文件
    NSManagedObjectModel *model= [NSManagedObjectModel mergedModelFromBundles:nil];
    //创建context配置信息的工具
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"person.sqlite"];
    NSLog(@"%@",path);
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    
    //CoreData数据迁移必须添加的内容
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES};
    
    //配置数据持久化
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error];
    
    if (error) {
        NSLog(@"打开数据库失败%@",error);
    }else{
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.context.persistentStoreCoordinator = coordinator;
    }
}
//增加
- (IBAction)inert:(id)sender {
    //获取实例对象
    Person *per = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    per.name = self.nameText.text;
    NSInteger age = [self.numText.text integerValue];
    NSLog(@"%li",age);
    
    per.age = @20;
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.context];
    book.name = self.bookText.text;
    book.price = [self.priceText.text floatValue];
    
    per.book = book;
    NSError *error;
    if ([self.context save:&error]){
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败%@",error);
    }
    
}
- (IBAction)delete:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"name contains %@",@"氢气球"];
    NSError *error;
    //执行删除前的查询操作
    NSArray *personList = [self.context executeFetchRequest:request error:&error];
    NSLog(@"-------%@",personList);
    
    for (Person *person in personList) {
        //执行删除关联数据的操作
        [self.context deleteObject:person.book];
        //执行删除操作
        [self.context deleteObject:person];
    }
    
    NSError *error1;
    if ([self.context save:&error1]){
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败%@",error);
    }
    
}
- (IBAction)change:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"name contains %@",@"老司机"];
    NSError *error;
    //执行删除前的查询操作
    NSArray *personList = [self.context executeFetchRequest:request error:&error];
    NSLog(@"-------%@",personList);
    
    for (Person *person in personList) {
        
        person.name = @"秋名山车神";
        person.book.name = @"漂移指南";
        
    }
    
    NSError *error1;
    if ([self.context save:&error1]){
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败%@",error1);
    }
    
}
- (IBAction)search:(id)sender {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"age",@(20)];
    NSError *error;
    //执行删除前的查询操作
    NSArray *personList = [self.context executeFetchRequest:request error:&error];
    
    NSMutableArray *dataList = [NSMutableArray array];
    
    for (Person *person in personList) {
        
        [dataList addObject:person];
        
    }
    
    NSLog(@"------%@",dataList);
    
    NSError *error1;
    if ([self.context save:&error1]){
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败%@",error1);
    }

    
}





@end






















