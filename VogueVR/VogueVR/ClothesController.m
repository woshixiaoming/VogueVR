//
//  ClothesController.m
//  VogueVR
//
//  Created by Heaven on 16/5/24.
//  Copyright © 2016年 Doe. All rights reserved.
//

#import "ClothesController.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface ClothesController ()

@end

@implementation ClothesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self createTextFiled];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createTextFiled{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(2, 64, WIDTH - 4, 40)];
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    textField.leftView.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"h4.jpg"]];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField.leftView addSubview:imageView];
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.layer.cornerRadius = 8;
    textField.backgroundColor = [UIColor whiteColor];
    textField.alpha = 0.8;
    
    [self.view addSubview:textField];
}

@end
