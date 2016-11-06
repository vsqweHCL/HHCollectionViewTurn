//
//  HHCollectionTurnCell.m
//  轮播图UICollectionView
//
//  Created by HCL黄 on 16/11/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "HHCollectionTurnCell.h"

@interface HHCollectionTurnCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HHCollectionTurnCell

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
