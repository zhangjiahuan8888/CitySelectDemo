//
//  ViewController.m
//  CitySelectDemo
//
//  Created by 张家欢 on 16/7/12.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "ViewController.h"
#import "CitySelectedViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.bounds.size.width-200)/2, 150, 200, 40);
    [btn setTitle:@"选择城市" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-200)/2, 250, 200, 40)];
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}
- (void)selectCity{
    CitySelectedViewController *cityVC = [[CitySelectedViewController alloc] init];
    cityVC.cityBlock = ^(NSString *city){
        _label.text = city;
    };
    [self.navigationController pushViewController:cityVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
