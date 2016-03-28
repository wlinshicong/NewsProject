//
//  UIView+Extension.h
//  demo2
//
//  Created by tarena006 on 16/2/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
-(void)setRoundLayerCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;
-(void)setRoundWithBorderWidth:(CGFloat)width borderColor:(UIColor*)color;
@end
