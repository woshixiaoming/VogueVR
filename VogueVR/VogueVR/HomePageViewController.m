//
//  HomePageViewController.m
//  VogueVR
//
//  Created by Heaven on 15/5/24.
//  Copyright © 2016年 Doe. All rights reserved.
//

#import "HomePageViewController.h"
#import "HYBLoopScrollView.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)HYBLoopScrollView *loop;

@property (nonatomic,strong)HYBLoopScrollView *loop2;

@property (nonatomic,strong)UIScrollView *baseScroll;

@property (nonatomic,strong)UIScrollView *littleScroll;

@property (nonatomic,strong)UIImageView *imageView2;

/**
 *  ··········组头上的滑动·············
 */
@property (nonatomic,strong)UIScrollView *seScroller;

@property (nonatomic,strong)UICollectionView *colletionView; // 集合视图

@property (nonatomic,strong)UIView *baseView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 370)];
    self.baseView.userInteractionEnabled = YES;
    self.baseScroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.baseScroll.contentSize = CGSizeMake(0, self.view.bounds.size.height + 220);
    self.baseScroll.bounces = NO;
    self.baseScroll.delegate = self;
    [self.view addSubview:self.baseScroll];
    [self createScroll:0];
    [self createCollectionView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------------创建轮播-----------------------
- (void)createScroll:(int)index{
    // 这个图片会找不到，而显示默认图
    NSString *url = @"http://test.meirongzongjian.com/imageServer/user/3/42ccb9c75ccf5e910cd6f5aaf0cd1200.jpg";
    
    NSArray *imagess = @[@"http://s0.pimg.cn/group5/M00/5B/6D/wKgBfVaQf0KAMa2vAARnyn5qdf8958.jpg?imageMogr2/strip/thumbnail/1200%3E/quality/95",
                        @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/QQ20160322-0@2x.png",
                        @"h1.jpg",
                        [UIImage imageNamed:@"h2.jpg"],
                        @"http://s0.pimg.cn/group6/M00/45/84/wKgBjVZVjYCAEIM4AAKYJZIpvWo152.jpg?imageMogr2/strip/thumbnail/1200%3E/quality/95",
                        url,
                        @"http://7xrs9h.com1.z0.glb.clouddn.com/wp-content/uploads/2016/03/QQ20160322-5@2x-e1458635879420.png"
                        ];
    
    //  NSArray *titles = @[@"Thank you for your support!",
    //                      @"Contact me if any quetion.",
    //                      @"Email me huangyibiao520@163.com.",
    //                      @"Thank you again.",
    //                      @"博客：www.henishuo.com",
    //                      @"github: https://coderJackyHuang",
    //                      @"微博：weibo.com/huangyibiao520"
    //                      ];
    
    self.loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 130) imageUrls:imagess timeInterval:5 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
    }];
    self.loop.shouldAutoClipImageToViewSize = YES;
    self.loop.placeholder = [UIImage imageNamed:@"xixi"];
    self.loop.alignment = kPageControlAlignCenter;
    [self.baseView addSubview:self.loop];
    [self.loop clearImagesCache];
    
    self.loop2 = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0,200, self.view.bounds.size.width, 130) imageUrls:imagess timeInterval:5 didSelect:^(NSInteger atIndex) {
        
    } didScroll:^(NSInteger toIndex) {
    }];
    self.loop2.shouldAutoClipImageToViewSize = YES;
    self.loop2.placeholder = [UIImage imageNamed:@"xixi"];
    self.loop2.alignment = kPageControlAlignCenter;
    [self.baseView addSubview:self.loop2];
    [self.loop2 clearImagesCache];
    [self createButton];
}




