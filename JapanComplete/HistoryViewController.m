//
//  HistoryViewController.m
//  JapanComplete
//
//  Created by Eriko Ichinohe on 2014/03/03.
//  Copyright (c) 2014年 Eriko Ichinohe. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryImageViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController{
    NSDictionary *historyData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated  {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    historyData =[defaults dictionaryForKey:@"historyData"];
    
    [self.HistoryTableView reloadData];


}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.HistoryTableView.dataSource = self;
    self.HistoryTableView.delegate = self;

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return historyData.count;
}

//行のデータを作成
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    //セルの再利用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //行に配列の文字列を表示
    NSArray *keys = [historyData allKeys];
    NSString *strKey = [keys objectAtIndex:indexPath.row];
    NSString *imgname = [historyData objectForKey:[keys objectAtIndex:indexPath.row]];
        
    cell.textLabel.text = [NSString stringWithFormat:@"%@",strKey];
    
    NSString *FileName = imgname;
    // Documentsディレクトリに保存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //URL作成
    //NSURL *url = [NSURL URLWithString:[path stringByAppendingPathComponent:FileName]];
    
    NSString *FullPath = [NSString stringWithFormat:@"%@/%@",path,FileName];
    
    //データの読み込み
    NSData *data = [NSData dataWithContentsOfFile:FullPath];
    //画像の作成
    UIImage *image = [[UIImage alloc] initWithData:data];
    //画像表示
    cell.imageView.image = image;
    //cell.imageView.image = [UIImage imageNamed:FileName];
    //cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    HistoryImageViewController *hivc = [segue destinationViewController];
    
    NSInteger selectindex = self.HistoryTableView.indexPathForSelectedRow.row;
    
    NSArray *keys = [historyData allKeys];
    NSString *strKey = [keys objectAtIndex:selectindex];
    NSString *imgname = [historyData objectForKey:[keys objectAtIndex:selectindex]];
    
    hivc.historyKey = strKey;
    hivc.historyImageName = imgname;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
