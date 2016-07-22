//
//  SCTabView.m
//  SCTabView
//
//  Created by Sunc on 16/7/21.
//  Copyright © 2016年 Sunc. All rights reserved.
//

#import "SCTabView.h"

@implementation SCTabView{
    UIButton *leftBtn;
    UIButton *rightBtn;
    UIButton *leftLabel;
    UIButton *rightLabel;
    CGFloat halfWith;
    CGFloat height;
    UIView *indicatorView;
    BOOL isClickAction;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTabView:frame];
    }
    return self;
}

- (void)setSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor{
    [leftLabel setTitleColor:unSelectedColor forState:UIControlStateNormal];
    [rightLabel setTitleColor:unSelectedColor forState:UIControlStateNormal];
    indicatorView.backgroundColor = selectedColor;
    [leftBtn setTitleColor:selectedColor forState:UIControlStateSelected];
    [leftBtn setTitleColor:selectedColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:selectedColor forState:UIControlStateSelected];
    [rightBtn setTitleColor:selectedColor forState:UIControlStateNormal];
}

- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    [leftLabel setTitle:leftTitle forState:UIControlStateNormal];
    [rightLabel setTitle:rightTitle forState:UIControlStateNormal];
    [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)addTabView:(CGRect)frame{
    halfWith = frame.size.width/2.0;
    height = frame.size.height;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor magentaColor].CGColor;
    self.backgroundColor = [UIColor whiteColor];
    
    leftLabel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, halfWith, height)];
    leftLabel.backgroundColor = [UIColor clearColor];
    
    rightLabel = [[UIButton alloc]initWithFrame:CGRectMake(halfWith, 0, halfWith, height)];
    rightLabel.backgroundColor = [UIColor clearColor];
    
    indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, halfWith, height)];
    UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft
                              
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
    leftLayer.frame = indicatorView.bounds;
    leftLayer.path = leftPtah.CGPath;
    indicatorView.layer.mask = leftLayer;
    indicatorView.clipsToBounds = YES;
    [indicatorView addSubview:leftLabel];
    [indicatorView addSubview:rightLabel];
    
    leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, halfWith, height)];
    leftPtah = [UIBezierPath bezierPathWithRoundedRect:leftBtn.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft cornerRadii:CGSizeMake(5.0, 5.0)];
    leftLayer = [[CAShapeLayer alloc]init];
    leftLayer.frame = leftBtn.bounds;
    leftLayer.path = leftPtah.CGPath;
    leftBtn.layer.mask = leftLayer;
    [leftBtn addTarget:self action:@selector(indicatorBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.selected = YES;
    [self addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(halfWith, 0, halfWith, height)];
    leftPtah = [UIBezierPath bezierPathWithRoundedRect:rightBtn.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
    leftLayer = [[CAShapeLayer alloc]init];
    leftLayer.frame = rightBtn.bounds;
    leftLayer.path = leftPtah.CGPath;
    rightBtn.layer.mask = leftLayer;
    [rightBtn addTarget:self action:@selector(indicatorBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.selected = NO;
    [self addSubview:rightBtn];
    
    [self addSubview:indicatorView];
}

- (void)setLength:(CGFloat)length{
    if (isClickAction) {
        return;
    }
    UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
    leftLayer.frame = indicatorView.bounds;
    leftLayer.path = leftPtah.CGPath;
    indicatorView.layer.mask = leftLayer;
    indicatorView.frame = CGRectMake(length, 0, 60, 30);
    leftLabel.frame = CGRectMake(-length, 0, 60, 30);
    rightLabel.frame = CGRectMake(60-length, 0, 60, 30);
}

- (void)indicatorBtnClicked:(UIButton *)sender{
    isClickAction = YES;
    if (sender == leftBtn) {
        if (!leftBtn.selected) {
            [self moveIndicatorView:YES];
            //            [downloadScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            if ([_delegate respondsToSelector:@selector(clickBtnAtIndex:)]) {
                [_delegate clickBtnAtIndex:0];
            }
        }
    }
    else{
        if (!rightBtn.selected) {
            [self moveIndicatorView:NO];
            //            [downloadScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
            if ([_delegate respondsToSelector:@selector(clickBtnAtIndex:)]) {
                [_delegate clickBtnAtIndex:1];
            }
        }
    }
}

- (void)moveIndicatorView:(BOOL)toLeft{
    if (toLeft) {
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.frame = CGRectMake(0, 0, halfWith, height);
            leftLabel.frame = CGRectMake(0, 0, halfWith, height);
            rightLabel.frame = CGRectMake(halfWith, 0, halfWith, height);
            UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
            leftLayer.frame = indicatorView.bounds;
            leftLayer.path = leftPtah.CGPath;
            indicatorView.layer.mask = leftLayer;
        } completion:^(BOOL finished) {
            leftBtn.selected = YES;
            rightBtn.selected = NO;
            UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
            leftLayer.frame = indicatorView.bounds;
            leftLayer.path = leftPtah.CGPath;
            indicatorView.layer.mask = leftLayer;
            isClickAction = NO;
        }];
        
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            indicatorView.frame = CGRectMake(halfWith, 0, halfWith, height);
            leftLabel.frame = CGRectMake(-halfWith, 0, halfWith, height);
            rightLabel.frame = CGRectMake(0, 0, halfWith, height);
            UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
            leftLayer.frame = indicatorView.bounds;
            leftLayer.path = leftPtah.CGPath;
            indicatorView.layer.mask = leftLayer;
        } completion:^(BOOL finished) {
            rightBtn.selected = YES;
            leftBtn.selected = NO;
            UIBezierPath *leftPtah = [UIBezierPath bezierPathWithRoundedRect:indicatorView.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *leftLayer = [[CAShapeLayer alloc]init];
            leftLayer.frame = indicatorView.bounds;
            leftLayer.path = leftPtah.CGPath;
            indicatorView.layer.mask = leftLayer;
            isClickAction = NO;
        }];
    }
}


@end
