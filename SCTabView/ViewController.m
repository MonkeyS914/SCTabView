//
//  ViewController.m
//  SCTabView
//
//  Created by Sunc on 16/7/21.
//  Copyright © 2016年 Sunc. All rights reserved.
//

#import "ViewController.h"
#import "SCTabView.h"

@interface ViewController ()<UIScrollViewDelegate,SCTabViewDelegate>
{
    UIScrollView *SCScrollView;
    UIView *leftView;
    UIView *rightView;
    SCTabView *tabBarView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    SCScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [SCScrollView setContentSize:CGSizeMake(self.view.frame.size.width*2, self.view.frame.size.height)];
    SCScrollView.delegate = self;
    SCScrollView.pagingEnabled = YES;
    [self.view addSubview:SCScrollView];
    
    leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor greenColor];
    [SCScrollView addSubview:leftView];
    
    rightView = [[UIView alloc]initWithFrame:self.view.bounds];
    rightView.center = CGPointMake(self.view.frame.size.width*3/2.0, self.view.frame.size.height/2.0);
    rightView.backgroundColor = [UIColor yellowColor];
    [SCScrollView addSubview:rightView];
    
    tabBarView = [[SCTabView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-120)/2.0, 30, 120, 30)];
    tabBarView.delegate = self;
    [tabBarView setSelectedColor:[UIColor redColor] unSelectedColor:[UIColor whiteColor]];
    [tabBarView setLeftTitle:@"下载中" rightTitle:@"已下载"];
    
    [self.view addSubview:tabBarView];
}

#pragma mark UIScorllViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x <= self.view.frame.size.width) {
        return;
    }
    if (scrollView.contentOffset.x == 0) {
        [self clickBtnAtIndex:0];
        //        [tabBarView moveIndicatorView:YES];
    }
    else if(scrollView.contentOffset.x == self.view.frame.size.width){
        [self clickBtnAtIndex:1];
        //        [tabBarView moveIndicatorView:NO];
    }
}

- (void)clickBtnAtIndex:(NSInteger)index{
    if (index == 0) {
        //下载中
        [SCScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (index ==1){
        //已下载
        [SCScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];

    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == SCScrollView) {
        CGFloat lengthPercent = scrollView.contentOffset.x/(CGFloat)self.view.frame.size.width;
        CGFloat length = 60 *lengthPercent;
        [tabBarView setLength:length];
        if (scrollView.contentOffset.x == self.view.frame.size.width) {
            //do something
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
