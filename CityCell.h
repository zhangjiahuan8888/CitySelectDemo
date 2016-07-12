//
//  CityCell.h
//  cityListSelectedDEMO
//
//  Created by 张家欢 on 16/4/5.
//  Copyright © 2016年 dongfangfuhai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectedCityBlock)(NSString *);

@interface CityCell : UITableViewCell

@property (nonatomic,strong) NSArray *citys;
@property (nonatomic,copy) SelectedCityBlock selectedCityBlock;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTitles:(NSArray *)titles;
@end
