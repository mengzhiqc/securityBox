//
//  LSPWDEntity.h
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPWDEntity : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *passwd;
@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) NSNumber *timestamp;

@end
