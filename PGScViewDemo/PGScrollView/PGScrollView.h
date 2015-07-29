//
//  PGScrollView.h
//  PGScViewDemo
//
//  Created by Paul.Guo on 15/7/21.
//  Copyright (c) 2015年 Paul.Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PGSBlock) (int page  , BOOL left , BOOL right , BOOL isTap );

@interface PGScrollView : UIScrollView

@property(nonatomic , strong)UIView *bcView;
@property(nonatomic , strong)NSArray *array;
@property(nonatomic , assign)CGFloat offsetX;
@property(nonatomic , strong)PGSBlock pgBlock;

@end
