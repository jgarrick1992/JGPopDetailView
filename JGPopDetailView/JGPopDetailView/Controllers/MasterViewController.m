//
//  MasterViewController.m
//  JGPopDetailView
//
//  Created by Ji Fu on 7/31/16.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#import "JGPopDetailView.h"
#import "MacroUtility.h"
#import "MasterViewController.h"
#import "ScPlayVideoViewController.h"


@interface MasterViewController ()
// *********************************************************************************************************************
#pragma mark - Property
@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UIImageView *videoV;
@property (strong, nonatomic) JGPopDetailView *popDetailView;

@end

@implementation MasterViewController

// *********************************************************************************************************************
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// *********************************************************************************************************************
#pragma mark - Action
- (void)onImageTapped:(id)sender {
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    if (tap.view.tag == 1001) {
        self.popDetailView.type = kJGPopDetailViewTypePhoto;
    } else {
        self.popDetailView.type = kJGPopDetailViewTypeVideo;
        self.popDetailView.url = @"http://ac-m6wnoxmv.clouddn.com/HeS7xqC7217PNLjNYj0cDCE.m4a";
    }
    [self.popDetailView show:YES];
}

// *********************************************************************************************************************
#pragma mark - Private
- (void)initUI {
    
    self.imageV = ({
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 8, kScreenWidth, kScreenHeight / 3)];
        imageV.image = [UIImage imageNamed:@"autumn.jpg"];
        imageV.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onImageTapped:)];
        imageV.tag = 1001;
        tap.numberOfTapsRequired = 1;
        [imageV addGestureRecognizer:tap];
        imageV;
    });
    
    self.videoV = ({
        UIImageView *videoV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2, kScreenWidth, kScreenHeight / 3)];
        videoV.image = [UIImage imageNamed:@"autumn.jpg"];
        videoV.userInteractionEnabled =YES;
        videoV.tag = 1002;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(onImageTapped:)];
        tap.numberOfTapsRequired = 1;
        [videoV addGestureRecognizer:tap];
        videoV;
    });
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageV];
    [self.view addSubview:self.videoV];
}

// *********************************************************************************************************************
#pragma mark - Getters / setters
- (JGPopDetailView *)popDetailView {
    if (nil == _popDetailView) {
        _popDetailView = [[JGPopDetailView alloc] initWithView:self.view];
        
        Weak(self);
        // 用户点赞实例
        _popDetailView.onLikeTappedBlock = ^(NSInteger likeCount, Boolean isLikeTap) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: isLikeTap ? @"点赞成功" : @"取消点赞"
                                                                                     message:[NSString stringWithFormat:@"当前点赞人数%ld", likeCount]
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [wself presentViewController:alertController animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wself dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        };
        
        // 用户观察后回调实例
        _popDetailView.onViewedBlock = ^(NSInteger viewCount) {
            NSLog(@"当前点看查看%ld次", viewCount);
        };
        
        // 用户点击分享回调实例
        _popDetailView.onShareTappedBlock = ^() {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                     message: nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *actionWeixing = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *actionQQ = [UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *actionWeibo = [UIAlertAction actionWithTitle:@"微博" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *actionCanncel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:actionWeixing];
            [alertController addAction:actionQQ];
            [alertController addAction:actionWeibo];
            [alertController addAction:actionCanncel];
            
            [wself presentViewController:alertController animated:YES completion:nil];
        };
        
        // 用户点击关注后回调
        _popDetailView.onFollowTappedBlock = ^() {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"关注成功！！"
                                                                                     message: nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [wself presentViewController:alertController animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [wself dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        };
        
        // 用户点击中央图片后回调
        _popDetailView.onPhotoTappedBlock = ^(UIImage *image, NSString *url) {
            [wself imageShow:image];
        };
        
        // 用户点击视频播放后回调
        _popDetailView.onVideoTappedBlock = ^(UIImage *image, NSString *url) {
            ScPlayVideoViewController *playVC = [[ScPlayVideoViewController alloc] init];
            playVC.urlStr = url;
            [wself presentViewController:playVC animated:YES completion:nil];
        };
        
    }
    return _popDetailView;
}

// *********************************************************************************************************************
#pragma mark - 图片显示
- (void)imageShow:(UIImage *)image {
    UIImageView *captureImageView = [[UIImageView alloc] initWithImage:image];
    captureImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    captureImageView.frame = CGRectOffset(self.view.bounds, 0, -self.view.bounds.size.height);
    captureImageView.alpha = 1.0;
    captureImageView.contentMode = UIViewContentModeScaleAspectFit;
    captureImageView.userInteractionEnabled = YES;
    [self.view addSubview:captureImageView];
    
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPreview:)];
    [captureImageView addGestureRecognizer:dismissTap];
    
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        captureImageView.frame = self.view.bounds;
    } completion:nil];
}

- (void)dismissPreview:(UITapGestureRecognizer *)dismissTap {
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^ {
    }completion:^(BOOL finished){
        [dismissTap.view removeFromSuperview];
    }];
}

@end
