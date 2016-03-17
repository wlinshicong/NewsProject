//
//  TableViewController.m
//  API调用
//
//  Created by tarena05 on 16/3/17.
//  Copyright © 2016年 tarena05. All rights reserved.
//

#import "TableViewController.h"
#import "requestUrl.h"
#import "TableViewCell.h"
@interface TableViewController ()
@property(nonatomic,strong)NSMutableArray *allNews;
@end

@implementation TableViewController

-(NSMutableArray *)allNews{
    if (!_allNews) {
        _allNews=[NSMutableArray array];
    }
    return _allNews;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    requestUrl *rUrl=[[requestUrl alloc]init];
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
    NSString *httpArg = @"channelId=5572a109b3cdc86cf39001db&channelName=%E5%9B%BD%E5%86%85%E6%9C%80%E6%96%B0&title=%E4%B8%8A%E5%B8%82&page=1?type=json";
    [self request: httpUrl withHttpArg: httpArg];
}
//发送请求,接收数据
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"fa5044077ec1d4d9b52d272a752d0ef5" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (data) {//请求成功
                                   
                                   if (error) {
                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   } else {
                                       NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                       NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                       NSLog(@"HttpResponseCode:%ld", responseCode);
//                                       NSLog(@"HttpResponseBody %@",responseString);
                                   //调用方法,给数组赋值
                                       [self reloadCellWithData:data];
                                       
                                       
                                   }
                                   
                               }else{
                                   NSLog(@"没有获取到数据");
                                   
                               }
                           }];
}

-(void)reloadCellWithData:data{
    
    NSDictionary *returnDict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //NSLog(@"%@",returnDict);
   //根节点
    NSDictionary *bodyDict=returnDict[@"showapi_res_body"];
  //一节子节点
    NSDictionary *dict=bodyDict[@"pagebean"];
    //二级子节点
    NSMutableArray *NewsArray=dict[@"contentlist"];
   // NSLog(@"%@",NewsArray);
    //新闻本体
    NSDictionary *newsDict=NewsArray[0];
     NSLog(@"---1%@",newsDict);
    TableViewCell *cell=[[TableViewCell alloc]init];
    cell=[cell initWithDict:newsDict];
    NSLog(@"---2%@",cell);
//    
//    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//        [self.tableView reloadData];
//        
//    }];
//    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
