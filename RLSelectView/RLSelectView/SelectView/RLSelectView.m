//
//  RLSelectView.m
//  SelectBlock
//
//  Created by runlin on 16/8/29.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import "RLSelectView.h"

@interface RLSelectView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollview;
    
    UIButton *_currButton;
}

@end

@implementation RLSelectView

static float button_space_horiz = 10;       //视图横向间距
static float button_space_vertical = 7;     //视图纵向间距
static float button_size_high = 27 ;        //按钮高度

NSInteger selectIndex;

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currButton.tag = -1;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currButton.tag = -1;
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
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
    
    float view_wide = (self.frame.size.width - button_space_horiz*(self.lines + 1)) / self.lines;
    
    NSInteger count = self.contentList.count / self.lines;
    BOOL autoScroll = NO;
    if (button_space_vertical*(count + 1) + button_size_high * count > self.frame.size.height) {
        _scrollview = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollview.contentSize = CGSizeMake(self.frame.size.width, button_space_vertical*(count + 1) + button_size_high * count);
        [self addSubview:_scrollview];
        autoScroll = YES;
    }
    
    
    NSInteger index = 0;
    for (int i = 0; i < (int)self.contentList.count; i++) {
        if (i % self.lines == 0 && i > 0) {
            index ++;
        }
        
        CGRect rect = CGRectMake(button_space_horiz + (view_wide+button_space_horiz)*(i - index*self.lines), (button_size_high + button_space_vertical)*index + button_space_vertical, view_wide, button_size_high);
        
        if (autoScroll) {
            [_scrollview addSubview:[self creatButtonItem:rect withIndex:i]];
        }else{
            [self addSubview:[self creatButtonItem:rect withIndex:i]];
        }
    }
}

- (UIButton *)creatButtonItem:(CGRect)rect withIndex:(NSInteger )i{
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){rect.origin.x,rect.origin.y,rect.size.width, rect.size.height}];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:[self.contentList objectAtIndex:i] forState:UIControlStateNormal];
    button.tag = i;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchDown];

    return button;
}


- (void)clickAction:(UIButton *)sender{
    sender.backgroundColor = [UIColor yellowColor];
    if (_currButton.tag != sender.tag) {
        _currButton.backgroundColor = [UIColor redColor];
        _currButton = sender;
    }
    
    if (_didClickViewItem) {
        _didClickViewItem([self.contentList objectAtIndex:sender.tag]);
    }
}

-(void)didClickViewCallback:(DidClickViewItem)didClickItem{
    _didClickViewItem = [didClickItem copy];
}

@end
