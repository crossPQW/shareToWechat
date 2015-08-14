//
//  ShareView.m
//  WKDoctor
//
//  Created by 黄少华 on 15/8/13.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import "ShareView.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface ShareView()

@property (nonatomic, strong) UIView *cover;
@end

@implementation ShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil] lastObject];
        self.frame = CGRectMake(0, 568, 320, 185);
    }
    return self;
}


- (void)show
{
    //添加一个灰色背景
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.cover = cover;
    cover.backgroundColor = [UIColor lightGrayColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)];
    [cover addGestureRecognizer:tapGesture];
    
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    [cover addSubview:self];
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(0, 568 - 185, 320, 185);
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  分享给朋友
 */
- (IBAction)shareToFriend:(UIButton *)sender {
    
    [self sendMessageToWechatWithType:0];
}
/**
 *  分享到朋友圈
 */
- (IBAction)shareToTimeline:(UIButton *)sender {
    
    [self sendMessageToWechatWithType:1];
}

- (IBAction)cancleShare:(UIButton *)sender {
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.frame = CGRectMake(0, 568, 320, 185);
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
    }];
}

- (void)tapCover:(UITapGestureRecognizer *)tapGesture
{
    [self cancleShare:nil];
}


/**
 WXSceneSession  = 0,        < 聊天界面
 WXSceneTimeline = 1,        < 朋友圈
 WXSceneFavorite = 2,        < 收藏
 */
- (void)sendMessageToWechatWithType:(int)type{
    
    //包装消息体
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.text;
    message.description = self.detailText;
    [message setThumbImage:[UIImage imageNamed:@"29"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.url;
    
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
