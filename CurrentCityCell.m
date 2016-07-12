//
//  CurrentCityCell.m
//  rongcaiyi
//
//  Created by 张家欢 on 16/4/7.
//  Copyright © 2016年 dongfangfuhai. All rights reserved.
//

#import "CurrentCityCell.h"

@implementation CurrentCityCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, 320-24-6-15, 30)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.cornerRadius = 3;
        backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
        backgroundView.layer.borderWidth = .5;
        [self.contentView addSubview:backgroundView];
        
        self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8.5, 100, 13)];
        self.locationLabel.text = @"正在定位中···";
        self.locationLabel.font = [UIFont systemFontOfSize:12];
        self.locationLabel.textColor = [UIColor redColor];
        [backgroundView addSubview:self.locationLabel];
    }
    return self;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
