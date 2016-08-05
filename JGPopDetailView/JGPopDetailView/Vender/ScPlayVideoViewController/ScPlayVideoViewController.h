//
//  ScPlayVideoViewController.h
//  senior-care
//
//  Created by Ji Fu on 4/20/16.
//  Copyright © 2016 FriendMedia. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>


@interface ScPlayVideoViewController : UIViewController

// *********************************************************************************************************************
#pragma mark - Property
@property (strong, nonatomic) NSString *urlStr;
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;              //视频播放控制器

@end
