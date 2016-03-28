//
//  UIView+Extension.m
//  demo2
//
//  Created by tarena006 on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "UIView+Extension.h"

/**
 *  界面4:头像画圆
 */

@implementation UIView (Extension)
-(void)setRoundLayerCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=radius;
    self.layer.borderWidth=width;
    self.layer.borderColor=color.CGColor;
}
-(void)setRoundWithBorderWidth:(CGFloat)width borderColor:(UIColor *)color{
    assert(self.frame.size.width==self.frame.size.height);
    [self setRoundLayerCornerRadius:self.frame.size.width/2 borderWidth:width borderColor:color];
}
@end
