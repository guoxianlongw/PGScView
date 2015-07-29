//
//  PGScrollView.m
//  PGScViewDemo
//
//  Created by Paul.Guo on 15/7/21.
//  Copyright (c) 2015年 Paul.Guo. All rights reserved.
//

#import "PGScrollView.h"
#import "Header.h"

@interface PGScrollView ()<UIScrollViewDelegate>

@end



@implementation PGScrollView

- (UIView *)bcView
{
    if (_bcView == nil) {
        _bcView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ITEMWIDTH , PGHEIGHT )];
        [self addSubview:_bcView];
    }
    return _bcView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewss];
    }
    return self;
}


- (void)initViewss
{
    self.bcView.backgroundColor = [UIColor clearColor];
    self.bounces = NO;
    
    //点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
}


- (void)setOffsetX:(CGFloat)offsetX
{
    self.bcView.frame  = CGRectMake(offsetX*ITEMWIDTH/kscreenWidth, 0, ITEMWIDTH, PGHEIGHT );
    
    [self setNeedsDisplay];

    /*** pgScView滑动效果 ***/
    int page = floor((offsetX - kscreenWidth / 2) / kscreenWidth) + 1;
   
    [self scrollToItem:page isTap:NO];
    
}


#pragma mark - tapAction
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    
    int whereItem = point.x / ITEMWIDTH ;  //第几个item。从0开始

    [self scrollToItem:whereItem isTap:YES];
    
    self.bcView.frame = CGRectMake (ITEMWIDTH*whereItem , 0, ITEMWIDTH, PGHEIGHT);
    
    [self setNeedsDisplay];
}

/*** pgScView滑动效果 ***/
- (void)scrollToItem:(int)page isTap:(BOOL)isTap
{
    BOOL leftBool  = ITEMWIDTH*page + ITEMWIDTH/2 > kscreenWidth/2 ? YES : NO ;
    BOOL rightBool = ITEMWIDTH*(self.array.count-page-1) + ITEMWIDTH/2  > kscreenWidth/2 ? YES : NO ;
    
    if (leftBool && rightBool) {
        if (self.pgBlock) {
            self.pgBlock (page , YES , YES , isTap) ;
        }
    } else {
        if (self.pgBlock) {
            self.pgBlock (page , !leftBool , !rightBool , isTap);
        }
    }
}





#pragma mark - drawRect
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    UIFont *font = [UIFont systemFontOfSize:PGFONT];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSFontAttributeName : font ,
                          NSForegroundColorAttributeName : NORMALFONTCOLOR,
                          NSParagraphStyleAttributeName : style
                          };
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat textTextHeight = [obj boundingRectWithSize: CGSizeMake( ITEMWIDTH , INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: dic context: nil].size.height;
        [obj drawInRect:CGRectMake(idx*ITEMWIDTH, (PGHEIGHT-textTextHeight)/2 , ITEMWIDTH, PGHEIGHT) withAttributes:dic];
    }];
    [[UIColor clearColor] setStroke];
    CGContextStrokePath(ref);
    
    
    
    CGContextRestoreGState(ref);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bcView.frame];
    [path addClip];
    NSDictionary *dic1 = @{NSFontAttributeName : font ,
                           NSForegroundColorAttributeName : SELECTFONTCOLOR,
                           NSParagraphStyleAttributeName : style
                           };
    [self.array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat textTextHeight = [obj boundingRectWithSize: CGSizeMake( ITEMWIDTH , INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: dic context: nil].size.height;
        [obj drawInRect:CGRectMake(idx*ITEMWIDTH, (PGHEIGHT-textTextHeight)/2 , ITEMWIDTH, PGHEIGHT) withAttributes:dic1];
    }];
    CGContextAddPath(ref, path.CGPath);
    [[UIColor clearColor] setStroke];
    CGContextDrawPath(ref, kCGPathStroke);
    
    
    
    
    
    
}



























@end
