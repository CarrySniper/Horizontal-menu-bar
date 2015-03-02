//
//  ViewController.m
//  水平菜单栏Horizontal menu bar
//
//  Created by 陈家庆 on 15-3-2.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import "ViewController.h"
//1.包含头文件
#import "HorizontalMenuView.h"
//2.添加协议委托代理
@interface ViewController ()<HorizontalMenuProtocol>{
    HorizontalMenuView *_menuView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationItem.title = @"水平菜单栏";
    
    //3.创建并初始化，添加至视图
    _menuView = [[HorizontalMenuView alloc]init];
    _menuView.frame = CGRectMake(0, 64,self.view.frame.size.width,45 );
    _menuView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_menuView];
    //4.设置菜单名数组
    NSArray *menuArray = [NSArray arrayWithObjects:@"今日最新",@"今日推荐",@"全部", nil];
    [_menuView setNameWithArray:menuArray];
    //5.设置委托代理
    _menuView.myDelegate=self;
    
}
//6.实现协议方法
-(void)getTag:(NSInteger)tag{
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_menuView.menuArray[tag]];
    NSLog(@"菜单%ld",tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
