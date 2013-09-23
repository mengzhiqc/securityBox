//
//  LSLeftMenuViewController.h
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"

@interface LSLeftMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (void)togglePresentationMode:(id)sender;
@end
