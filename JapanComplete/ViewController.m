//
//  ViewController.m
//  FilltoJapanMap
//
//  Created by Eriko Ichinohe on 2014/02/20.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "ViewController.h"
#import "TutorialViewController.h"

@interface ViewController (){
    ADBannerView *adView;

    // 表示の切り替え用
    BOOL viewIsVisible;
    BOOL firstFlag;
    NSDictionary *colorArea;
    NSDictionary *historyData;
    int _countColored; //色がついているエリアの数
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        //Map表示
        [self viewMap];
        
        //広告を表示
        [self viewiAd];
    
    
}

//画面が表示された後に、インストール後初期表示の場合はチュートリアルに移動する
- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *dStr =[defaults stringForKey:@"firstFlag"];
    
    if (dStr == nil) {
        firstFlag = NO;
    }else{
        firstFlag = dStr.boolValue;
    }
    
    NSLog(@"%d",firstFlag);

    if (!firstFlag){
        self.tabBarController.selectedIndex = 2;

        [defaults setObject:@"YES" forKey:@"firstFlag"];
        
        //初期状態の都道府県ディクショナリーをセット
        colorArea = [self setAreaDictionary:@"-1" areaID:nil];
        
        [defaults setObject:colorArea forKey:@"colorArea"];
        
        [defaults synchronize];
    }
}

-(void)webViewDidFinishLoad:(UIWebView*)webView{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    colorArea = [defaults dictionaryForKey:@"colorArea"];
    historyData = [defaults dictionaryForKey:@"historyData"];
    
    NSLog(@"load=%@",colorArea);
    
    NSArray *keys = [colorArea allKeys];
    
    for(int i=0; i<[keys count]; i++){
        NSString *strKey = [keys objectAtIndex:i];
        NSString *strValue = [colorArea objectForKey:[keys objectAtIndex:i]];
        NSLog(@"key:%@ value:%@\n",
              strKey,
              strValue);
        NSString *command =[NSString stringWithFormat:@"setcolor('%@','%@')",strValue,strKey];
        [self.mapWebView stringByEvaluatingJavaScriptFromString:command];
        
    }

    [self calcPercentage];
    
   
    
}

//パーセンテージを計算する
-(void)calcPercentage{
    
    NSArray *keys = [colorArea allKeys];
    _countColored = 0;

    for(int i=0; i<[keys count]; i++){
        NSString *strValue = [colorArea objectForKey:[keys objectAtIndex:i]];
        if ([strValue intValue] > 0){
            _countColored++;
        }
    }
    
    float percentage = _countColored / 47.00 * 100.00;
    
    self.percentage.text = [NSString stringWithFormat:@"%.2f%%",percentage];

}
//シェアボタン
- (IBAction)BtnShare:(id)sender {
    NSString *text;
    NSString *powered;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSURL *url;
    
    text = [NSString stringWithFormat:@"%@Complete in Japan now!\n",self.percentage.text];
    powered = @"Powered by Japan Complete.";
    
    url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/japancomplete/id842436484?mt=8"];
    
    //現在作成した地図のスクリーンショットを作成
    UIImage *mapPic = [self screenshotWithView:self.mapWebView];
    
    // PNGの場合（view.alphaで指定した透明度も維持されるみたい）
    NSData *dataSaveImage = UIImagePNGRepresentation(mapPic);
    
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSString *strNow = [df stringFromDate:now];
    
    NSDateFormatter *dfkey = [[NSDateFormatter alloc] init];
	[dfkey setDateFormat:@"yyyy/MM/dd_HH:mm:ss"];
    NSString *strNowKey = [dfkey stringFromDate:now];
    
    NSString *FileName = [NSString stringWithFormat:@"%@.png",strNow];
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
    
    [dataSaveImage writeToFile:[path stringByAppendingPathComponent:FileName] atomically:YES];
    
    NSMutableDictionary *ret_dictionary = [[NSMutableDictionary alloc] initWithDictionary:historyData];
    
    //現在時刻をキーに指定し、Historyデータに保存
    
    [ret_dictionary setObject:FileName forKey:strNowKey];
    
    historyData = ret_dictionary;
    
    [defaults setObject:historyData forKey:@"historyData"];
    [defaults synchronize];
    
    //シェア用文章,URL,画像（モダンな書き方）
    //NSArray *actItems = @[text,powered,url,mapPic];
    NSArray *actItems = @[text,mapPic];
    
    UIActivityViewController
    *activityView = [[UIActivityViewController alloc] initWithActivityItems:actItems applicationActivities:nil];
    
    //モーダルの処理
    [self presentViewController:activityView animated:YES completion:nil];
    
}





