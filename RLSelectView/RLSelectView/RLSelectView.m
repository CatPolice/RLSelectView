//
//  RLSelectView.m
//  SelectBlock
//
//  Created by runlin on 16/8/29.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "RLSelectView.h"

@implementation RLSelectView

static float button_space_horiz = 10;       //视图横向间距
static float button_space_vertical = 7;     //视图纵向间距
static float button_size_high = 27 ;        //按钮高度

NSInteger selectIndex;

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        selectIndex = -1;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selectIndex = -1;
    }
    return self;
}


- (void)awakeFromNib{
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self reloadData:YES];
}

- (void)setNeedsUpdateConstraints{
    NSLog(@"==========");
}


- (void)setContentList:(NSArray *)contentList{
    _contentList = contentList;
    [self reloadData:NO];
}


- (void)reloadData:(BOOL)layoutOver{
    
    if (layoutOver) {
        for (UIButton *ctrl in [self subviews]) {
            [ctrl removeFromSuperview];
        }
    }
    
    float view_wide = (self.frame.size.width - button_space_horiz*4) / 3;
    
    for (int i = 0; i < self.contentList.count; i++) {
        if (i < 3) {
            CGRect rect = CGRectMake(button_space_horiz + (view_wide+button_space_horiz)*i, 0, view_wide, button_size_high);
            [self creatButtonItem:rect withIndex:i];
        }else{
            CGRect rect = CGRectMake(button_space_horiz + (view_wide+button_space_horiz)*(i - 3), button_size_high + button_space_vertical, view_wide, button_size_high);
            [self creatButtonItem:rect withIndex:i];
        }
    }
}

- (void)creatButtonItem:(CGRect)rect withIndex:(NSInteger )i{
    
    //            UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(view_space + (view_wide+view_space)*i, 0, view_wide, 27)];
    //            control.backgroundColor = [UIColor redColor];
    //            UILabel *lable = [[UILabel alloc] initWithFrame:control.frame];
    //            lable.text = [self.contentList objectAtIndex:i];
    //            lable.textColor = [UIColor yellowColor];
    //
    //            [control addSubview:lable];
    //            [self addSubview:control];
    //
    //            [control addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchDown];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(rect.origin.x,rect.origin.y,rect.size.width, rect.size.height)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:[self.contentList objectAtIndex:i] forState:UIControlStateNormal];
    button.tag = i;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchDown];
    
    if (selectIndex == i) {
        button.backgroundColor = [UIColor yellowColor];
    }
    
    [self addSubview:button];
}



- (void)clickAction:(UIButton *)sender{
    selectIndex = sender.tag;
    [self reloadData:YES];
    if (_didClickViewItem) {
        _didClickViewItem([self.contentList objectAtIndex:sender.tag]);
    }
}

-(void)didClickViewCallback:(DidClickViewItem)didClickItem{
    _didClickViewItem = [didClickItem copy];
}

@end
