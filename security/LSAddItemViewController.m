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
@property (weak, nonatomic) IBOutlet UILabel *welcomeTitle;
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
    [self setup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - buttonEvent
- (IBAction)addButtonClicked:(id)sender {
    CGRect frame = self.addButton.frame;
    [UIView animateWithDuration:0.35 animations:^{
        [self.addButton setFrame:frame];
        [self.addButton setAlpha:0];
        [self showInputLayout:frame];

    }];
}

- (void)showInputLayout:(CGRect)frame
{
    //frame.origin.y = 100;
    frame.size.height += 120;
    [self.inputAreaOverLay setAlpha:1.0];
    [self.inputAreaOverLay setFrame:frame];
}

- (void)setup
{
    self.inputAreaOverLay = [[UIView alloc]initWithFrame:CGRectMake(35, 194, 250, 0)];
    //[self.inputAreaOverLay setBackgroundColor:[UIColor colorWithRed:58.0f/255 green:144.0f/255 blue:249.0f/255 alpha:0.75]];
    [self.inputAreaOverLay setClipsToBounds:YES];
    
    UITextField *nameTextField = [self createCustomUiTextField:0 placeHolder:@"请输入名称" selector:nil tag:1001];
    [self.inputAreaOverLay addSubview:nameTextField];
    
    UITextField *passwdTextField = [self createCustomUiTextField:1 placeHolder:@"请输入密码" selector:nil tag:1002];
    [self.inputAreaOverLay addSubview:passwdTextField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setFrame:CGRectMake(0, 2*55+20, 250, 50)];
    [submitButton setBackgroundColor:[UIColor colorWithRed:58.0f/255 green:144.0f/255 blue:249.0f/255 alpha:1.0f]];
    [submitButton setTag:1003];
    [submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchDown];
    [self.inputAreaOverLay addSubview:submitButton];

    
    [self.view addSubview:self.inputAreaOverLay];
}

- (UITextField *)createCustomUiTextField:(int)index placeHolder:(NSString *)placeHolder selector:(SEL)selector tag:(int)tag
{
    UITextField *nameInputView = [[UITextField alloc]initWithFrame:CGRectMake(0, index*55, 250, 50)];
    [nameInputView setTextColor:[UIColor whiteColor]];
    [nameInputView setBackgroundColor:[UIColor colorWithRed:58.0f/255 green:144.0f/255 blue:249.0f/255 alpha:1]];
    //[nameInputView setBackgroundColor:[UIColor clearColor]];
    [nameInputView setPlaceholder:placeHolder];
    [nameInputView setHighlighted:YES];
    [nameInputView setAdjustsFontSizeToFitWidth:YES];
    [nameInputView setFont:[UIFont systemFontOfSize:18]];
    [nameInputView setBorderStyle:UITextBorderStyleRoundedRect];
    [nameInputView setClearButtonMode:UITextFieldViewModeWhileEditing];
    if (tag == 1001) {
        [nameInputView setReturnKeyType:UIReturnKeyNext];
    } else {
        [nameInputView setKeyboardType:UIKeyboardTypeASCIICapable];
        [nameInputView setReturnKeyType:UIReturnKeyGo];
    }
    
    [nameInputView setTag:tag];
    [[nameInputView layer] setShadowOffset:CGSizeMake(2, 2)];
    [[nameInputView layer] setShadowRadius:6];
    [[nameInputView layer] setShadowOpacity:0.4];
    [[nameInputView layer] setShadowColor:[UIColor blackColor].CGColor];
    nameInputView.delegate = self;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
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
        [self.inputAreaOverLay setFrame:CGRectMake(35, 194, 250, 0)];
        [self.inputAreaOverLay setAlpha:0];
        [self.addButton setFrame:frame];
        self.addButton.alpha = 1;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1002||textField.tag == 1001) {
        CGRect frame = self.inputAreaOverLay.frame;
        frame.origin.y -= 100;
        [self.inputAreaOverLay setFrame:frame];
        CGRect labelFrame = self.welcomeTitle.frame;
        labelFrame.origin.y -= 100;
        [self.welcomeTitle setFrame:labelFrame];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1002||textField.tag == 1001) {
        [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.inputAreaOverLay.frame;
        frame.origin.y += 100;
        [self.inputAreaOverLay setFrame:frame];
            
        CGRect labelFrame = self.welcomeTitle.frame;
        labelFrame.origin.y += 100;
        [self.welcomeTitle setFrame:labelFrame];
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
