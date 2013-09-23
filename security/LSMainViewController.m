//
//  LSMainViewController.m
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSMainViewController.h"
#import "PKRevealController.h"

@interface LSMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *dataSource;
@end

@implementation LSMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self prepareTableView];
    [self navigationBarIssue];
    
    [self.enterButton addTarget:nil action:@selector(enterButtonClicked) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --
#pragma mark - callbackEvent
- (void)enterButtonClicked
{
    NSLog(@"I'm clicked!!");
}

- (void)showLeftView
{
    if(self.navigationController.revealController.focusedController == self.navigationController.revealController.frontViewController) {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

#pragma --
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifierForMainList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    [cell.textLabel setText:[[self.dataSource objectAtIndex:row] objectForKey:@"name"]];
    [cell.detailTextLabel setText:[[self.dataSource objectAtIndex:row] objectForKey:@"passwd"]];

    return cell;
}

#pragma mark - setup
- (void)navigationBarIssue
{
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
}

- (void)prepareTableView
{
    self.dataSource = @[
                        @{@"name":@"Apple iTunes",@"passwd":@"123456"},
                        @{@"name": @"招商银行",@"passwd":@"23456sx"},
                        @{@"name": @"淘宝支付宝",@"passwd":@"23456sx"},
                        @{@"name": @"建设银行",@"passwd":@"23456sx"},
                        @{@"name": @"笔记本密码",@"passwd":@"23456sx"},

                        ];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
