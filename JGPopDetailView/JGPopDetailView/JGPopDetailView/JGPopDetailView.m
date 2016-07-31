//
//  JGPopDetailView.m
//  veritas
//
//  Created by Ji Fu on 16/6/6.
//  Copyright © 2016年 iHugo. All rights reserved.
//

#import "JGPopDetailView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight 20
#define kNavigationBarHeight 50
#define kTabBarHeight 48

@interface JGPopDetailView ()

// *********************************************************************************************************************
#pragma mark - Property
// 背景透明视图
@property (strong, nonatomic) UIView *blurBackgroundV;

// 主显示视图
@property (strong, nonatomic) UIView *alertV;

// 中央提示区图片视图
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
        [self setupUI:frame];
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
    
    if (self.likeBtn.selected) {
        self.likeBtn.selected = NO;
        self.likeLab.text = [NSString stringWithFormat:@"%lld", [self.likeLab.text longLongValue] - 1];
    } else {
        self.likeBtn.selected = YES;
        self.likeLab.text = [NSString stringWithFormat:@"%lld", [self.likeLab.text longLongValue] + 1];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:self.likeBtn.selected
                                            forKey:[NSString stringWithFormat:@"%@_%ld",self.msgType,(long)self.id]];
}

- (void)onPhotoViewTapped:(id)sender {
    [self onBackTapped:nil];
    if (self.onPhotoTapped) {
        self.onPhotoTapped();
    }
}

- (void)onVideoViewTapped:(id)sender {
    [self onBackTapped:nil];
    if (self.onVideoTapped) {
        self.onVideoTapped();
    }
}

// *********************************************************************************************************************
#pragma mark - Private
- (void)setupUI:(CGRect)frame {
    
    // blurBackgroundView
    self.blurBackgroundV = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.65;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onBackTapped:)];
        [view addGestureRecognizer:tap];
        view;
    });
    [self addSubview:self.blurBackgroundV];
    
    // alertView
    self.alertV = ({
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius = 10;
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:self.alertV];
    // fix.位置
//    [self.alertV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(frame.size.width, frame.size.height));
//    }];
    
    
    // bottomBannerView
    self.bottomBannerV = ({
        UIView *view = [[UIView alloc] init];
        //fix.
//        view.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        view;
    });
    [self.alertV addSubview:self.bottomBannerV];
    // fix.位置
//    [self.bottomBannerV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.alertV.mas_bottom);
//        make.width.equalTo(self.alertV.mas_width);
//        make.leading.equalTo(self.alertV.mas_leading);
//        make.height.mas_equalTo(50);
//    }];
    
    // ImageView
    self.imageV = ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV.image = [UIImage  imageNamed:@"slash_bg_blur"];
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onPhotoViewTapped:)];
        [imageV addGestureRecognizer:tap];
        imageV;
    });
    [self.alertV addSubview:self.imageV];
    // fix.位置
//    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.alertV.mas_top);
//        make.leading.equalTo(self.alertV.mas_leading);
//        make.width.equalTo(self.alertV.mas_width);
//        make.bottom.equalTo(self.bottomBannerV.mas_top);
//    }];
    
    // topBannerView
    self.topBannerV = ({
        UIView *view = [[UIView alloc] init];
        //fix.
//        view.backgroundColor = [UIColor colorWithHex:kThemeColor];
        view;
    });
    [self.alertV addSubview:self.topBannerV];
    //fix.位置
//    [self.topBannerV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.alertV.mas_top);
//        make.width.equalTo(self.alertV.mas_width);
//        make.leading.equalTo(self.alertV.mas_leading);
//        make.height.mas_equalTo(50);
//    }];

    // AvatarView
    self.avatarV = ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"slash_bg_blur"];
        imageV.layer.cornerRadius = 20;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV;
    });
    [self.topBannerV addSubview:self.avatarV];
    //fix.位置
//    [self.avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.topBannerV.mas_centerY);
//        make.leading.equalTo(self.topBannerV.mas_leading).offset(5);
//        make.size.mas_equalTo(CGSizeMake(40, 40));
//    }];
    
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

@end
