//
//  TutorialViewController.m
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/03.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController (){
    ADBannerView *adView;
    
    // 表示の切り替え用
    BOOL viewIsVisible;
}

@end

@implementation TutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //チュートリアル表示
    [self viewTutorial];
    
    //広告を表示
    [self viewiAd];
}

// チュートリアル表示
-(void)viewTutorial{
    self.TutorialTextView.layer.borderWidth = 1;
    self.TutorialTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.TutorialTextView.layer.cornerRadius = 10;
    self.TutorialTextView.font = [UIFont fontWithName:@"小塚ゴシック Pro" size:24];
}

// 広告表示
-(void)viewiAd{
    adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, -adView.frame.size.height, adView.frame.size.width, adView.frame.size.height)];
    adView.delegate = self;
    
    adView.autoresizesSubviews = YES;
    // | はShift + 円マーク
    //横向きと下の幅に対応
    adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:adView];
    adView.alpha = 0.0;
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    if (!viewIsVisible){
        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
        banner.alpha = 1.0;
        [UIView commitAnimations];
        viewIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    if (viewIsVisible){
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, -CGRectGetHeight(banner.frame));
        banner.alpha = 1.0;
        [UIView commitAnimations];
        viewIsVisible = NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//マップページヘ移動
- (IBAction)gotoMap:(id)sender {
    UITabBarController *controller = self.tabBarController;
    controller.selectedViewController = [controller.viewControllers objectAtIndex: 0];
}
@end
