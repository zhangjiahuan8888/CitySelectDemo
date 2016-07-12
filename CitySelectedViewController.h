//
//  ViewController.h
//  cityListSelectedDEMO
//
//  Created by 张家欢 on 16/4/5.
//  Copyright © 2016年 dongfangfuhai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CityBlock)(NSString *);

@interface CitySelectedViewController : UIViewController

//选中城市之后将城市名称返回
@property (nonatomic,copy) CityBlock cityBlock;
@end

