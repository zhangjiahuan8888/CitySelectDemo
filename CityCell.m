//
//  CityCell.m
//  cityListSelectedDEMO
//
//  Created by 张家欢 on 16/4/5.
//  Copyright © 2016年 dongfangfuhai. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitles:(NSArray *)titles{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
        for (NSInteger i=0; i<titles.count; i++) {
            
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cityBtn.frame = CGRectMake(i%3*((320-24-15-26)/3+10)+15, i/3*(30+10)+10, (320-24-15-26)/3, 30);
            cityBtn.tag = 100+i;
            cityBtn.layer.cornerRadius = 3;
            cityBtn.layer.borderColor = [UIColor grayColor].CGColor;
            cityBtn.layer.borderWidth = .5;
            [cityBtn setTitle:titles[i] forState:UIControlStateNormal];
            [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [cityBtn setBackgroundColor:[UIColor whiteColor]];
            cityBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [cityBtn addTarget:self action:@selector(clickCityBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:cityBtn];
        }

    }
    return self;
}

- (void)setCitys:(NSArray *)citys{
    _citys = citys;
    for (NSInteger i=0; i<_citys.count; i++) {
        
        UIButton *button = [self.contentView viewWithTag:(100+i)];
        
        [button setTitle:_citys[i] forState:UIControlStateNormal];
    }
    for (NSInteger j=_citys.count; j<35; j++) {
        UIButton *button = [self.contentView viewWithTag:(100+j)];
        
        [button setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)clickCityBtn:(UIButton *)btn{

    btn.layer.borderWidth = .5;
    self.selectedCityBlock(btn.titleLabel.text);
}
@end
