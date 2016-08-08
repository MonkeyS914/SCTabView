//
//  OVPopView.h
//  NewooEyes
//
//  Created by Sunc on 16/7/29.
//  Copyright © 2016年 jungle.wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger,OVArraowDirection) {
    OVArraowDirectionLeft1 = 1,
    OVArraowDirectionLeft2,
    OVArraowDirectionLeft3,
    OVArraowDirectionRight1,
    OVArraowDirectionRight2,
    OVArraowDirectionRight3,
    OVArraowDirectionTop1,
    OVArraowDirectionTop2,
    OVArraowDirectionTop3,
    OVArraowDirectionBottom1,
    OVArraowDirectionBottom2,
    OVArraowDirectionBottom3,
};

@interface OVPopView : UIView

@property (nonatomic, strong)UIView *backView;

- (instancetype)initWithViewSize:(CGSize)size arrowPoint:(CGPoint)point andDirection:(OVArraowDirection)direction;

- (void)popView;
- (void)disMiss;

@end
