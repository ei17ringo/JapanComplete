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
    NSMutableArray *historyData;
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
    
    NSDictionary *tmp =[defaults dictionaryForKey:@"historyData"];
    
    //ソート機能が使えるように整形
    NSArray *keys = [tmp allKeys];
    
    historyData = [NSMutableArray new];
    for (NSString *strKey in keys) {
        NSDictionary *each = @{@"created":strKey,@"imageName":[tmp objectForKey:strKey]};
        
        [historyData addObject:each];
    }
    
    
    NSSortDescriptor *sortDescNumber=[[NSSortDescriptor alloc]initWithKey:@"created" ascending:NO];
    
    NSArray *sortDescArray = [NSArray arrayWithObjects:sortDescNumber,nil];
    
    historyData =[[historyData sortedArrayUsingDescriptors:sortDescArray] mutableCopy];
    
    [self.HistoryTableView reloadData];


}

- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.HistoryTableView.dataSource = self;
    self.HistoryTableView.delegate = self;

    [[self navigationItem] setTitle:@"History"];

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
//    NSArray *keys = [historyData allKeys];
//    NSString *strKey = [keys objectAtIndex:indexPath.row];
//    NSString *imgname = [historyData objectForKey:[keys objectAtIndex:indexPath.row]];
    NSDictionary *eachData = [historyData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",eachData[@"created"]];
    
    NSString *FileName = eachData[@"imageName"];
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
    
//    NSArray *keys = [historyData allKeys];
//    NSString *strKey = [keys objectAtIndex:selectindex];
//    NSString *imgname = [historyData objectForKey:[keys objectAtIndex:selectindex]];
    NSDictionary *eachData = [historyData objectAtIndex:selectindex];
    
    hivc.historyKey = eachData[@"created"];
    hivc.historyImageName = eachData[@"imageName"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
