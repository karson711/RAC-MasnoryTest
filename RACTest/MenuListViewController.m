//
//  MenuListViewController.m
//  RACTest
//
//  Created by anfa on 2019/4/9.
//  Copyright © 2019 anfa. All rights reserved.
//

#import "MenuListViewController.h"
#import "RACHomeViewController.h"
#import "RACMapViewController.h"
#import "RACFilterViewController.h"
#import "RACRACSubjectVC.h"
#import "RACRACMulticastConnectionVC.h"
#import "RACRACCommandVC.h"

@interface MenuListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *menuArr;

@end

@implementation MenuListViewController

-(NSMutableArray *)menuArr{
    if (!_menuArr) {
        _menuArr = [NSMutableArray arrayWithArray:@[@"基本控件使用",@"映射",@"信号过滤",@"RACSubject",@"RACMulticastConnection",@"RACCommand",@"TestDemo"]];
    }
    return _menuArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"RAC练习目录";
}

#pragma mark - UITableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.menuArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        //基础控件使用
        [self.navigationController pushViewController:[RACHomeViewController new] animated:YES];
    }else if (indexPath.row == 1){
        //映射
        [self.navigationController pushViewController:[RACMapViewController new] animated:YES];
    }else if (indexPath.row == 2){
        //信号过滤
        [self.navigationController pushViewController:[RACFilterViewController new] animated:YES];
    }else if (indexPath.row == 3){
        //RACSubject
        [self.navigationController pushViewController:[RACRACSubjectVC new] animated:YES];
    }else if (indexPath.row == 4){
        //RACMulticastConnection
        [self.navigationController pushViewController:[RACRACMulticastConnectionVC new] animated:YES];
    }else if (indexPath.row == 5){
        //RACCommand
        [self.navigationController pushViewController:[RACRACCommandVC new] animated:YES];
    }
}

@end
