//
//  ViewController.h
//  FilltoJapanMap
//
//  Created by Eriko Ichinohe on 2014/02/20.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController<ADBannerViewDelegate,UIWebViewDelegate>
- (IBAction)BtnShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;

@property (weak, nonatomic) IBOutlet UILabel *percentage;

- (UIImage *)screenshotWithView:(UIView *)view;

@end
