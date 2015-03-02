//
//  HorizontalMenuView.h
//  水平菜单栏Horizontal menu bar
//
//  Created by 陈家庆 on 15-3-2.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 ***自定义协议
 */

@protocol HorizontalMenuProtocol <NSObject>

@optional//可选的方法

@required//必须实现的

-(void)getTag:(NSInteger)tag;//获取当前被选中下标值


@end



@interface HorizontalMenuView : UIView
    
@property(nonatomic,strong)NSArray *menuArray;//获取到的菜单名数组

-(void)setNameWithArray:(NSArray*)menuArray;//设置菜单名方法


//协议委托代理
@property (nonatomic,assign)id <HorizontalMenuProtocol> myDelegate;


@end


