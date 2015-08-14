//
//  ViewController.m
//  test
//
//  Created by 黄少华 on 15/7/21.
//  Copyright (c) 2015年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "ShareView.h"
@interface ViewController ()<WXApiDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToWechat:(UIButton *)sender {
    
    ShareView *shareView = [[ShareView alloc] init];
    shareView.text = @"哈哈哈";
    shareView.detailText = @"嘿嘿嘿嘿嘿嘿";
    shareView.url = @"www.baidu.com";
    [shareView show];
    
  NSString *version = [WXApi getApiVersion];
    NSLog(@"version == %@",version);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"shareToWechat" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *wechat = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        [self sendMessageToWechatWithType:0];
//    }];
//    
//    UIAlertAction *friend = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        [self sendMessageToWechatWithType:1];
//    }];
//    
//    UIAlertAction *collection = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        [self sendMessageToWechatWithType:2];
//    }];
//    
//    [alertController addAction:wechat];
//    [alertController addAction:friend];
//    [alertController addAction:collection];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
}


/**
    WXSceneSession  = 0,        < 聊天界面
    WXSceneTimeline = 1,        < 朋友圈
    WXSceneFavorite = 2,        < 收藏
*/
- (void)sendMessageToWechatWithType:(int)type{
    
    //包装消息体
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"伟大的程序员";
    message.description = @"说的就是黄少华啊--链接慎点";
    [message setThumbImage:[UIImage imageNamed:@"29"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"huangshaohua.cn";
    
    message.mediaObject = ext;
    message.mediaTagName = @"text";
    
    SendMessageToWXReq *request = [[SendMessageToWXReq alloc] init];
    
    /** 发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息 */
    request.bText = NO;
    //发送消息的多媒体内容
    request.message = message;
    //发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
    request.scene = type;
    
    
    //发送消息
    [WXApi sendReq:request];
}

@end
