//
//  HistoryImageViewController.m
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/17.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "HistoryImageViewController.h"
#import "HistoryViewController.h"

@interface HistoryImageViewController (){
    NSDictionary *historyData;
}


@end

@implementation HistoryImageViewController

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
    self.HistoryLabel.text = self.historyKey;
    
    NSString *FileName = self.historyImageName;
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //URL作成
    //NSURL *url = [NSURL URLWithString:[path stringByAppendingPathComponent:FileName]];
    
    NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,FileName];
    
    //データの読み込み
    NSData *data = [NSData dataWithContentsOfFile:FullPath];
    //画像の作成
    UIImage *image = [[UIImage alloc] initWithData:data];
    self.HistoryImage.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapBtnDel:(id)sender {
    
    //削除しますか？アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"履歴を削除" message:@"こちらの履歴を削除してもよろしいですか？" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [alert show];

}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //NSLog(@"%d",buttonIndex);
    
    if (buttonIndex == 0){
        //キャンセル
    }else{
        //OK
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        historyData =[defaults dictionaryForKey:@"historyData"];
        
        NSMutableDictionary *ret_dictionary = [[NSMutableDictionary alloc] initWithDictionary:historyData];
        
        //データを削除
        [ret_dictionary removeObjectForKey:self.historyKey];
        
        historyData = ret_dictionary;
        
        [defaults setObject:historyData forKey:@"historyData"];
        [defaults synchronize];
        
        //画像ファイルを削除
        // ファイルマネージャを作成
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // 削除したいファイルのパスを作成
        NSString *FileName = self.historyImageName;
        // Documentsディレクトリに保存
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,FileName];
        

        NSError *error;
        
        // ファイルを移動
        BOOL result = [fileManager removeItemAtPath:FullPath error:&error];
        if (result) {
            NSLog(@"ファイルを削除に成功：%@", FullPath);
        } else {
            NSLog(@"ファイルの削除に失敗：%@", error.description);
        }
        
        HistoryViewController *hvc = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
        
        //前の画面に戻る
        [self.navigationController pushViewController:hvc animated:YES];
        
    }
}
@end
