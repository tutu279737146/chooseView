//
//  ViewController.m
//  多选弹框
//
//  Created by 涂世展 on 2016/11/9.
//  Copyright © 2016年 涂世展. All rights reserved.
//

#import "ViewController.h"
#import "chooseView.h"

@interface ViewController ()

@property (nonatomic, strong) chooseView *chooseView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didClickBtn:(id)sender {
    
    //1.创建蒙版
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tool.barStyle = UIBarStyleBlack;
    [self.view addSubview:tool];
    
    //3.创建一个chooseView添加在上面
    CGRect rect = CGRectMake(20, self.view.bounds.size.height, self.view.bounds.size.width - 40, self.view.bounds.size.height/2);
    self.chooseView = [[chooseView alloc] initWithFrame:rect andNum:7];
    
    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.chooseView];
    [UIView animateWithDuration:0 animations:^{
        
        self.chooseView.frame = CGRectMake(20, (self.view.bounds.size.height - self.chooseView.height)/2 , self.view.bounds.size.width - 40, self.chooseView.height);
    }];
    

}


@end
