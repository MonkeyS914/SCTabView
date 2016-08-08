//
//  SCTabView.h
//  SCTabView
//
//  Created by Sunc on 16/7/21.
//  Copyright © 2016年 Sunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCTabViewDelegate <NSObject>

- (void)clickBtnAtIndex:(NSInteger)index;

@end

@interface SCTabView : UIView

- (void)moveIndicatorView:(BOOL)toLeft;
- (void)setLength:(CGFloat)length;
- (void)setSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor;
- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

@property (nonatomic, assign)id<SCTabViewDelegate>delegate;

@end
