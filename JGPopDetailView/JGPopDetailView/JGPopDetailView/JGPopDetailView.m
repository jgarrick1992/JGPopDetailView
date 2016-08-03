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

@end

@implementation JGPopDetailView

// *********************************************************************************************************************
#pragma mark - Init Mehtod
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        [self setupUI:frame];       // 初始化视图
        [self setupDefault];        // 设置默认参数
    }
    return self;
}

// *********************************************************************************************************************
#pragma mark - Actions
- (void)onBackTapped:(id)sender {
    [self removeFromSuperview];
}

- (void)onFollowTappedBlock:(id)sender {
    self.onFollowTappedBlock ? self.onFollowTappedBlock() : nil;
}

- (void)onPhotoTappedBlock:(id)sender {
    //fix back
    self.onPhotoTappedBlock ? self.onPhotoTappedBlock() : nil;
}

- (void)onVideoTappedBlock:(id)sender {
    //fix back
    self.onVideoTappedBlock ? self.onVideoTappedBlock() : nil;
}

- (void)onShareBtnTapped:(id)sender {
    self.onShareTappedBlock ? self.onShareTappedBlock() : nil;
}

- (void)onSeeBtnTapped:(id)sender {
    self.onVideoTappedBlock ? self.onViewTappedBlock() : nil;
}

- (void)onLikeBtnTapped:(id)sender {
    
    if (self.likeCountBtn.selected) {
        self.likeCountBtn.selected = NO;
        self.likeCountLab.text = [NSString stringWithFormat:@"%lld", [self.likeCountLab.text longLongValue] - 1];
    } else {
        self.likeCountBtn.selected = YES;
        self.likeCountLab.text = [NSString stringWithFormat:@"%lld", [self.likeCountLab.text longLongValue] + 1];
    }
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
        [tap addTarget:self action:@selector(onPhotoTappedBlock:)];
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
        [btn addTarget:self action:@selector(onVideoTappedBlock:) forControlEvents:UIControlEventTouchUpInside];
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
        [btn addTarget:self action:@selector(onSeeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.viewCountBtn];
    
    // viewCountLab
    self.viewCountLab = ({
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 8 + 35, 15, 60, 20)];
        lab.text = @"563";
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
        lab.text = @"325";
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
    /*
    
    self.videoShadowV = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.6;
        view;
    });
    [self.imageV addSubview:self.videoShadowV];
    //fix.位置
//    [self.videoShadowV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.imageV.mas_leading);
//        make.trailing.equalTo(self.imageV.mas_trailing);
//        make.top.equalTo(self.imageV.mas_top);
//        make.bottom.equalTo(self.imageV.mas_bottom);
//    }];
    
    // PlayBtn
    self.playBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"popular_play"] forState:UIControlStateNormal];
        CGRect frame = self.imageV.frame;
        [btn setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.playBtn = btn;
        [btn setContentMode:UIViewContentModeCenter];
        btn.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50);
        [btn addTarget:self action:@selector(onVideoViewTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.videoShadowV addSubview:self.playBtn];
    //fix.位置
//    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.imageV.mas_centerX);
//        make.centerY.equalTo(self.imageV.mas_centerY).offset(25);
//    }];
   */
}

//- (void)initWithSchool:(School *)school
//                 title:(NSString *)title
//                 image:(NSString *)image
//                    Id:(NSInteger)id
//              seeCount:(NSInteger)seeCount
//             likeCount:(NSInteger)likeCount
//                  type:(NSString *)type
//               msgType:(NSString *)msgType {
//            
//    self.school = school;
//    self.id = id;
//    self.image = image;
//    self.seeCount = seeCount;
//    self.likeCount = likeCount;
//    self.type = type;
//    self.msgType = msgType;
//    self.title = title;
//                   
//    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%ld",self.msgType, (long)id]];
//    if (flag) {
//        self.likeBtn.selected = YES;
//        self.likeLab.text = [NSString stringWithFormat:@"%ld", (long)self.likeCount + 1];
//    } else {
//        self.likeBtn.selected = NO;
//        self.likeLab.text = [NSString stringWithFormat:@"%ld",(long)self.likeCount];
//    }
//                   
//    self.seeLab.text = [NSString stringWithFormat:@"%ld",(long)self.seeCount];
//                   
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.image]
//                   placeholderImage:nil
//                            options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
//                   
//
//
//                   
//    [self.avatarV sd_setImageWithURL:[NSURL URLWithString:self.school.avatar]
//                   placeholderImage:nil
//                            options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
//                   
//    if(nil == self.school) {
//        self.topBannerV.hidden = YES;
//    } else {
////        self.nameLab.text = self.title;
//        if (self.school) {
//            self.nameLab.text = [UIDevice formatSchoolNameOnCurrentLanguageWithShool:self.school];
//        }
//        else
//        {
//            self.nameLab.text = self.title;
//        }
//        self.topBannerV.hidden = NO;
//    }
//                   
//    if([self.type isEqualToString:kDataTypePhoto]) {
//       self.videoShadowV.hidden = YES;
//    } else {
//       self.videoShadowV.hidden = NO;
//    }
//}

- (void)setupDefault {
    
    // 默认显示在屏幕中心
    [self setInCenter:YES];
    
    // 默认提示卡片背景色 kThemeColor
    [self setCardBackground:[self colorWithHex:kThemeColor alpha:1.0]];
    
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

@end
