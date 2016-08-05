//
//  JGPopDetailView.m
//  veritas
//
//  Created by Ji Fu on 16/6/6.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#import "JGPopDetailView.h"
#import "MacroUtility.h"


@interface JGPopDetailView ()
// *********************************************************************************************************************
#pragma mark - Property
// 背景透明视图
@property (strong, nonatomic) UIView *blurBackgroundV;

// 主显示视图
@property (strong, nonatomic) UIView *alertCardV;

// 提示卡片图片视图
@property (strong, nonatomic) UIImageView *centerImageV;

// 播放按钮
@property (strong, nonatomic) UIButton *playBtn;

// 播放视频thumbnail Blur
@property (strong, nonatomic) UIView *thumbnailBlurV;

// 顶部 Banner 视图
@property (strong, nonatomic) UIView *topBannerV;

// 用户头像视图     ( topBannerV )
@property (strong, nonatomic) UIImageView *avatarV;

// 标题栏          ( topBannerV )
@property (strong, nonatomic) UILabel *titleLab;

// 关注按钮        ( topBannerV )
@property (strong, nonatomic) UIButton *followBtn;

// 底部 Banner 视图
@property (strong, nonatomic) UIView *bottomBannerV;

// 已阅读按钮      ( bottomBannerV )
@property (strong, nonatomic) UIButton *viewCountBtn;

// 点赞按钮        ( bottomBannerV )
@property (strong, nonatomic) UIButton *likeCountBtn;

// 分享按钮        ( bottomBannerV )
@property (strong, nonatomic) UIButton *shareBtn;

// 已阅读数量标签   ( bottomBannerV )
@property (strong, nonatomic) UILabel *viewCountLab;

// 点赞数量标签    ( bottomBannerV )
@property (strong, nonatomic) UILabel *likeCountLab;

@property (strong, nonatomic) UIView *superView;

@end

@implementation JGPopDetailView

// *********************************************************************************************************************
#pragma mark - Init Mehtod
- (id)initWithView:(UIView *)view
                    andFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        self.superView = view;
        self.cardFrame = CGRectEqualToRect(frame, CGRectZero)  ? CGRectMake(0, 0, kScreenWidth - 50, kScreenWidth - 50) : frame;
        
        [self setupUI:self.cardFrame];          // 初始化视图
        [self setupDefault];                    // 设置默认参数
    }
    return self;
}

- (id)initWithView:(UIView *)view {
    return [self initWithView:view andFrame:CGRectZero];
}

- (id)initWithWindow:(UIWindow *)window {
    return [self initWithView:window andFrame:CGRectZero];
}

- (id)initWithViewController:(UIViewController *)viewController {
    return [self initWithView:viewController.view andFrame:CGRectZero];
}

// *********************************************************************************************************************
#pragma mark - Public Method
- (void)show:(BOOL)animated {
//    UIImageView *captureImageView = [[UIImageView alloc] initWithImage:self];
//    captureImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
//    captureImageView.frame = CGRectOffset(target.view.bounds, 0, -target.view.bounds.size.height);
//    captureImageView.alpha = 1.0;
//    captureImageView.contentMode = UIViewContentModeScaleAspectFit;
//    captureImageView.userInteractionEnabled = YES;
//    [target.view addSubview:captureImageView];
    
//    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    } completion:nil];
    [self.superView addSubview:self];
    self.viewCount++;
}

