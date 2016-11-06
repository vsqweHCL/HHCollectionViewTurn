//
//  ViewController.m
//  轮播图UICollectionView
//
//  Created by HCL黄 on 16/11/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "ViewController.h"
#import "HHCollectionViewTurn.h"

@interface ViewController ()

/** 数据 */
@property (nonatomic, strong) NSArray *datas;
@end

@implementation ViewController
/** 懒加载 */
- (NSArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HHCollectionViewTurn *turn = [[HHCollectionViewTurn alloc] init];
    turn.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 200);
    turn.backgroundColor = [UIColor blueColor];
    turn.datas = self.datas;
    [self.view addSubview:turn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
