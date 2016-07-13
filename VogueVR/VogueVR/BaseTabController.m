//
//  BaseTabController.m
//  VogueVR
//
//  Created by Heaven on 16/5/24.
//  Copyright © 2016年 Doe. All rights reserved.
//

#import "BaseTabController.h"
#import "BaseViewController.h"
#import "CustomTabBar.h"
#import "MineController.h"
#import "ClothesController.h"
#import "HomePageViewController.h"
#import "ClothCoilController.h"

#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HIGHT [UIScreen mainScreen].bounds.size.height
@interface BaseTabController ()<XFTabBarDelegate>

@property (nonatomic,strong)UIView *addView;

@property (nonatomic,strong)UIImageView *collocationView;//稀搭配

@property (nonatomic,strong)UIImageView *groupView;//新团购

@property (nonatomic,strong)UIImageView *circleView;//新圈子

@property (nonatomic,strong)UIButton *plus;

@end

@implementation BaseTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---------------创建viewcontroller-----------------
- (void)createViewController{
    NSMutableArray *marr = [[NSMutableArray alloc]init];
    NSArray *titleArr = @[@"首页",@"搜索",@"衣圈", @"我的"];
    NSArray *arr = @[@"HomePageViewController", @"ClothesController",@"ClothCoilController",@"MineController"];
//    NSArray *imgNormal = @[@"iconfont-shouye", @"iconfont-sousuo", @"iconfont-zixun", @"iconfont-my"];
//    NSArray *imgHight = @[@"iconfont-shouyeHight", @"iconfont-sousuoHight", @"iconfont-zixunHight", @"iconfont-myHight"];
    //    NSArray *imgPress = @[@"home_press.png", @"home_press.png",@"mine_press.png",@"mine_press.png"];
    for (NSInteger i = 0; i < arr.count; i ++) {
        
        Class clsName = NSClassFromString(arr[i]);
        BaseViewController *base = [[clsName alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:base];
        base.title = titleArr[i];
//        UIImage *imageNormal = [UIImage imageNamed:[imgNormal objectAtIndex:i]];
//        imageNormal = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIImage *imageHight = [UIImage imageNamed:imgHight[i]];
//        imageHight = [imageHight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        nc.tabBarItem.image = imageNormal;
//        nc.tabBarItem.selectedImage = imageHight;
        [marr addObject:nc];
        
    }
    self.viewControllers = marr;
    
    
    //更换系统自带的tabbar
    CustomTabBar *tab = [[CustomTabBar alloc]init];
    tab.delegate = self;
    [self setValue:tab forKey:@"tabBar"];
    
}

- (void)tabBarDidClickPlusButton:(CustomTabBar *)tabBar{
    NSLog(@"-------------");
    [self showOrHideAddView:YES];
}

- (void)showOrHideAddView:(BOOL)boo{
    self.addView = [[UIView alloc]initWithFrame:self.view.frame];
    self.addView.backgroundColor = [UIColor orangeColor];
    self.addView.alpha = 1;
    [self.view addSubview:self.addView];
    UIImageView *compose = [[UIImageView alloc]init];
    [compose setImage:[UIImage imageNamed:@"compose_slogan"]];
    compose.frame = CGRectMake(0, 100, self.view.frame.size.width, 48);
    compose.contentMode = UIViewContentModeCenter;
    [self.addView addSubview:compose];

    
    UIView *bottom = [[UIView alloc]init];
    
    bottom.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.height, 44);
    
    bottom.backgroundColor = [UIColor whiteColor];
    
    //bottom.contentMode = UIViewContentModeCenter;
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    
    plus.frame = CGRectMake((self.view.bounds.size.width - 25) * 0.5, 8, 25, 25);
    
    [plus setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    
    [bottom addSubview:plus];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        plus.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.plus = plus;
        
    }];
    [plus addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.addView addSubview:bottom];
    
    CGFloat space = (kSCREEN_WIDTH - 210)/4;
    
    UIImageView *text = [self btnAnimateWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HIGHT, 70, 100) imageName:@"tabbar_compose_idea" text:@"新搭配" animateFrame:CGRectMake(space,kSCREEN_HIGHT/2, 70, 100) delay:0.0];
    text.backgroundColor = [UIColor redColor];
    [self setAction:text action:@selector(collocation:)];
    self.collocationView = text;
    UIImageView *ablum = [self btnAnimateWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HIGHT, 70, 100) imageName:@"tabbar_compose_photo" text:@"新团购" animateFrame:CGRectMake(2*space + 70,kSCREEN_HIGHT/2, 71, 100) delay:0.1];
    [self setAction:ablum action:@selector(pushGroup:)];
    self.groupView = ablum;
    ablum.backgroundColor = [UIColor redColor];
    
    UIImageView *camera = [self btnAnimateWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HIGHT, 70, 100) imageName:@"tabbar_compose_camera" text:@"新圈子" animateFrame:CGRectMake(3*space+140,kSCREEN_HIGHT/2, 71, 100) delay:0.15];
    [self setAction:camera action:@selector(circle:)];
    self.circleView= camera;
    camera.backgroundColor = [UIColor redColor];
}
#pragma mark ---------------push到新单配页面---------------------
- (void)collocation:(UIImageView *)imageView{
    [self closeClick];
}

