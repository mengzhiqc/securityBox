//
//  LSPWDEntityModel.m
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSPWDEntityModel.h"

@implementation LSPWDEntityModel
@synthesize delegate;

+ (LSAppDelegate *)delegate
{
    return  [[UIApplication sharedApplication] delegate];
}

+ (void)insertPwdInfo:(LSPWDEntity *)pwdEntity
{
    NSManagedObjectContext *context = [[self delegate] managedObjectContext];
    NSManagedObject *passwdInfo = [NSEntityDescription
                             insertNewObjectForEntityForName:@"PWDEntity"
                             inManagedObjectContext:context];
    [passwdInfo setValue:[pwdEntity name] forKey:@"name"];
    [passwdInfo setValue:[pwdEntity passwd] forKey:@"passwd"];
    [passwdInfo setValue:[pwdEntity comment] forKey:@"comment"];
    [passwdInfo setValue:[pwdEntity timestamp] forKey:@"timestamp"];
    
    NSError *error;
    if(![context save:&error]) {
        NSLog(@"can't save successfully,info:%@",[error localizedDescription]);
    }
}

+ (NSArray *)passwdList:(NSPredicate *)predicate sorts:(NSArray *)sorts
{
    NSManagedObjectContext *context = [[self delegate] managedObjectContext];
    NSEntityDescription *passwdDescription = [NSEntityDescription
                                              entityForName:@"PWDEntity"
                                              inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:passwdDescription];
    [request setPredicate:predicate];
    [request setSortDescriptors:sorts];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"can't get passwdList! info:%@",[error localizedDescription]);
    }
    return result;
    
}

+ (NSArray *)passwdList
{
    NSManagedObjectContext *context = [[self delegate] managedObjectContext];
    NSEntityDescription *passwdDescription = [NSEntityDescription
                                              entityForName:@"PWDEntity"
                                              inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:passwdDescription];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"can't get passwdList! info:%@",[error localizedDescription]);
    }
    return result;
    
}

@end
