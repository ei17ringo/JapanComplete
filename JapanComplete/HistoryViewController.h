//
//  HistoryViewController.h
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/03.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *HistoryTableView;

@end
