//
//  TutorialViewController.h
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/03.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface TutorialViewController : UIViewController<ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *TutorialTextView;
- (IBAction)gotoMap:(id)sender;

@end