- (void)dismiss:(BOOL)animated {
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^ {
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

// *********************************************************************************************************************
#pragma mark - Actions
- (void)onBackTapped:(id)sender {
    [self removeFromSuperview];
}

- (void)onFollowTapped:(id)sender {
    self.onFollowTappedBlock ? self.onFollowTappedBlock() : nil;
}

- (void)onPhotoTapped:(id)sender {
    self.onPhotoTappedBlock ? self.onPhotoTappedBlock(self.centerImageV.image, self.url) : nil;
}

- (void)onVideoPlayerTapped:(id)sender {
    self.onVideoTappedBlock ? self.onVideoTappedBlock(self.centerImageV.image, self.url) : nil;
    [self onBackTapped:nil];
}

- (void)onShareBtnTapped:(id)sender {
    self.onShareTappedBlock ? self.onShareTappedBlock() : nil;
}

- (void)onLikeBtnTapped:(id)sender {
    
    if (self.likeCountBtn.selected) {
        self.likeCountBtn.selected = NO;
        self.likeCount = self.likeCount - 1;
    } else {
        self.likeCountBtn.selected = YES;
        self.likeCount = self.likeCount + 1;
    }
    
    self.onLikeTappedBlock ? self.onLikeTappedBlock(self.likeCount, self.likeCountBtn.selected) : nil;
}

// *********************************************************************************************************************
#pragma mark - Private
- (void)setupUI:(CGRect)frame {
    
    // blurBackgroundV
    self.blurBackgroundV = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.75;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onBackTapped:)];
        [view addGestureRecognizer:tap];
        view;
    });
    [self addSubview:self.blurBackgroundV];
    
    // alertCardV
    self.alertCardV = ({
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius = 10;
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:self.alertCardV];

    // bottomBannerV
    self.bottomBannerV = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 50, frame.size.width, 50)];
        view.backgroundColor = [self colorWithHex:0xeeeeee alpha:1.0];
        view;
    });
    [self.alertCardV addSubview:self.bottomBannerV];
    
    // centerImageV
    self.centerImageV = ({
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height - 100)];
        imageV.image = [UIImage imageNamed:@"autumn.jpg"];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onPhotoTapped:)];
        [imageV addGestureRecognizer:tap];
        imageV;
    });
    [self.alertCardV addSubview:self.centerImageV];
    
    // topBannerV
    self.topBannerV = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        view;
    });
    [self.alertCardV addSubview:self.topBannerV];

    // avatarV
    self.avatarV = ({
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        imageV.image = [UIImage imageNamed:@"autumn.jpg"];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV.layer.cornerRadius = 20;
        imageV;
    });
    [self.topBannerV addSubview:self.avatarV];
    
    // followBtn
    self.followBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(frame.size.width - 80 - 10, 10, 80, 30);
        btn.layer.cornerRadius = 3;
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn setTitleColor:[self colorWithHex:kThemeColor alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(onFollowTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        imageV.image = [UIImage imageNamed:@"follow_alert.png"];
        [btn addSubview:imageV];
        btn;
    });
    [self.topBannerV addSubview:self.followBtn];
    
    // titleLab
    self.titleLab = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, frame.size.width - 140, 20)];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 0;
        lab.text = @"Columbia High School";
        lab.lineBreakMode = NSLineBreakByTruncatingTail;
        lab;
    });
    [self.topBannerV addSubview:self.titleLab];
    
    // viewCountBtn
    self.viewCountBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(frame.size.width / 8, 12, 30, 30);
        [btn setImage:[UIImage imageNamed:@"viewCountBtn"] forState:UIControlStateNormal];
        btn;
    });
    [self.bottomBannerV addSubview:self.viewCountBtn];
    
    // viewCountLab
    self.viewCountLab = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 8 + 35, 15, 60, 20)];
        lab.textColor = [UIColor lightGrayColor];
        lab;
    });
    [self.bottomBannerV addSubview:self.viewCountLab];
    
    // likeCountBtn
    self.likeCountBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(frame.size.width / 2 - 15, 12, 30, 30);
        [btn setImage:[UIImage imageNamed:@"likeBtn.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"likedBtn.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onLikeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.likeCountBtn];
    
    // likeCountLab
    self.likeCountLab = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width /2 + 15, 18, 60, 20)];
        lab.textColor = [UIColor lightGrayColor];
        lab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onLikeBtnTapped:)];
        [lab addGestureRecognizer:tap];
        lab;
    });
    [self.bottomBannerV addSubview:self.likeCountLab];

    // shareBtn
    self.shareBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(frame.size.width / 1.3, 12, 30, 30);
        [btn setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onShareBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.shareBtn];
    
    // thumbnailBlurV
    self.thumbnailBlurV = ({
        UIView *view = [[UIView alloc] initWithFrame:self.centerImageV.frame];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.6;
        view;
    });
    [self.alertCardV addSubview:self.thumbnailBlurV];
    
    // PlayBtn
    self.playBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"popular_play"] forState:UIControlStateNormal];
        CGRect frame = self.thumbnailBlurV.frame;
        [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.playBtn = btn;
        [btn setContentMode:UIViewContentModeCenter];
        CGFloat unitX = self.thumbnailBlurV.frame.size.width /2 - 200;
        CGFloat unitY = self.thumbnailBlurV.frame.size.height /2 - 150;
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(unitX, unitY, unitX, unitY);
        [btn addTarget:self action:@selector(onVideoPlayerTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.thumbnailBlurV addSubview:self.playBtn];
}

- (void)setupDefault {
    
    // 默认显示在屏幕中心
    [self setInCenter:YES];
    
    // 默认提示卡片背景色 kThemeColor
    [self setCardBackground:[self colorWithHex:kThemeColor alpha:1.0]];
    
    // 初始化时不显示
    self.likeCount = 0;
    self.viewCount = 0;
}

// *********************************************************************************************************************
#pragma mark - Extend Method
- (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

// *********************************************************************************************************************
#pragma mark - Geters/Setters
- (void)setLikeCount:(NSInteger)likeCount {
    _likeCount = likeCount;
    self.likeCountLab.text = [NSString stringWithFormat:@"%ld", (long)_likeCount];
}

- (void)setViewCount:(NSInteger)viewCount {
    _viewCount = viewCount;
    self.viewCountLab.text = [NSString stringWithFormat:@"%ld", (long)_viewCount];
    self.onViewedBlock ? self.onViewedBlock(self.viewCount) : nil;
}

- (void)setType:(kJGPopDetailViewType)type {
    _type = type;
    
    BOOL flag = (_type == kJGPopDetailViewTypePhoto) ? YES : NO;
    self.playBtn.hidden = flag;
    self.thumbnailBlurV.hidden = flag;
}

- (void)setInCenter:(BOOL)inCenter {
    _inCenter = inCenter;
    
    if (_inCenter) {
        self.alertCardV.center = self.center;
    } else {
        self.alertCardV.frame = self.frame;
    }
}

- (void)setCardBackground:(UIColor *)cardBackground {
    _cardBackground = cardBackground;
    self.alertCardV.backgroundColor = _cardBackground;
}

- (void)setAvatar:(NSString *)avatar {
    
}

- (void)setThumbnailUrl:(NSString *)thumbnailUrl {
    
}

@end
