//
//  HistoryImageViewController.h
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/17.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *HistoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HistoryImage;

@property(nonatomic,assign) NSString *historyKey;
@property(nonatomic,assign) NSString *historyImageName;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;
- (IBAction)tapBtnDel:(id)sender;

@end
