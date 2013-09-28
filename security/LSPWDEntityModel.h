//
//  LSPWDEntityModel.h
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSAppDelegate.h"
#import "LSPWDEntity.h"

@interface LSPWDEntityModel : NSObject
@property(nonatomic,strong) LSAppDelegate *delegate;
+ (void)insertPwdInfo:(LSPWDEntity *)pwdEntity;
+ (NSArray *)passwdList;

+ (void)updatePasswdInfo;
+ (void)removePasswdInfo:(NSManagedObject *)passwdInfo;
@end
