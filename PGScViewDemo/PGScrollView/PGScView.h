//
//  PGScView.h
//  PGScViewDemo
//
//  Created by Paul.Guo on 15/7/23.
//  Copyright (c) 2015年 Paul.Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PGScViewDelegate <NSObject>

@required
- (void)itemWherePage:(int)page contentName:(NSString *)contentName isTap:(BOOL)isTap;

@end




@interface PGScView : UIScrollView

@property(nonatomic , strong)NSArray *array;
@property(nonatomic , assign)CGFloat offsetX;
@property(nonatomic , assign)id<PGScViewDelegate>pgDelegate;

@end