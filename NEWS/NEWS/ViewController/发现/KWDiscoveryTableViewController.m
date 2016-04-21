//
//  KWDiscoveryTableViewController.m
//  NEWS
//
//  Created by tarena006 on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KWDiscoveryTableViewController.h"
#import <AVFoundation/AVFoundation.h>

/*--------------新闻界面3--------------*/

@interface KWDiscoveryTableViewController ()<AVCaptureMetadataOutputObjectsDelegate>

//管理输入输出流
@property (nonatomic, strong) AVCaptureSession *session;

//显示信息
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation KWDiscoveryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决storyboard表头高度对齐
    self.tableView.contentInset=UIEdgeInsetsMake(-8, 0, 0, 0);
    self.tableView.sectionHeaderHeight=10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        [self setupCamera];
    }
}

-(void)setupCamera{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //耗时操作
        //1.实例化拍摄设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //2.设置输入设备
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        //3.设置元数据输出
        //3.1实例化拍摄元数据输出
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        //3.2设置输出数据代理
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        //4.添加拍摄会话
        //4.1实例化拍摄会话
        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([session canAddInput:input]) {
            //4.2添加会话输入
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            //4.3添加会话输出
            [session addOutput:output];
        }
        //4.4设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        self.session = session;
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新界面
            //5.视频预览图层
            //5.1实例化预览图层，传递_session是为了告诉图层将来显示什么内容
            AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
            preview.videoGravity=AVLayerVideoGravityResizeAspectFill;
            preview.frame=self.view.bounds;
            //5.2将图层插入当前视图
            [self.view.layer insertSublayer:preview atIndex:0];
            self.previewLayer=preview;
            
            //6.启动会话
            [_session startRunning];
        });
    });
}

//static NSTimer *timer;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
    //timer=[NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[timer invalidate];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    
    //会频繁的扫描，调用代理方法
    
    //2.删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    NSLog(@"%@",metadataObjects);
    //3.设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        //在这里可以对我们得到的数据进行加工处理
        AVMetadataMachineReadableCodeObject *metadataObject=[metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:stringValue]];
    }
    //1.如果扫描完成，停止会话
    [self.session stopRunning];
    //[timer invalidate];
    NSLog(@"%@",stringValue);
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
 
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
