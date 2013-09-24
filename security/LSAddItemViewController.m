//
//  LSAddItemViewController.m
//  security
//
//  Created by 孟 智 on 13-9-23.
//  Copyright (c) 2013年 孟 智. All rights reserved.
//

#import "LSAddItemViewController.h"
#import "LSPWDEntityModel.h"
#import "LSPWDEntity.h"

@interface LSAddItemViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) UIView *inputAreaOverLay;
- (IBAction)addButtonClicked:(id)sender;

@end

@implementation LSAddItemViewController

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
    //[self addDemo];
    [self setup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDemo
{
    NSArray *dataSource = @[
      @{@"name":@"Apple iTunes",@"passwd":@"123456",@"comment":@"xxx",@"timestamp":@(12232222)},
      @{@"name": @"招商银行",@"passwd":@"23456sx",@"comment":@"xxx",@"timestamp":@(12232222)},
      @{@"name": @"淘宝支付宝",@"passwd":@"23456sx",@"comment":@"xxx",@"timestamp":@(12232222)},
      @{@"name": @"建设银行",@"passwd":@"23456sx",@"comment":@"xxx",@"timestamp":@(12232222)},
      @{@"name": @"笔记本密码",@"passwd":@"23456sx",@"comment":@"xxx",@"timestamp":@(12232222)},
      ];
    for (NSDictionary *item in dataSource) {
        LSPWDEntity *passwd = [[LSPWDEntity alloc]init];
        passwd.name = [item objectForKey:@"name"];
        passwd.comment = [item objectForKey:@"comment"];
        passwd.passwd = [item objectForKey:@"passwd"];
        passwd.timestamp = [item objectForKey:@"timestamp"];
        [LSPWDEntityModel insertPwdInfo:passwd];
    }
    
}

#pragma mark - buttonEvent
- (IBAction)addButtonClicked:(id)sender {
    CGRect frame = self.addButton.frame;
    frame.origin.y = frame.origin.y-100;
    [UIView animateWithDuration:0.35 animations:^{
        [self.addButton setFrame:frame];
        [self.addButton setAlpha:0];
        [self showInputLayout:frame];

    }];
}

- (void)showInputLayout:(CGRect)frame
{
    //frame.origin.y = 100;
    frame.origin.x -= 35;
    frame.size.width += 60;
    frame.size.height += 200;
    [self.inputAreaOverLay setAlpha:1.0];
    [self.inputAreaOverLay setFrame:frame];
}

- (void)setup
{
    self.inputAreaOverLay = [[UIView alloc]initWithFrame:CGRectMake(-1, 250, -1, 1)];
    [self.inputAreaOverLay setClipsToBounds:YES];
    
    UITextField *nameTextField = [self createCustomUiTextField:0 placeHolder:@"请输入名称" selector:nil tag:1001];
    [self.inputAreaOverLay addSubview:nameTextField];
    
    UITextField *passwdTextField = [self createCustomUiTextField:1 placeHolder:@"请输入密码" selector:nil tag:1002];
    [self.inputAreaOverLay addSubview:passwdTextField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setFrame:CGRectMake(0, 2*55+20, 250, 50)];
    [submitButton setBackgroundColor:[UIColor colorWithRed:58.0f/255 green:144.0f/255 blue:249.0f/255 alpha:0.75]];
    [submitButton setTag:1003];
    [submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchDown];
    [self.inputAreaOverLay addSubview:submitButton];

    
    [self.view addSubview:self.inputAreaOverLay];
}

- (UITextField *)createCustomUiTextField:(int)index placeHolder:(NSString *)placeHolder selector:(SEL)selector tag:(int)tag
{
    UITextField *nameInputView = [[UITextField alloc]initWithFrame:CGRectMake(0, index*55, 250, 50)];
    [nameInputView setTextColor:[UIColor whiteColor]];
    [nameInputView setBackgroundColor:[UIColor colorWithRed:58.0f/255 green:144.0f/255 blue:249.0f/255 alpha:0.75]];
    [nameInputView setPlaceholder:placeHolder];
    [nameInputView setHighlighted:YES];
    [nameInputView setAdjustsFontSizeToFitWidth:YES];
    [nameInputView setFont:[UIFont systemFontOfSize:18]];
    
    if (tag == 1001) {
        [nameInputView setReturnKeyType:UIReturnKeyNext];
    } else {
        [nameInputView setReturnKeyType:UIReturnKeyGo];
    }
    
    [nameInputView setTag:tag];
    [[nameInputView layer] setShadowOffset:CGSizeMake(2, 2)];
    [[nameInputView layer] setShadowRadius:6];
    [[nameInputView layer] setShadowOpacity:0.4];
    [[nameInputView layer] setShadowColor:[UIColor blackColor].CGColor];
    nameInputView.delegate = self;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    UILabel *leftViewLabel = [[UILabel alloc]initWithFrame:leftView.bounds];
//    [leftViewLabel setText:@"用户名"];
//    [leftView addSubview:leftViewLabel];
    [nameInputView setLeftView:leftView];
    [nameInputView setLeftViewMode:UITextFieldViewModeAlways];
    return nameInputView;
}

- (void)submitButtonClicked
{

    UITextField *nameField = (UITextField *)[self.inputAreaOverLay viewWithTag:1001];
    NSString *nameValue = nameField.text;
    
    UITextField *password = (UITextField *)[self.inputAreaOverLay viewWithTag:1002];
    NSString *passwordValue = password.text;
    
    if ([nameValue isEqualToString:@""]||[passwordValue isEqualToString:@""]) {
        [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"名称或者密码为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:Nil, nil] show];

    } else {
    //清除上一次记录，为后面的输入做准备
    [nameField setText:@""];
    [password setText:@""];
    
    LSPWDEntity *passwd = [[LSPWDEntity alloc]init];
    passwd.name = nameValue;
    passwd.comment = @"";
    passwd.passwd = passwordValue;
    passwd.timestamp = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
    [LSPWDEntityModel insertPwdInfo:passwd];
    
    [UIView animateWithDuration:0.75 animations:^{
        CGRect frame = self.addButton.frame;
        [self.inputAreaOverLay setFrame:CGRectMake(-100, 0, 10, 10)];
        [self.inputAreaOverLay setAlpha:0];
        frame.origin.y += 100;
        [self.addButton setFrame:frame];
        self.addButton.alpha = 10;
    }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 1001 || textField.tag == 1002) {
        NSInteger nextTag = textField.tag + 1;
        UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            if (nextTag == 1002) {
                [nextResponder becomeFirstResponder];
            } else {
                [self submitButtonClicked];
            }
        } else {
            [textField resignFirstResponder];
        }
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
