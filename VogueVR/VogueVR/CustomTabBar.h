//
//  CustomTabBar.h
//  VogueVR
//
//  Created by Heaven on 16/5/27.
//  Copyright © 2016年 Doe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabBar;;
@protocol XFTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(CustomTabBar *)tabBar;
@end


@interface CustomTabBar : UITabBar

@property(nonatomic,weak)id <XFTabBarDelegate> delegate;


@end
