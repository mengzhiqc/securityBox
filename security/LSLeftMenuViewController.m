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
#import "LSAppDelegate.h"

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
    [self.revealController setMinimumWidth:120.0f maximumWidth:240.0f forViewController:self];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.dataSource = @[
                   @{@"name":@"列表",@"route":@"LSMainViewController"},
                   @{@"name":@"添加项目",@"route":@"LSAddItemViewController"}
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.textLabel setText:[[self.dataSource objectAtIndex:index] objectForKey:@"name"]];
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
        mainNavigation = [[UINavigationController alloc]initWithRootViewController:navigationRootController];
        [self.revealController setFrontViewController:navigationRootController];

    }
    
    [self.revealController showViewController:self.revealController.frontViewController animated:YES completion:nil];
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

@end