#pragma mark ---------------push到新团购页面---------------------
- (void)pushGroup:(UIImageView *)imageView{
    [self closeClick];

}

#pragma mark ---------------push到新圈子页面---------------------
- (void)circle:(UIImageView *)imageView{
    [self closeClick];
}

#pragma mark ---------------点击按钮出现的动画-----------------
-(UIImageView *)btnAnimateWithFrame:(CGRect)frame imageName:(NSString *)imageName text:(NSString *)text animateFrame:(CGRect)aniFrame delay:(CGFloat)delay {
    
    UIImageView *btnContainer = [[UIImageView alloc]init];
    
    btnContainer.frame  = frame;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    [btnContainer addSubview:image];
    
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 71, 25)];
    [word setText:text];
    [word setTextAlignment:NSTextAlignmentCenter];
    [word setFont:[UIFont systemFontOfSize:15]];
    [word setTextColor:[UIColor grayColor]];
    word.backgroundColor = [UIColor greenColor];
    [btnContainer addSubview:word];
    
    [self.addView addSubview:btnContainer];
    
    [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnContainer.frame  = aniFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return btnContainer;
}

#pragma mark ---------------设置按钮方法---------
-(void)setAction:(UIImageView *)imageView action:(SEL)action{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    
}

#pragma mark ---------------点击关闭按钮------------------
-(void)closeClick {
    
    [UIView animateWithDuration:0.5 animations:^{
        // -------------------关闭动画---------------
        self.plus.transform = CGAffineTransformMakeRotation(-M_PI_2);
        [self btnCloseAnimateWithFrame:CGRectMake(self.view.bounds.size.width/2, 700, 71, 100) delay:0.15 btnView:self.collocationView];
        [self btnCloseAnimateWithFrame:CGRectMake(self.view.bounds.size.width/2, 700, 71, 100) delay:0.2 btnView:self.groupView];
        [self btnCloseAnimateWithFrame:CGRectMake(self.view.bounds.size.width/2, 700, 71, 100) delay:0.25 btnView:self.circleView];
        self.addView.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        [self.collocationView removeFromSuperview];
        [self.groupView removeFromSuperview];
        [self.circleView removeFromSuperview];
        [self.addView removeFromSuperview];
    }];

    
}

#pragma mark ---------------关闭动画-------------------
-(void)btnCloseAnimateWithFrame:(CGRect)rect delay:(CGFloat)delay btnView:(UIImageView *)btnView{
    
    [UIView animateWithDuration:0.3 delay:delay usingSpringWithDamping:0.5 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnView.frame  = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.addView.alpha != 0) {
        [self closeClick];
    }
}


@end
