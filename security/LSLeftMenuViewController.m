//
//  LSLeftMenuViewController.m
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSLeftMenuViewController.h"
#import "PKRevealController.h"
#import "LSMainViewController.h"
#import "LSAddItemViewController.h"
#import "LSAboutAppViewController.h"
#import "LSSreenLockViewController.h"
#import "LSAppDelegate.h"
#import "LSImageUtil.h"
#import "UMFeedback.h"

@interface LSLeftMenuViewController ()
@property(nonatomic,strong) NSArray *dataSource;
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation LSLeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Left Menu";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.revealController setMinimumWidth:170.0f maximumWidth:240.0f forViewController:self];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *tableViewBackgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [tableViewBackgroundView setBackgroundColor: [UIColor colorWithPatternImage:[LSImageUtil scaleImage:[UIImage imageNamed:@"Security-leftview-background.png"] toScale:0.5]]];
    [self.tableView setBackgroundView:tableViewBackgroundView];
    self.dataSource = @[
                   @{@"name":@"添加项目",@"route":@"LSAddItemViewController",@"detail":@"增加一个新的项目",@"image":@"security-leftview-compose-icon.png"},
                   @{@"name":@"列表",@"route":@"LSMainViewController",@"detail":@"获取你的密码列表",@"image":@"security-leftview-list-icon.png"},
                   //@{@"name":@"关于我们",@"route":@"LSAboutAppViewController",@"detail":@"我们的设计理念",@"image":@"security-leftview-about-icon.png"},
                   @{@"name":@"用户反馈",@"route":@"feedback",@"detail":@"用户反馈",@"image":@""},
                   @{@"name":@"关于我们",@"route":@"LSAboutAppViewController",@"detail":@"我们的设计理念",@"image":@""},
                   @{@"name":@"设置手势",@"route":@"settingPattern",@"detail":@"设置手势",@"image":@""},

                   ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell.textLabel setText:[[self.dataSource objectAtIndex:index] objectForKey:@"name"]];
    [cell.textLabel setAlpha:0.8];
    [cell.textLabel setTextColor:[UIColor greenColor]];
    
    [cell.detailTextLabel setText:[[self.dataSource objectAtIndex:index] objectForKey:@"detail"]];
    [cell.detailTextLabel setAlpha:0.8];
    [cell.detailTextLabel setTextColor:[UIColor whiteColor]];
    if ([[self.dataSource objectAtIndex:index] objectForKey:@"image"]) {
        cell.imageView.image = [LSImageUtil scaleImage:[UIImage imageNamed:[[self.dataSource objectAtIndex:index] objectForKey:@"image"]] toScale:0.2];
    }
    
    
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cellBackGroundView.alpha = 0.4;
    [cellBackGroundView setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:(1.0f*(index+1))/(self.dataSource.count) alpha:0.4]];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = cellBackGroundView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    NSString *route = [[self.dataSource objectAtIndex:index] objectForKey:@"route"];
    UINavigationController *mainNavigation;
    if ([route isEqualToString:@"LSMainViewController"]) {
        LSMainViewController *navigationRootController = [[LSMainViewController alloc]initWithNibName:@"LSMainViewController" bundle:Nil];
        mainNavigation = [[UINavigationController alloc]initWithRootViewController:navigationRootController];
        [self.revealController setFrontViewController:mainNavigation];

        
    } else if ([route isEqualToString:@"LSAddItemViewController"]) {
        LSAddItemViewController *navigationRootController = [[LSAddItemViewController alloc]initWithNibName:@"LSAddItemViewController" bundle:Nil];
        [self.revealController setFrontViewController:navigationRootController];

    } else if([route isEqualToString:@"LSAboutAppViewController"]) {
        LSAboutAppViewController *navigationRootController = [[LSAboutAppViewController alloc]initWithNibName:@"LSAboutAppViewController" bundle:Nil];
        [self.revealController setFrontViewController:navigationRootController];
    } else if ([route isEqualToString:@"settingPattern"]) {
        [self applicationPatternSetting];
    } else if([route isEqualToString:@"feedback"]) {
        [UMFeedback showFeedback:self.revealController withAppkey:@"524258f056240b60c0059f76"];
    }
    
    [self.revealController showViewController:self.revealController.frontViewController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 39;
}


- (void)togglePresentationMode:(id)sender
{
    if (![self.revealController isPresentationModeActive]) {
        [self.revealController enterPresentationModeAnimated:YES
                                                  completion:NULL];
    } else {
        [self.revealController resignPresentationModeEntirely:NO
                                                     animated:YES
                                                   completion:NULL];
    }
}

- (void)applicationPatternSetting
{
    LSSreenLockViewController *lockViewController = [[LSSreenLockViewController alloc]init];
    lockViewController.infoLabelStatus = InfoStatusFirstTimeSetting;
    [self.revealController presentViewController:lockViewController animated:YES completion:^{
    
    }];
}

@end
