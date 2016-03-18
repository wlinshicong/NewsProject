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
#import "webViewController.h"
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
    
//    NSDictionary *dict1=[NSDictionary dictionaryWithObject:@"ada" forKey:@"channelName"];
//    TableViewCell *cell=[[TableViewCell alloc]initWithDict:dict1];
//   
//    NSLog(@"3%@",cell.channelName);
    
    
    //requestUrl *rUrl=[[requestUrl alloc]init];
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
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                  // NSLog(@"HttpResponseCode:%ld", responseCode);
                                   //NSLog(@"HttpResponseBody %@",responseString);
                                  [self reloadCellWithData:data];
                                   [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                     
                                       [self.tableView reloadData];
                                       
                                   }];
                               }
                           }];
}

-(void)reloadCellWithData:data{
    
    
//    int a=2;
//    NSNumber *a1=[NSNumber numberWithInt:a];
//    [self.allNews addObject:a1];
//    
    
    
//    
    
    NSDictionary *returnDict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
   // NSLog(@"---%@",returnDict);
   //根节点
    NSDictionary *bodyDict=returnDict[@"showapi_res_body"];
  //一节子节点
    NSDictionary *dict=bodyDict[@"pagebean"];
    //二级子节点
    NSMutableArray *NewsArray=dict[@"contentlist"];
   // NSLog(@"%@",NewsArray);
    //新闻本体
    //NSDictionary *newsDict=NewsArray[0];
   
    //创建一个数组接收所有新闻表格数据
    //再赋值给allNews数组
    NSMutableArray *arr=[NSMutableArray array];
    for(NSDictionary *newsDict in NewsArray){
        
        TableViewCell *cell=[[TableViewCell alloc]init];
        cell=[cell initWithDict:newsDict];
        [arr addObject:cell];
    }
    self.allNews=arr;
  
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //    self.window.backgroundColor = [UIColor whiteColor];
    webViewController *web = [[webViewController alloc]init];
    //    self.window.rootViewController = web;
    NSLog(@"%d",indexPath.row);
    NSLog(@"%@",self.allNews[indexPath.row]);
    TableViewCell *cell=self.allNews[indexPath.row];
    
      NSLog(@"%@",cell.link);
    web.newsUrl=[NSURL URLWithString:cell.link];
    [self presentViewController:web animated:YES completion:nil];
     NSLog(@"---%@", web.newsUrl);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allNews.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    TableViewCell *tcell=self.allNews[indexPath.row];
    NSArray *arr=tcell.imageurls;
    NSLog(@"%lu",arr.count);
    if (arr.count>0) {
        NSDictionary *dict=arr[0];
         NSString *url=dict[@"url"];
         NSLog(@"---%@",url);
        NSURLSession *session=[NSURLSession sharedSession];
        //NSURLRequest *ruquest=[NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                UIImage *image=[UIImage imageWithData:data];

                [self.tableView reloadData];
                
            }];
            
         
        }];
        
    }


  
    cell.textLabel.text=tcell.title;
        cell.detailTextLabel.text=cell.description;
    // Configure the cell...
    
    return cell;
}


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
