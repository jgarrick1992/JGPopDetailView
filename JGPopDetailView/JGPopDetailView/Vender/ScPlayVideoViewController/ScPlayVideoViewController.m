//
//  ScPlayVideoViewController.m
//  senior-care
//
//  Created by Ji Fu on 4/20/16.
//  Copyright © 2016 FriendMedia. All rights reserved.
//

#import "MacroUtility.h"
#import "ScPlayVideoViewController.h"


@interface ScPlayVideoViewController()
// *********************************************************************************************************************
#pragma mark - Property
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@end

@implementation ScPlayVideoViewController

// *********************************************************************************************************************
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加通知
    [self addNotification];
    
    // 增加手势
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SVProgressHUDDidReceiveTouchEventNotification:)];
    self.tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.tap];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    //播放
    [self.moviePlayer play];
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// *********************************************************************************************************************
#pragma mark - Override
// 关闭Status栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

// *********************************************************************************************************************
#pragma mark - Private
// 取得本地文件路径
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"The New Look of OS X Yosemite.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

// 取得网络文件路径
-(NSURL *)getNetworkUrl {
    self.urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:self.urlStr];
    return url;
}

// 添加通知监控媒体播放控制器状态
-(void)addNotification{
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    // 播放状态
    [notificationCenter addObserver:self
                           selector:@selector(mediaPlayerPlaybackStateChange:)
                               name:MPMoviePlayerPlaybackStateDidChangeNotification
                             object:self.moviePlayer];
    
    // 完成
    [notificationCenter addObserver:self
                           selector:@selector(mediaPlayerPlaybackFinished:)
                               name:MPMoviePlayerPlaybackDidFinishNotification
                             object:self.moviePlayer];
    
    [notificationCenter addObserver:self
                           selector:@selector(MoviePlayerWillExitFullscreen:)
                               name:MPMoviePlayerWillExitFullscreenNotification
                             object:self.moviePlayer];
    
    [notificationCenter addObserver:self
                           selector:@selector(MoviePlayerLoadStateDidChange)
                               name:MPMoviePlayerLoadStateDidChangeNotification
                             object:self.moviePlayer];
    
    [notificationCenter addObserver:self
                           selector:@selector(MoviePlayerReadyForDisplayDidChange)
                               name:MPMoviePlayerReadyForDisplayDidChangeNotification
                             object:self.moviePlayer];
}

- (void)SVProgressHUDDidReceiveTouchEventNotification:(id)sender {
    [self MoviePlayerWillExitFullscreen:nil];
}

- (void)MoviePlayerReadyForDisplayDidChange {
    if (self.moviePlayer.readyForDisplay) {
        [self.view removeGestureRecognizer:self.tap];
    }
}

- (void)MoviePlayerLoadStateDidChange {
    switch (self.moviePlayer.loadState) {
        case MPMovieLoadStateUnknown: {
            break;
        }
        case MPMovieLoadStatePlayable: {
            break;
        }
        case MPMovieLoadStatePlaythroughOK: {
            break;
        }
        case MPMovieLoadStateStalled: {
            break;
        }
    }
}

// 播放器退出全屏
- (void)MoviePlayerWillExitFullscreen:(NSNotification *)notification {
    [self.moviePlayer stop];
    
    if (self.navigationController.viewControllers.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// 播放状态改变，注意播放完成时的状态是暂停
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放. %lf",self.moviePlayer.playableDuration);
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",(long)self.moviePlayer.playbackState);
            break;
    }
}

// 播放完成
- (void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",(long)self.moviePlayer.playbackState);
    [self MoviePlayerWillExitFullscreen:notification];
}

// 进入全屏
- (void)enterFullScreen:(id)sender {
    NSLog(@"tapped");
}

// *********************************************************************************************************************
#pragma mark - Getters/setters
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        _moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:url];
        _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.shouldAutoplay = YES;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}
@end
