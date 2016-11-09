//
//  chooseView.m
//  多选弹框
//
//  Created by 涂世展 on 2016/11/9.
//  Copyright © 2016年 涂世展. All rights reserved.
//

#import "chooseView.h"

@implementation chooseView


/**
 重写init方法,传入所需的数量,来动态创建chooseView

 @param frame frame
 @param num 可选项的数量
 @return 动态的chooseView
 */
- (instancetype)initWithFrame:(CGRect)frame andNum:(NSInteger)num{
    
    if (self = [super initWithFrame:frame]) {
        
        //1.按照九宫格创建,数据可以根据自己需求更改宏值
        //1.1按钮的宽和高
        CGFloat chooseBtnWidth = chooseBtnW;
        CGFloat chooseBtnHeight = chooseBtnW;
        //1.2按钮之间的间距
        CGFloat btnMargin = margin;
        //1.3选项的数据,这里写的是死的,可以而根据自己的需求更改
        self.letterArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"];
        //1.4储存选中的按钮的数组
        self.selectedBtnArr = [NSMutableArray array];
        //1.5根据num的数量来动态创建按钮的数量,由于demo没有数据,这里自定义赋值
        num = 7;
        
        //2.创建控件
        //2.1 创建标题label
        UILabel  *lbl = [[UILabel alloc] init];
        lbl.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        lbl.textColor = UIColorFromRGB(0X222222);
        lbl.text = @"选角色(可多选)";
        lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbl];
        
        __weak typeof (self) weakSelf = self;
        
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(18);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(18);
        }];

        //2.2 创建选择完毕后的按钮
        //创建角色扮演的点击按钮
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.backgroundColor = UIColorFromRGB(0xffffff);
        doneBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        [doneBtn setTitle:@"进入角色扮演" forState:UIControlStateNormal];
        doneBtn.backgroundColor = UIColorFromRGB(0x6cccd7);
        [self addSubview:doneBtn];
        [doneBtn addTarget:self action:@selector(didClickDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-18);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(41);
            
        }];
        
        
        //2.3 创建右上角关闭的按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(10);
            make.right.equalTo(weakSelf.mas_right).offset(-10);
            make.width.height.mas_equalTo(15);
            
        }];

        //2.4 九宫格创建可选项的按钮
        //列数 和顶部间距
        NSInteger columnCount = 3;
        CGFloat topMargin = 60;
        //2.4.1  计算左边边距 =  (控制器view的宽  - (选项按钮的宽 * 列数) - (列数 - 1) * 间距) * 0.5
        CGFloat leftMargin = (self.bounds.size.width - (chooseBtnWidth * columnCount) - (columnCount - 1) * btnMargin) * 0.5;
        //2.4.2 根据个数动态创建chooseBtn
        for (NSInteger i = 0; i < num; i++) {
            
            // 1.一个chooseBtn
            UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            // 2. 计算列号
            NSInteger col = i % columnCount;
            // 2.1计算chooseBtnX   chooseBtnX  = 左边边距  + (格子的宽  + 格子之间的间距) * 列号
            CGFloat chooseBtnX = leftMargin + (chooseBtnWidth + btnMargin) * col;
            
            //  3.计算行号
            NSInteger row = i / columnCount;
            // 3.1 计算chooseBtnY   chooseBtnY = 顶部边距 + (格子的高  + 格子之间的间距) * 行号
            CGFloat chooseBtnY = topMargin + (chooseBtnHeight + btnMargin) * row;
            // 4.设置frame
            chooseBtn.frame = CGRectMake(chooseBtnX, chooseBtnY, chooseBtnWidth, chooseBtnHeight);
            
            [chooseBtn.layer setMasksToBounds:YES];
            [chooseBtn.layer setCornerRadius:chooseBtnWidth / 2];
            
            [chooseBtn setBackgroundImage:[self imageWithColor:UIColorFromRGB(0Xffc19c)] forState:UIControlStateNormal];
            [chooseBtn setBackgroundImage:[self imageWithColor:UIColorFromRGB(0xFFFFFF)] forState:UIControlStateSelected];
            chooseBtn.layer.borderColor = UIColorFromRGB(0Xffc19c).CGColor;
            chooseBtn.layer.borderWidth = 1.0f;
            [chooseBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:33.0]];
            [chooseBtn setTitleColor:UIColorFromRGB(0Xffc19c) forState:UIControlStateSelected];
            [chooseBtn setTitle:self.letterArr[i] forState:UIControlStateNormal];
            
            [chooseBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [chooseBtn setTag:i];
            
            [self.chooseBtnArr addObject:chooseBtn];
            
            [self addSubview:chooseBtn];
            
            
            //2.4.3 根据数量动态创建chooseView的高度
            self.height = ((num-1) / columnCount + 1) * chooseBtnHeight + ((num - 1) / columnCount + 1) * margin + topMargin + chooseBtnHeight;
        }
    }
    return self;
}

#pragma mark 按钮的点击方法

/**
 可选项按钮的点击事件

 @param btn 选中按钮
 */
- (void)didClickBtn:(UIButton *)btn{
    
    //单选
    //    self.selectedBtn.selected = NO;
    //
    //    btn.selected = YES;
    //
    //    self.selectedBtn = btn;
    
    //多选
    btn.selected = !btn.selected;
    
}

/**
 关闭按钮

 @param btn 关闭
 */
- (void)close:(UIButton *)btn{
    
    [self removeFromSuperview];
    
    
}

/**
 选择完毕后点击的按钮

 @param btn 确定按钮
 */
- (void)didClickDoneBtn:(UIButton *)btn{
    
    //遍历根据数据创建的可选项的按钮,找出被选中的按钮
    for (UIButton *btn1 in self.chooseBtnArr) {
        
        if (btn1.selected == YES) {
            
            
            [self.selectedBtnArr addObject:self.letterArr[btn1.tag]];
            
            //在这里可以根据需求将所需要的数据传递出去
        }
        
    }
}
/**
 图片转颜色

 @param color UIColor
 @return 将颜色作为图片赋值
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