- (UIImage *)screenshotWithView:(UIView *)view
{
    CGSize imageSize = [self.mapWebView bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, [view center].x, [view center].y);
    CGContextConcatCTM(context, [view transform]);
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x - view.frame.origin.x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y - view.frame.origin.y);
    
    [[view layer] renderInContext:context];
    
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

// 地図表示
-(void)viewMap{
    self.mapWebView.scalesPageToFit = YES;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"event" ofType:@"js"];
    
    
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    [self.mapWebView stringByEvaluatingJavaScriptFromString:script];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"html"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.mapWebView loadRequest:request];
    
    self.mapWebView.delegate = self;
}

//javascriptから値を受け取りUserDefaultに設定する
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"webview"]) {
        NSLog(@"%@:",[URL query]);
        NSString *ColorCode = [[URL query] substringWithRange:NSMakeRange(6, 1)];
        NSLog(@"%@:",ColorCode);
        
        NSString *str = [URL query];
        
        NSString *AreaID = [str substringWithRange:NSMakeRange(11, str.length-11)];
        NSLog(@"%@",AreaID);


        colorArea = [self setAreaDictionary:ColorCode areaID:AreaID];
        
        [self calcPercentage];
    }
    return YES;
}

//area色ディクショナリ−設定
-(NSDictionary *)setAreaDictionary:(NSString *)colorcode areaID:(NSString *)_areaID{

    
    if ([colorcode isEqualToString:@"-1"]){
        colorArea = [NSDictionary dictionaryWithObjectsAndKeys:
         @"0",@"Hokkaido",
         @"0",@"Aomori",
         @"0",@"Akita",
         @"0",@"Iwate",
         @"0",@"Yamagata",
         @"0",@"Miyagi",
         @"0",@"Fukushima",
         @"0",@"Ibaraki",
         @"0",@"Chiba",
         @"0",@"Tochigi",
         @"0",@"Gunma",
         @"0",@"Saitama",
         @"0",@"Tokyo",
         @"0",@"Kanagawa",
         @"0",@"Niigata",
         @"0",@"Nagano",
         @"0",@"Yamanashi",
                     @"0",@"Shizuoka",
                     @"0",@"Toyama",
                     @"0",@"Gifu",
                     @"0",@"Ishikawa",
                     @"0",@"Aichi",
                     @"0",@"Fukui",
                     @"0",@"Shiga",
                     @"0",@"Mie",
                     @"0",@"Kyoto",
                     @"0",@"Nara",
                     @"0",@"Wakayama",
                     @"0",@"Osaka",
                     @"0",@"Hyogo",
                     @"0",@"Tottori",
                     @"0",@"Okayama",
                     @"0",@"Shimane",
                     @"0",@"Hiroshima",
                     @"0",@"Yamaguchi",
                     @"0",@"Kagawa",
                     @"0",@"Tokushima",
                     @"0",@"Ehime",
                     @"0",@"Kohchi",
                     @"0",@"Ohita",
                     @"0",@"Fukuoka",
                     @"0",@"Saga",
                     @"0",@"Nagasaki",
                     @"0",@"Miyazaki",
                     @"0",@"Kumamoto",
                     @"0",@"Kagoshima",
                     @"0",@"Okinawa",
         nil];

    }else{
        NSMutableDictionary *ret_dictionary = [[NSMutableDictionary alloc] initWithDictionary:colorArea];
        
        NSLog(@"%@",ret_dictionary);
        
        [ret_dictionary setObject:colorcode forKey:_areaID];
        
        colorArea = ret_dictionary;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:colorArea forKey:@"colorArea"];
        [defaults synchronize];

    }

    NSLog(@"%@",colorArea);
    return colorArea;
    
}

//画像保存完了時のセレクタ
- (void)onCompleteCapture:(UIImage *)screenImage
 didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{}

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
        
        banner.frame = CGRectMake(0,20,adView.frame.size.width, adView.frame.size.height);
        banner.alpha = 1.0;
        [UIView commitAnimations];
        viewIsVisible = YES;
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    if (viewIsVisible){
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectMake(0,-adView.frame.size.height,adView.frame.size.width, adView.frame.size.height);
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
@end
