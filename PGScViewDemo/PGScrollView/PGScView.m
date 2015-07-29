//
//  PGScView.m
//  PGScViewDemo
//
//  Created by Paul.Guo on 15/7/23.
//  Copyright (c) 2015年 Paul.Guo. All rights reserved.
//

#import "PGScView.h"
#import "PGScrollView.h"
#import "Header.h"
@interface PGScView ()<UIScrollViewDelegate>
{
    int _newPage;
}
@property(nonatomic , strong)PGScrollView *pg;

@end



@implementation PGScView

- (PGScrollView *)pg
{
    if (_pg==nil) {
        _pg = [[PGScrollView alloc] initWithFrame:CGRectMake(0, 0, ITEMWIDTH * self.array.count , PGHEIGHT )];
        _pg.backgroundColor = PGBACKCOLOR;
        [self addSubview:_pg];
    }
    return _pg;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentSize = CGSizeMake( ITEMWIDTH * self.array.count , PGHEIGHT);
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.delegate = self;
    
    self.pg.array = self.array ;
    
    __weak PGScView *_weakSV = self;
    
    _pg.pgBlock = ^(int page , BOOL left , BOOL right , BOOL isTap ) {
        
        //相应事件代理
        int oldPage = _newPage;
        _newPage = page ;
        if (_newPage != oldPage) {
            // item 改变
            if (_weakSV.pgDelegate && [_weakSV.pgDelegate respondsToSelector:@selector(itemWherePage:contentName:isTap:)]) {
                [_weakSV.pgDelegate itemWherePage:_newPage contentName:_weakSV.array[_newPage] isTap:isTap];
            }
        }
        
        //左右滑动的处理
        if (left && right) {
            
            [_weakSV setContentOffset:CGPointMake( +(ITEMWIDTH*page+ITEMWIDTH/2) - kscreenWidth/2 , 0) animated:YES];
            
        }
        //针对最左边，最右边的处理-左右滑动
        else {
            if (left && !right) {
                [_weakSV setContentOffset:CGPointMake(0, 0) animated:YES];
            } else if(!left && right) {
                [_weakSV setContentOffset:CGPointMake(_weakSV.array.count*ITEMWIDTH-kscreenWidth , 0) animated:YES];
            }
        }
        
    };
}


- (void)setOffsetX:(CGFloat)offsetX
{
    self.pg.offsetX = offsetX;
}



@end
