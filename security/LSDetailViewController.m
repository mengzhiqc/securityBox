//
//  LSDetailViewController.m
//  security
//
//  Created by 孟 智 on 13-9-24.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSDetailViewController.h"
#import "LSPWDEntityModel.h"

@interface LSDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation LSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameTextField.text = [self.passwdInfoManagedObject valueForKey:@"name"];
    self.passwdTextField.text = [self.passwdInfoManagedObject valueForKey:@"passwd"];
    [self.saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [[self.saveButton layer] setShadowOffset:CGSizeMake(2, 2)];
    [[self.saveButton layer] setShadowRadius:6];
    [[self.saveButton layer] setShadowOpacity:0.4];
    [[self.saveButton layer] setShadowColor:[UIColor blackColor].CGColor];
    
    [self.deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [[self.deleteButton layer] setShadowOffset:CGSizeMake(2, 2)];
    [[self.deleteButton layer] setShadowRadius:6];
    [[self.deleteButton layer] setShadowOpacity:0.4];
    [[self.deleteButton layer] setShadowColor:[UIColor blackColor].CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveButtonPressed:(id)sender
{
    NSString *name = [(UITextField *)[[sender superview] viewWithTag:1004] text];
    NSString *passwd = [(UITextField *)[[sender superview] viewWithTag:1005] text];
    NSLog(@"name:%@, passwd:%@",name,passwd);
    [self.passwdInfoManagedObject setValue:name forKey:@"name"];
    [self.passwdInfoManagedObject setValue:passwd forKey:@"passwd"];
    
    [LSPWDEntityModel  updatePasswdInfo];
    [self.navigationController popViewControllerAnimated:YES];


}

- (void)deleteButtonPressed:(id)sender
{
    [LSPWDEntityModel removePasswdInfo:self.passwdInfoManagedObject];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
