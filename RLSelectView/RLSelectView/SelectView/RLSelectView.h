//
//  RLSelectView.h
//  SelectBlock
//
//  Created by runlin on 16/8/29.
//  Copyright © 2016年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DidClickViewItem)(id content);
@interface RLSelectView : UIView
{
    DidClickViewItem _didClickViewItem;
}

@property (nonatomic , assign)NSInteger lines;
@property (nonatomic , copy)NSArray *contentList;


@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UILabel *title;



-(void)didClickViewCallback:(DidClickViewItem)didClickItem;

@end
