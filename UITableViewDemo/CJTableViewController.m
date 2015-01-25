//
//  CJTableViewController.m
//  UITableViewDemo
//
//  Created by CoderJee on 15/1/25.
//  Copyright (c) 2015年 CoderJee. All rights reserved.
//
#import "UIView+Extension.h"
#import "CJTableViewController.h"
@interface CJTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, weak)UIImageView *imgView;
@property (nonatomic, assign)CGRect imgRect;
@property (nonatomic, assign)CGFloat previousY;
@end

@implementation CJTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"CoderJee.jpg"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -image.size.height * 0.25, 320, image.size.height * 0.25 )];
    self.imgRect = imgView.frame;
    imgView.image = image;
    self.imgView  =imgView;
    imgView.clipsToBounds = YES;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.layer.masksToBounds = YES;
    [self.tableView insertSubview:imgView atIndex:0];
    self.previousY = -imgView.size.height - 64;
    self.tableView.contentInset = UIEdgeInsetsMake(imgView.height + 64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CJ"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CJ"];
    }
    cell.textLabel.text = @"CoderJee";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 往上下滚动
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY > self.imgRect.origin.y - 64 && contentOffsetY<0) {
        if (self.imgView.height > self.imgRect.size.height) {
            self.imgView.y = - self.imgRect.size.height;
            self.imgView.height = self.imgRect.size.height;
            self.previousY = -self.imgRect.size.height - 64;
        }
        self.imgView.y += (contentOffsetY - self.previousY) * 0.5;
        self.previousY = contentOffsetY;
        return;
    }else  if(contentOffsetY <= -self.imgRect.size.height - 64){
        
        if (self.imgView.y > - self.imgRect.size.height) {
            self.imgView.y =  - self.imgRect.size.height;
            
            self.previousY = -self.imgRect.size.height - 64;
        }
        CGFloat sss = (self.previousY - contentOffsetY);
        self.imgView.y  -= sss;
        self.imgView.height +=  sss ;
        NSLog(@"%f -- %f", self.imgView.height, self.imgView.width);
        self.previousY = contentOffsetY;
    }
}
@end
