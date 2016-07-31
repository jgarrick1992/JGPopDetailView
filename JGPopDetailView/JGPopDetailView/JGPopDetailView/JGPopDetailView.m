//
//  VsSchoolDetailAlertView.m
//  veritas
//
//  Created by Ji Fu on 16/6/6.
//  Copyright © 2016年 iHugo. All rights reserved.
//

#import "MacroUtility.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
#import "VsSchoolDetailAlertView.h"
#import <SDWebImage+ExtensionSupport/UIImageView+WebCache.h>
#import "VsShareManager.h"
#import "UIDevice+Language.h"


@interface VsSchoolDetailAlertView ()

// *********************************************************************************************************************
#pragma mark - Property
@property (strong, nonatomic) UIView *topV;
@property (strong, nonatomic) UIView *bottomV;
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UIView *bgV;
@property (strong, nonatomic) UIView *alertV;

@property (strong, nonatomic) UIImageView *avatarV;
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UIButton *followBtn;
@property (strong, nonatomic) UIButton *seeBtn;
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UIButton *shareBtn;
@property (strong, nonatomic) UILabel *seeLab;
@property (strong, nonatomic) UILabel *likeLab;

@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) UIView *videoShadowV;

@end

@implementation VsSchoolDetailAlertView

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
    [[VsShareManager sharedManager] onFollowWithSchool:self.school withViewController:self.vc success:nil];
}

- (void)onShareBtnTapped:(id)sender {
    [[VsShareManager sharedManager] onShareModel:self.model];
}

- (void)onSeeBtnTapped:(id)sender {
    
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
    
    // BgView
    self.bgV = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.65;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onBackTapped:)];
        [view addGestureRecognizer:tap];
        view;
    });
    [self addSubview:self.bgV];
    
    // alertView
    self.alertV = ({
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.layer.cornerRadius = 10;
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self addSubview:self.alertV];
    [self.alertV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(frame.size.width, frame.size.height));
    }];
    
    
    // BottomView
    self.bottomV = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHex:0xeeeeee];
        view;
    });
    [self.alertV addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.alertV.mas_bottom);
        make.width.equalTo(self.alertV.mas_width);
        make.leading.equalTo(self.alertV.mas_leading);
        make.height.mas_equalTo(50);
    }];
    
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
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertV.mas_top);
        make.leading.equalTo(self.alertV.mas_leading);
        make.width.equalTo(self.alertV.mas_width);
        make.bottom.equalTo(self.bottomV.mas_top);
    }];
    
    // TopView
    self.topV = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHex:kThemeColor];
        view;
    });
    [self.alertV addSubview:self.topV];
    [self.topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertV.mas_top);
        make.width.equalTo(self.alertV.mas_width);
        make.leading.equalTo(self.alertV.mas_leading);
        make.height.mas_equalTo(50);
    }];

    // AvatarView
    self.avatarV = ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"slash_bg_blur"];
        imageV.layer.cornerRadius = 20;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV;
    });
    [self.topV addSubview:self.avatarV];
    [self.avatarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topV.mas_centerY);
        make.leading.equalTo(self.topV.mas_leading).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    // followBtn
    self.followBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 3;
        [btn setTitle:NSLocalizedString(@"follow", nil) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:kThemeColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(onFollowBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        imageV.image = [UIImage imageNamed:@"follow_alert"];
        [btn addSubview:imageV];
        btn;
    });
    [self.topV addSubview:self.followBtn];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topV.mas_centerY);
        make.trailing.equalTo(self.topV.mas_trailing).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
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
    [self.topV addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarV.mas_top);
        make.centerY.equalTo(self.avatarV.mas_centerY);
        make.leading.equalTo(self.avatarV.mas_trailing).offset(5);
        make.trailing.equalTo(self.followBtn.mas_leading).offset(-10);
    }];
    
    // seeBtn
    self.seeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onSeeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomV addSubview:self.seeBtn];
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomV.mas_centerY);
        make.leading.equalTo(self.bottomV.mas_leading).offset(frame.size.width / 8);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    // seeLabel
    self.seeLab = ({
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"563";
        lab.textColor = [UIColor lightGrayColor];
        lab;
    });
    [self.bottomV addSubview:self.seeLab];
    [self.seeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.seeBtn.mas_trailing).offset(5);
        make.centerY.equalTo(self.bottomV.mas_centerY);
    }];
    
    // LikeBtn
    self.likeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(onLikeBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomV addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomV.mas_centerY);
        make.centerX.equalTo(self.bottomV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
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
    [self.bottomV addSubview:self.likeLab];
    [self.likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.likeBtn.mas_trailing).offset(5);
        make.centerY.equalTo(self.bottomV.mas_centerY);
    }];
    
    // shareBtn 
    self.shareBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onShareBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.bottomV addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomV.mas_centerY);
        make.trailing.equalTo(self.bottomV.mas_trailing).offset(- frame.size.width / 8);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    self.videoShadowV = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.6;
        view;
    });
    [self.imageV addSubview:self.videoShadowV];
    [self.videoShadowV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageV.mas_leading);
        make.trailing.equalTo(self.imageV.mas_trailing);
        make.top.equalTo(self.imageV.mas_top);
        make.bottom.equalTo(self.imageV.mas_bottom);
    }];
    
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
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageV.mas_centerX);
        make.centerY.equalTo(self.imageV.mas_centerY).offset(25);
    }];
    
}

- (void)initWithSchool:(School *)school
                 title:(NSString *)title
                 image:(NSString *)image
                    Id:(NSInteger)id
              seeCount:(NSInteger)seeCount
             likeCount:(NSInteger)likeCount
                  type:(NSString *)type
               msgType:(NSString *)msgType {
            
    self.school = school;
    self.id = id;
    self.image = image;
    self.seeCount = seeCount;
    self.likeCount = likeCount;
    self.type = type;
    self.msgType = msgType;
    self.title = title;
                   
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@_%ld",self.msgType, (long)id]];
    if (flag) {
        self.likeBtn.selected = YES;
        self.likeLab.text = [NSString stringWithFormat:@"%ld", (long)self.likeCount + 1];
    } else {
        self.likeBtn.selected = NO;
        self.likeLab.text = [NSString stringWithFormat:@"%ld",(long)self.likeCount];
    }
                   
    self.seeLab.text = [NSString stringWithFormat:@"%ld",(long)self.seeCount];
                   
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.image]
                   placeholderImage:nil
                            options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
                   


                   
    [self.avatarV sd_setImageWithURL:[NSURL URLWithString:self.school.avatar]
                   placeholderImage:nil
                            options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
                   
    if(nil == self.school) {
        self.topV.hidden = YES;
    } else {
//        self.nameLab.text = self.title;
        if (self.school) {
            self.nameLab.text = [UIDevice formatSchoolNameOnCurrentLanguageWithShool:self.school];
        }
        else
        {
            self.nameLab.text = self.title;
        }
        self.topV.hidden = NO;
    }
                   
    if([self.type isEqualToString:kDataTypePhoto]) {
       self.videoShadowV.hidden = YES;
    } else {
       self.videoShadowV.hidden = NO;
    }
}

@end
