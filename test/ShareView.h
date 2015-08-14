//
//  ShareView.h
//  WKDoctor
//
//  Created by 黄少华 on 15/8/13.
//  Copyright (c) 2015年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

/**
 *  标题
 */
@property (nonatomic, copy) NSString *text;
/**
 *  详情
 */
@property (nonatomic, copy) NSString *detailText;
/**
 *  链接
 */
@property (nonatomic, copy) NSString *url;


/**
 *  显示shareView
 */
- (void)show;
@end
