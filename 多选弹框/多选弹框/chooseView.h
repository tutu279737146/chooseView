//
//  chooseView.h
//  多选弹框
//
//  Created by 涂世展 on 2016/11/9.
//  Copyright © 2016年 涂世展. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"


@interface chooseView : UIView

/**
 十六进制颜色转换方法,可以将宏倒入到项目的PCH文件中

 @param rgbValue 十六进制颜色
 @return 系统颜色
 */
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorAlphaFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define chooseBtnW 50
#define margin 40

/**
 可选项的数组
 */
@property (nonatomic, strong) NSArray *letterArr;

/**
 待选的按钮数组
 */
@property (nonatomic, strong) NSMutableArray *chooseBtnArr;

/**
 已经选中的按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *selectedBtnArr;

/**
 chooseView本身的高度
 */
@property (nonatomic, assign) double height;

- (instancetype)initWithFrame:(CGRect)frame andNum:(NSInteger)num;

@end
