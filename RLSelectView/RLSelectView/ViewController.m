//
//  ViewController.m
//  RLSelectView
//
//  Created by runlin on 16/8/30.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "ViewController.h"
#import "RLSelectView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet RLSelectView *selectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.selectView.lines = 1;
    self.selectView.contentList = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    
    
    [self.selectView didClickViewCallback:^(id content) {
        NSLog(@"%@",content);
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
