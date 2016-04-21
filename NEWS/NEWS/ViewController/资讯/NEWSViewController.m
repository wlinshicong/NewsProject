//
//  NEWSViewController.m
//  NEWS
//
//  Created by tarena006 on 16/3/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "NEWSViewController.h"
#import "News.h"
#import "KWNetworkManager.h"
#import "KWDataManager.h"
#import "WebNewsViewController.h"


/*--------------新闻界面1--------------*/

@interface NEWSViewController ()<UITableViewDelegate,UITableViewDataSource>

/** */
//@property(nonatomic,strong)UITableView *tableViewListA;
@property (weak, nonatomic) IBOutlet UITableView *tableViewListA;


@property(nonatomic,strong) NSMutableArray *allNews;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewA;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewB;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewC;


@property (weak, nonatomic) IBOutlet UITableView *tableViewListB;
@property (weak, nonatomic) IBOutlet UITableView *tableViewListC;

@end

@implementation NEWSViewController

-(NSMutableArray *)allNews{
    if (!_allNews) {
        _allNews=[NSMutableArray array];
    }
    return _allNews;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //从webView回来时打开隐藏的NavigationBar
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
 //   self.tableViewListB=self.tableViewListA;
  //  self.tablViewListC=self.tableViewListA;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewListA.rowHeight=70;
    
    //因为现在是viewcontroller,所以需要设置一个tableviewcontroller来管理tableView.并且设置代理
//    UITableViewController *tbVC=[[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
//    tbVC.tableView=self.tableViewListA;
    self.tableViewListA.delegate=self;
    self.tableViewListA.dataSource=self;
    self.tableViewListB.delegate=self;
    self.tableViewListB.dataSource=self;
    self.tableViewListC.delegate=self;
    self.tableViewListC.dataSource=self;
   
    [self network];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//获取网络数据
-(void)network{
    [KWNetworkManager sendRequestWithUrl:HTTPURL withHttpArg:HTTPARG success:^(NSData *data, id response) {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"HttpResponseCode:%ld", responseCode);
        NSLog(@"HttpResponseBody %@",responseString);
        
        //解析返回的data
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //每次调用都将返回的数组叠加到原来的数组上---林思聪
        NSArray *tempArr=[KWDataManager getAllNewsData:dict];
        [self.allNews addObjectsFromArray:tempArr];
        NSLog(@"%lu",(unsigned long)self.allNews.count);
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.tableViewListA reloadData];
             [self.tableViewListB reloadData];
             [self.tableViewListC reloadData];
        }];
    } failure:^(NSError *error) {
        NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"元数据数组中的大小%ld个元素",self.allNews.count);
    return self.allNews.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //如继续下拉,且下拉的行数等于现在的数组行数,则请求加载更多的新闻数据叠加到数组中-----林思聪
    NSLog(@"%lu,%lu",indexPath.row,self.allNews.count);
    if (indexPath.row==self.allNews.count-1) {
        
        [self network];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    NSObject *model=self.allNews[indexPath.row];
    if ([model isKindOfClass:[News class]]) {
        //设置表格数据
        News *news=self.allNews[indexPath.row];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsCell"];
        //自定义表格内容
        UILabel *nLabel=[[UILabel alloc]init];
        nLabel.frame=CGRectMake(76, 4, 227, 29);
        nLabel.font=[UIFont systemFontOfSize:15];
        nLabel.text=news.title;
        NSLog(@"新闻标题%@",nLabel.text);
        nLabel.numberOfLines=0;
        nLabel.font=[UIFont systemFontOfSize:15];
        
        UIImageView *nImageView=[[UIImageView alloc]init];
        [nImageView sd_setImageWithURL:[NSURL URLWithString:news.picUrl] placeholderImage:[UIImage imageNamed:@"ForumList_selectPicture_normal"]];
        nImageView.frame=CGRectMake(16, 4, 50, 50);
        
        UILabel *nDLabel=[[UILabel alloc]init];
        nDLabel.frame=CGRectMake(76, 34, 227, 20);
        nDLabel.font=[UIFont systemFontOfSize:12];
        nDLabel.text=news.ctime;
        
        nDLabel.font=[UIFont systemFontOfSize:10];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        [view addSubview:nLabel];
        [view addSubview:nDLabel];
        [view addSubview:nImageView];
        [cell.contentView addSubview:view];
    }
    return cell;
}

//跳转新闻详情界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebNewsViewController *wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"WebNews"];
    News *news=self.allNews[indexPath.row];
    wvc.url=news.url;
    wvc.title=news.title;
    [self.navigationController pushViewController:wvc animated:YES];
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
