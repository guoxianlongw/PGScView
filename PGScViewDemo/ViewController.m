//
//  ViewController.m
//  PGScViewDemo
//
//  Created by Paul.Guo on 15/7/21.
//  Copyright (c) 2015年 Paul.Guo. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "PGScView.h"



@interface ViewController ()<UIScrollViewDelegate , PGScViewDelegate>
{
    PGScView *_pgView;
    
    NSArray *labelArr;
    UIScrollView *scView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //nav部分
    [self initNav];
    labelArr = @[@"新闻", @"军事", @"政治", @"娱乐", @"财经" , @"游戏" ,  @"健康" ,  @"视频" ,  @"时尚" ];
    //内容部分
    [self initContentScView];

    
    
    
    
    
    
    /**
     *   共3部分
     */
    
    
    
    /**************************** 1 part ***********************************/
    _pgView = [[PGScView alloc] initWithFrame:CGRectMake(0, 70, kscreenWidth , PGHEIGHT )];
    _pgView.array = labelArr;
    _pgView.pgDelegate = self;
    [self.view addSubview:_pgView];
    
    
    
    
    
    
}



/**************************** 2 part ***********************************/
/**  当点击的时候，不让走didscroll代理 , 如果在点击事件中走代理，会有bug **/
static BOOL _isTap ;


//内容部分的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //只有在不是点击事件中才允许走下面的方法
    if (!_isTap)
    {
        _pgView.offsetX = scrollView.contentOffset.x ;
    }
    
    _isTap = NO;
}



/**************************** 3 part ***********************************/
- (void)itemWherePage:(int)page contentName:(NSString *)contentName isTap:(BOOL)isTap
{
    NSLog(@"您选中的item索引位置为=【%d】, 选中的名字为=【%@】， 是否是点击的事件(还有滑动)=【%d】", page , contentName, isTap);
   
    _isTap = isTap;
    if (isTap) {
        [scView setContentOffset:CGPointMake(page *kscreenWidth, 0) animated:YES];
    }
    
}













#pragma mark - 内容部分，非重要部分
- (void)initContentScView
{
    scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120 , kscreenWidth, 300)];
    scView.contentSize = CGSizeMake(320*labelArr.count, scView.bounds.size.height);
    scView.pagingEnabled = YES;
    scView.delegate = self;
    for (int i=0; i<labelArr.count; i++) {
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(kscreenWidth*i , 0, kscreenWidth , scView.frame.size.height)];
        myView.backgroundColor = [self randomColor];
        [scView addSubview:myView];
    }
    [self.view addSubview:scView];
}

- (UIColor *)randomColor
{
   return  [UIColor colorWithRed:arc4random_uniform(256) / 255.0
                     green:arc4random_uniform(256) / 255.0
                      blue:arc4random_uniform(256) / 255.0
                     alpha:1];
}



- (void)initNav
{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kscreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRed:0.87 green:0.25 blue:0.26 alpha:1];
    [self.view addSubview:navView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kscreenWidth, 44)];
    titleLabel.text = @"今日头条";
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [navView addSubview:titleLabel];
    
    

}





@end
