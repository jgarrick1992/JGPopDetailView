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
    if (self.onRelresh) {
        self.onRelresh();
    }
}

- (void)onFollowBtnTapped:(id)sender {
    // fix.
}

- (void)onShareBtnTapped:(id)sender {
    // fix.
}

- (void)onSeeBtnTapped:(id)sender {
   // fix.
}

- (void)onLikeBtnTapped:(id)sender {
    
//    if (self.likeBtn.selected) {
//        self.likeBtn.selected = NO;
//        self.likeLab.text = [NSString stringWithFormat:@"%lld", [self.likeLab.text longLongValue] - 1];
//    } else {
//        self.likeBtn.selected = YES;
//        self.likeLab.text = [NSString stringWithFormat:@"%lld", [self.likeLab.text longLongValue] + 1];
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setBool:self.likeBtn.selected
//                                            forKey:[NSString stringWithFormat:@"%@_%ld",self.msgType,(long)self.id]];
}

- (void)onPhotoViewTapped:(id)sender {
//    [self onBackTapped:nil];
//    if (self.onPhotoTapped) {
//        self.onPhotoTapped();
//    }
}

- (void)onVideoViewTapped:(id)sender {
//    [self onBackTapped:nil];
//    if (self.onVideoTapped) {
//        self.onVideoTapped();
//    }
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
        [tap addTarget:self action:@selector(onPhotoViewTapped:)];
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
        btn.layer.cornerRadius = 3;
        [btn setTitle:NSLocalizedString(@"follow", nil) forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHex:kThemeColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(onFollowBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        imageV.image = [UIImage imageNamed:@"follow_alert"];
        [btn addSubview:imageV];
        btn;
    });
    [self.topBannerV addSubview:self.followBtn];
    //fix.位置
//    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.topBannerV.mas_centerY);
//        make.trailing.equalTo(self.topBannerV.mas_trailing).offset(-10);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
//    }];
    
   /*
    // nameLabel
    self.nameLab = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.font = [UIFont systemFontOfSize:15];
        lab.numberOfLines = 0;
        lab.text = @"Columbia High School";
        lab.lineBreakMode = NSLineBreakByTruncatingTail;
        lab;
    });
    [self.topBannerV addSubview:self.nameLab];
    //fix.位置
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.avatarV.mas_top);
//        make.centerY.equalTo(self.avatarV.mas_centerY);
//        make.leading.equalTo(self.avatarV.mas_trailing).offset(5);
//        make.trailing.equalTo(self.followBtn.mas_leading).offset(-10);
//    }];
//    
    // seeBtn
    self.seeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onSeeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.seeBtn];
    //fix.位置
//    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.bottomBannerV.mas_centerY);
//        make.leading.equalTo(self.bottomBannerV.mas_leading).offset(frame.size.width / 8);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    // seeLabel
    self.seeLab = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"563";
        lab.textColor = [UIColor lightGrayColor];
        lab;
    });
    [self.bottomBannerV addSubview:self.seeLab];
    //fix.位置
//    [self.seeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.seeBtn.mas_trailing).offset(5);
//        make.centerY.equalTo(self.bottomBannerV.mas_centerY);
//    }];
    
    // LikeBtn
    self.likeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onLikeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.likeBtn];
    //fix.位置
//    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.bottomBannerV.mas_centerY);
//        make.centerX.equalTo(self.bottomBannerV.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(25, 25));
//    }];
//    
    // likelab
    self.likeLab = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"325";
        lab.textColor = [UIColor lightGrayColor];
        lab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onLikeBtnTapped:)];
        [lab addGestureRecognizer:tap];
        lab;
    });
    [self.bottomBannerV addSubview:self.likeLab];
    //fix.位置
//    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.likeBtn.mas_trailing).offset(5);
//        make.centerY.equalTo(self.bottomBannerV.mas_centerY);
//    }];
    
    // shareBtn 
    self.shareBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onShareBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomBannerV addSubview:self.shareBtn];
    //fix.位置
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.bottomBannerV.mas_centerY);
//        make.trailing.equalTo(self.bottomBannerV.mas_trailing).offset(- frame.size.width / 8);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
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
