//
//  HorizontalMenuView.m
//  水平菜单栏Horizontal menu bar
//
//  Created by 陈家庆 on 15-3-2.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import "HorizontalMenuView.h"

@implementation HorizontalMenuView

/*
//iOS8 SDK要自己添加这个方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark- 创建菜单名数组和设置菜单名方法
-(void)setNameWithArray:(NSArray*)menuArray{
    
    _menuArray = menuArray;
    
    //一个间隔
    CGFloat SPACE = (self.frame.size.width)/[_menuArray count];
    
    for (int i = 0; i<[menuArray count];i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SPACE*i, 0, SPACE, self.frame.size.height);

        
        btn.tag = i;
        if (btn.tag == 0) {
            btn.enabled = NO;
        }
        
        //设置按钮字体大小 颜色 状态
        
        //[btn setTitle:menuArray[i] forState:UIControlStateNormal];下面的代替
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[menuArray objectAtIndex:i]];
        [str addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, [str  length])];
        [btn setAttributedTitle:str forState:UIControlStateNormal];
        
        NSMutableAttributedString *selStr = [[NSMutableAttributedString alloc]initWithString:[menuArray objectAtIndex:i]];
        [selStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, [str  length])];
        [btn setAttributedTitle:selStr forState:UIControlStateDisabled];
        
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //分割线
        if (i>0 && self.frame.size.height>16) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SPACE*i, 8, 1, self.frame.size.height-16)];
            line.backgroundColor = [UIColor grayColor];
            [self addSubview:line];
        }
    }
    //底部划线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-2.5, self.frame.size.width, 1.5)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    
    //标识当选被选中下划线
    UIView *markLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-4, SPACE+1, 3)];
    markLine.tag = 999;
    markLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:markLine];
}

#pragma mark- 菜单按钮点击事件
- (void)btnClick:(UIButton*)sender{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            if (subBtn.tag == sender.tag) {
                [subBtn setEnabled:NO];
            }else {
                [subBtn setEnabled:YES];
            }
        }
    }
    
    //计算每个按钮间隔
    CGFloat SPACE = (self.frame.size.width)/[_menuArray count];
    
    UIView *markView = [self viewWithTag:999];
    [UIView animateWithDuration:0.2f animations:^{
        CGRect markFrame =markView.frame;
        markFrame.origin.x = sender.tag*SPACE;
        markView.frame = markFrame;
    }];

    if ([self.myDelegate respondsToSelector:@selector(getTag:)]) {
        [self.myDelegate getTag:sender.tag];
    }
}

-(void)dealloc{
    _menuArray = nil;
    _myDelegate = nil;
}
/*
 使用方法
 #import "ViewController.h"
 
 #import "HorizontalMenuView.h"  //1.包含头文件
 
 @interface ViewController ()<HorizontalMenuProtocol>   //2.添加协议委托代理
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     
 //3.创建并初始化，添加至视图
     HorizontalMenuView *menuView = [[HorizontalMenuView alloc]init];
     menuView.frame = CGRectMake(0, 80,self.view.frame.size.width,45 );
     menuView.backgroundColor = [UIColor groupTableViewBackgroundColor];
     [self.view addSubview:menuView];
 //4.设置菜单名数组
     NSArray *menuArray = [NSArray arrayWithObjects:@"今日最新",@"今日推荐",@"全部", nil];
     [menuView setNameWithArray:menuArray];
 //5.设置委托代理
     menuView.myDelegate=self;
 
 }
 //6.实现协议方法
 -(void)getTag:(NSInteger)tag{
     NSLog(@"菜单%ld",tag);
 }
 
 */

@end
