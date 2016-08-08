//
//  OVPopView.m
//  NewooEyes
//
//  Created by Sunc on 16/7/29.
//  Copyright © 2016年 jungle.wei. All rights reserved.
//

#import "OVPopView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface OVPopView ()

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) OVArraowDirection direction;

@end

@implementation OVPopView

- (instancetype)initWithViewSize:(CGSize)size arrowPoint:(CGPoint)point andDirection:(OVArraowDirection)direction{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        
        self.width = size.width;
        self.height = size.height;
        self.origin = point;
        self.direction = direction;
        
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(point.x, point.y, size.width+1, size.height+1)];
        self.backView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        self.backView.layer.cornerRadius = 5.0;
        self.backView.layer.masksToBounds = YES;
        [self addSubview:self.backView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    
    if (_direction == OVArraowDirectionLeft1 || _direction == OVArraowDirectionLeft2 ||_direction == OVArraowDirectionLeft3){
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX+6, startY-5);
        CGContextAddLineToPoint(context, startX+6, startY+5);
    }
    else if (_direction == OVArraowDirectionRight1 || _direction == OVArraowDirectionRight2 || _direction == OVArraowDirectionRight3){
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX-6, startY-5);
        CGContextAddLineToPoint(context, startX-6, startY+5);
    }
    else if (_direction == OVArraowDirectionTop1 || _direction == OVArraowDirectionTop2 || _direction == OVArraowDirectionTop3){
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX+5, startY+6);
        CGContextAddLineToPoint(context, startX-5, startY+6);
    }
    else if (_direction == OVArraowDirectionBottom1 || _direction == OVArraowDirectionBottom2 || _direction == OVArraowDirectionBottom3){
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, startX-5, startY-6);
        CGContextAddLineToPoint(context, startX+5, startY-6);
    }
    
    CGContextClosePath(context);
    [self.backView.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.backView]) {
        [self disMiss];
    }
}

- (void)popView{
    NSArray *result = [self.backView subviews];
    for (UIView *view in result) {
        view.hidden = YES;
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    self.alpha = 0.0;
    
    if (_direction == OVArraowDirectionLeft1) {
        self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y -20, self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionLeft2){
        self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y - self.height/2.0, self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionLeft3){
        self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x + 5, self.origin.y - self.height +20, self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionRight1){
        self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y - 20, -self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionRight2){
        self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y - self.height/2.0, -self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionRight3){
        self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - 5, self.origin.y - self.height +20, -self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionTop1){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y + 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - 20, self.origin.y + 5, self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionTop2){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y + 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - self.width/2.0, self.origin.y + 5, self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionTop3){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y + 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x + 20, self.origin.y + 5, -self.width, self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionBottom1){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y - 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - 20, self.origin.y - 5, self.width, -self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionBottom2){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y - 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - self.width/2.0, self.origin.y - 5, self.width, -self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
    else if (_direction == OVArraowDirectionBottom3){
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y - 5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1.0;
            self.backView.frame = CGRectMake(self.origin.x - self.width + 20, self.origin.y - 5, self.width, -self.height);
        } completion:^(BOOL finished) {
            NSArray *result = [self.backView subviews];
            for (UIView *view in result) {
                view.hidden = NO;
            }
        }];
    }
}

- (void)disMiss{
    NSArray *result = [self.backView subviews];
    for (UIView *view in result) {
        [view removeFromSuperview];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
