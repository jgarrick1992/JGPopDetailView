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
#pragma mark - Propery
@property (strong, nonatomic) id               model;
@property (strong, nonatomic) NSString         *type;
@property (strong, nonatomic) NSString         *image;
@property (assign, nonatomic) NSInteger        seeCount;
@property (assign, nonatomic) NSInteger        likeCount;
@property (assign, nonatomic) NSInteger        id;
@property (assign, nonatomic) NSString         *msgType;
@property (strong, nonatomic) NSString         *title;


// *********************************************************************************************************************
#pragma mark - OVER

// 提示框是否现在屏幕中心
@property (assign, nonatomic) BOOL inCenter;                    // defualt = YES
// 提示卡片背景色
@property (assign, nonatomic) UIColor *cardBackground;          // defualt = 0x36bcc7

@property (copy, nonatomic) void (^onRelresh)();
@property (copy, nonatomic) void (^onPhotoTapped)();
@property (copy, nonatomic) void (^onVideoTapped)();

// *********************************************************************************************************************
#pragma mark - Public
//- (void)initWithSchool:(School *)school
//                 title:(NSString *)title
//                 image:(NSString *)image
//                    Id:(NSInteger)id
//              seeCount:(NSInteger)seeCount
//             likeCount:(NSInteger)likeCount
//                  type:(NSString *)type
//               msgType:(NSString *)msgType;

@end
