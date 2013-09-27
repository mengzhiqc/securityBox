//
//  LSMainViewController.m
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSMainViewController.h"
#import "PKRevealController.h"
#import "LSDetailViewController.h"
#import "LSPWDEntityModel.h"
#import "LSPWDEntity.h"
#import "LSImageUtil.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
#pragma mark - tableView
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

    [cell.textLabel setText:[[self.dataSource objectAtIndex:row] valueForKey:@"name"]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:1.0f*(row)/(self.dataSource.count+5) green:0.3f blue:0.5f alpha:1]];
    [cell.detailTextLabel setText:[[self.dataSource objectAtIndex:row] valueForKey:@"passwd"]];
    [cell setBackgroundColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSDetailViewController *detailController = [[LSDetailViewController alloc]initWithNibName:@"LSDetailViewController" bundle:nil];
    NSInteger row = [indexPath row];
    NSManagedObject *passwdInfoManagedObject = [self.dataSource objectAtIndex:row];
    detailController.passwdInfoManagedObject = passwdInfoManagedObject;
    [self.navigationController pushViewController:detailController animated:YES];
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
    self.dataSource = [LSPWDEntityModel passwdList];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *tableViewBackgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [tableViewBackgroundView setBackgroundColor: [UIColor colorWithPatternImage:[LSImageUtil scaleImage:[UIImage imageNamed:@"security-mainview-background.png"] toScale:0.5]]];
    [self.tableView setBackgroundView:tableViewBackgroundView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

@end
