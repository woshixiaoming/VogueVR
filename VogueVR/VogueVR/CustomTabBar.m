//
//  CustomTabBar.m
//  VogueVR
//
//  Created by Heaven on 16/5/27.
//  Copyright © 2016年 Doe. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar ()
@property (nonatomic, strong) UIButton *plusBtn;
@end


@implementation CustomTabBar


-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateHighlighted];
        CGRect rect = plusBtn.frame;
        rect.size = plusBtn.currentBackgroundImage.size;
        plusBtn.frame = rect;
        plusBtn.backgroundColor = [UIColor blackColor];
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        
    }
    
    
    return self;
    
}


-(void)plusClick {
    
    //通知代理
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGPoint center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height *0.5);
    //设置加号的位置
    self.plusBtn.center = center;
    //设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonIndex = 0;
     CGFloat tabBarButtonW  = self.frame.size.width / 5;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            CGRect rect = child.frame;
            rect.size.width = tabBarButtonW;
            rect.origin.x = tabbarButtonIndex *tabBarButtonW;
            child.frame = rect;
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex ++;
            }
        }
    }
}


@end