#pragma mark ---------------创建button--------------
- (void)createButton{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 130, self.view.bounds.size.width, 70)];
    imageView.backgroundColor = [UIColor grayColor];
    [self.baseView addSubview:imageView];
    [self.baseScroll addSubview:self.baseView];
    
    self.seScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 330, self.view.bounds.size.width, 40)];
    self.seScroller.backgroundColor = [UIColor blueColor];
    self.seScroller.contentSize = CGSizeMake(1000, 0);
    [self.baseScroll addSubview:self.seScroller];
    NSArray *title1 = @[@"衣+百科",@"衣+红",@"新品穿衣",@"明天穿\n什么"];
    NSArray *title2 = @[@"关注",@"热门",@"精选",@"自定义+"];
    
    for (int j = 1; j < 3; j ++) {
        for (int i = 0; i < title1.count; i ++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i *(75+(WIDTH-300)/3) , 0, 75, 70)];
            button.backgroundColor = [UIColor redColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            if (j == 1) {
                [button setTitle:title1[i] forState:UIControlStateNormal];
                [imageView addSubview:button];
            }
            if (j == 2) {
                [button setTitle:title2[i] forState:UIControlStateNormal];
                [self.seScroller addSubview:button];
                button.frame = CGRectMake(i *(75+(WIDTH-300)/3), 0, 75, 40);
            }
            button.tag= j*100 + i;
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark -----------------------点击事件----------------------
- (void)onClick:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    
}

#pragma mark -------------------self.view显示的时候----------------
- (void)viewDidDisappear:(BOOL)animated{
    [self.loop pauseTimer];
    [self.loop2 pauseTimer];
}

#pragma mark -------------------self.view已经消失------------------
- (void)viewDidAppear:(BOOL)animated{
    [self.loop startTimer];
    [self.loop2 startTimer];
}

#pragma mark --------------------创建集合视图-----------------
- (void)createCollectionView
{
    // 创建集合视图对象
    // 设置集合视图的布局，系统自带的默认布局方式
    // 创建集合视图的布局
    // UICollectionViewFlowLayout 继承自UIColletionViewLayout
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 370, WIDTH, self.view.bounds.size.height-140) collectionViewLayout:layout];
    // 数据源
    _colletionView.dataSource = self;
    // 集合视图的代理方法
    _colletionView.delegate = self;
    
    // 设置是否可以选中(默认YES)
    _colletionView.allowsSelection = YES;
    
    // 设置是否可以多选(默认NO)
    _colletionView.allowsMultipleSelection = YES;
    
    // 添加集合视图到视图控制器上
    [self.baseScroll addSubview:_colletionView];
    
//     注册单元格类，如果是没有自定义UIColletionViewCell，使用系统的UICollectionViewCell
    [_colletionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 注册可复用的组头组尾（附加视图）
    // UICollectionElementKindSectionHeader 组头
    // UICollectionElementKindSectionFooter 组尾
    
    // 注册组头的可复用视图
    // 修改自定义的可复用视图
//    [_colletionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    
    // 注册组尾的可复用视图
//    [_colletionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
    // UICollectionViewFlowLayout的属性（通用属性）
    // 自定义时需在代理方法中实现
    // 滚动方向(默认为垂直方向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 垂直方向（宽度不变）
    //    UICollectionViewScrollDirectionVertical,
    // 水平方向（高度不变）
    //    UICollectionViewScrollDirectionHorizontal
    
    // 单元格之间的最小间隙
    layout.minimumInteritemSpacing = 10;
    // 最小行间距
    layout.minimumLineSpacing = 10;
    // 单元格大小（左边的单元格参考左上角，右边的单元格参考右上角）
    layout.itemSize = CGSizeMake(150 , 150);
    
    // 组头的大小
//    layout.headerReferenceSize = CGSizeMake(100, 370);
    // 组尾的大小
//    layout.footerReferenceSize = CGSizeMake(100, 100);
    
    // 组的位置
    // 组头：top left
    // 组尾：right bottom
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    _colletionView.bounces = NO;
    _colletionView.scrollEnabled = NO;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"---------------+%lf",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y >= 269) {
        scrollView.scrollEnabled = NO;
        _colletionView.frame = CGRectMake(0, 104, WIDTH, self.view.bounds.size.height - 144);
        _colletionView.scrollEnabled = YES;
        [self.colletionView removeFromSuperview];
        [self.view addSubview:_colletionView];
    }else if (scrollView.contentOffset.y <= 0 ){
         scrollView.contentSize = CGSizeMake(0, self.view.bounds.size.height + 220);
        [self.colletionView removeFromSuperview];
        _colletionView.frame = CGRectMake(0, 370, WIDTH, self.view.bounds.size.height-140);
        self.baseScroll.scrollEnabled = YES;
        _colletionView.scrollEnabled = NO;
        [self.baseScroll addSubview:self.colletionView];
    }else{
        return;
    }
}


@end
