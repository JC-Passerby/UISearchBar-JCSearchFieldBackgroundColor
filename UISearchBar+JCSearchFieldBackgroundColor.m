//
//  UISearchBar+JCSearchFieldBackgroundColor.m
//  iSmartLBS
//
//  Created by 嘘。 on 2019/6/27.
//  Copyright © 2019 SmartLBS. All rights reserved.
//

#import "UISearchBar+JCSearchFieldBackgroundColor.h"

@implementation UISearchBar (JCSearchFieldBackgroundColor)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        Method systemMethod = class_getInstanceMethod(selfClass, @selector(setPlaceholder:));
        Method customizeMethod = class_getInstanceMethod(selfClass, @selector(jc_setPlaceholder:));
        method_exchangeImplementations(systemMethod, customizeMethod);
    });
}

-(void)jc_setPlaceholder:(NSString *)placeholder{
    [self setBackgroundImage:[self createImageWithColor:kUIColorFromRGB(0XF0F0F0) withWidth:self.frame.size.width withHeight:self.frame.size.height]];
    [self setSearchFieldBackgroundImage:[self makeRoundedImage:[self createImageWithColor:[UIColor whiteColor] withWidth:self.frame.size.width withHeight:self.frame.size.height - 16] radius:5]  forState:UIControlStateNormal];
    [self jc_setPlaceholder:placeholder];
}

-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundedImage;
}

-(UIImage*) createImageWithColor:(UIColor*) color
                       withWidth:(CGFloat)width
                      withHeight:(CGFloat)height{
    CGRect rect=CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
