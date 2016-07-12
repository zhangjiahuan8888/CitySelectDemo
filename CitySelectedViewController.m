//
//  ViewController.m
//  cityListSelectedDEMO
//
//  Created by 张家欢 on 16/4/5.
//  Copyright © 2016年 dongfangfuhai. All rights reserved.
//

#import "CitySelectedViewController.h"
#import "CityCell.h"
#import "CurrentCityCell.h"


@interface CitySelectedViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
{
    NSDictionary *_citysDic;
    NSArray *_citysKeys;
    NSMutableArray *_indexArray; //索引数组
    UITableView *cityTableView;
}
@property(strong, nonatomic) UISearchController *searchController;
@property(strong, nonatomic) NSMutableArray *allCities; // 所有城市
@property(strong, nonatomic) NSMutableArray *filteredCities; // 根据searchController搜索的城市
@property(nonatomic,copy) NSString *currentCity;//当前城市
@end

@implementation CitySelectedViewController

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"EMcitydict_S" ofType:@"plist"];
    _citysDic = [NSDictionary dictionaryWithContentsOfFile:path];
    _citysKeys = @[@"热门城市",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    self.allCities = [NSMutableArray array];
    
    for (NSInteger i=1; i<_citysKeys.count; i++) {
        NSString *key = _citysKeys[i];
        NSArray *cities = _citysDic[key];
        [self.allCities addObjectsFromArray:cities];
    }
    
    _indexArray = [NSMutableArray arrayWithObjects:@"当前",@"历史",@"热门",nil];
    for (char ch='A'; ch<='Z'; ch++) {
        if (ch=='I' || ch=='O' || ch=='U' || ch=='V')
            continue;
        [_indexArray addObject:[NSString stringWithFormat:@"%c",ch]];
    }
    
    cityTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    cityTableView.dataSource = self;
    cityTableView.delegate = self;
    [cityTableView registerClass:[CityCell class] forCellReuseIdentifier:@"CityCell"];
    [cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:cityTableView];

    cityTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    cityTableView.sectionIndexColor = [UIColor redColor];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedCity) name:@"kSelectedCity" object:nil];
 
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"请输入城市名";
    cityTableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)selectedCity{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (!self.searchController.active) {
        return _citysDic.count;
    } else {
        return 1;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    if (!self.searchController.active) {
      
        return 1;
    } else {
        return self.filteredCities.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    if (!self.searchController.active) {

        
        CityCell *cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"CityCell" withTitles:_citysDic[_citysKeys[indexPath.section]]];
        cell.selectedCityBlock = ^(NSString *city){
            self.cityBlock(city);
            [self.navigationController popViewControllerAnimated:YES];
        };
        return cell;

    }else{
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.filteredCities[indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.searchController.active) {
        NSArray *arr = _citysDic[_citysKeys[indexPath.section]];
        NSInteger b = arr.count % 3;
        return b==0?(arr.count/3)*40+10:((arr.count/3)*40+50);

    } else {
        return 50;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (!self.searchController.active) {
        
        return 15;
    } else {
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return _citysKeys[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 15)];
    headerView.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 15)];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.text = _citysKeys[section];
    [headerView addSubview:titleLabel];
    return headerView;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _indexArray;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.searchController.active) {
        if (indexPath.section==0&&indexPath.row==0) {
            CurrentCityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            self.cityBlock(cell.locationLabel.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.cityBlock(cell.textLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchController.searchBar resignFirstResponder];
}

#pragma mark - searchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.filteredCities removeAllObjects];
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", self.searchController.searchBar.text];
    self.filteredCities = [[self.allCities filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [cityTableView reloadData];
    });
  
}

@end
