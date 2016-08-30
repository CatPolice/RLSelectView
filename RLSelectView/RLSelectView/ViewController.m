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
    
    
    //    RLSelectView *view = [[RLSelectView alloc] initWithFrame:CGRectMake(0, 100, 320, 100)];
    //    view.contentList = @[@"1",@"2",@"3"];
    //
    //
    //    [self.view addSubview:view];
    
    
    self.selectView.contentList = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    [self.selectView didClickViewCallback:^(id content) {
        NSLog(@"%@",content);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
