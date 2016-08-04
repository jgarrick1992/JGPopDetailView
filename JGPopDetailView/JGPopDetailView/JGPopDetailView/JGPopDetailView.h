//
//  JGPopDetailView.h
//  veritas
//
//  Created by Ji Fu on 16/6/6.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JGPopDetailView : UIView

// *********************************************************************************************************************
#pragma mark - Init Mehtod
- (id)initWithView:(UIView *)view andFrame:(CGRect)frame;
- (id)initWithView:(UIView *)view;
- (id)initWithWindow:(UIWindow *)window;
- (id)initWithViewController:(UIViewController *)viewController;

// *********************************************************************************************************************
#pragma mark - Public
- (void)show:(BOOL)animated;
- (void)dismiss:(BOOL)animated;

// *********************************************************************************************************************
#pragma mark - Propery
@property (strong, nonatomic) NSString *title;                  // 标题
@property (strong, nonatomic) NSString *avatar;                 // 用户头像缩略图
@property (strong, nonatomic) NSString *thumbnailUrl;           // 图片 or 视频 缩略图
@property (assign, nonatomic) NSInteger viewCount;              // 观察次数
@property (assign, nonatomic) NSInteger likeCount;              // 点赞次数
@property (assign, nonatomic) CGRect cardFrame;                 // 卡片的显示大小

// 提示框是否现在屏幕中心
@property (assign, nonatomic) BOOL inCenter;                    // defualt = YES
// 提示卡片背景色
@property (assign, nonatomic) UIColor *cardBackground;          // defualt = 0x36bcc7

// *********************************************************************************************************************
#pragma mark - callback block
// 点击关注按钮的回调
@property (copy, nonatomic) void (^onFollowTappedBlock)();
// 点击图片的回调
@property (copy, nonatomic) void (^onPhotoTappedBlock)();
// 点击视频播放后的回调
@property (copy, nonatomic) void (^onVideoTappedBlock)();
// 观察后的回调
@property (copy, nonatomic) void (^onViewTappedBlock)();
// 点赞后的回调
@property (copy, nonatomic) void (^onLikeTappedBlock)();
// 点击分享按钮的回调
@property (copy, nonatomic) void (^onShareTappedBlock)();




@end
