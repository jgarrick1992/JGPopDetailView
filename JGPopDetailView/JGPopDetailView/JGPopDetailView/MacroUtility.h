//
//  MacroUtility.h
//  SmartRouter
//
//  Created by Ji Fu on 16/6/6.
//  Copyright © 2016 Ji Fu. All rights reserved.
//

#ifndef SmartRouter_MacroUtility_h
#define SmartRouter_MacroUtility_h

#define Weak(name) __weak __typeof(name) w##name = name

#define BOUNDS [[UIScreen mainScreen] bounds].size

#define kThemeColor 0x36bcc7
#define kStatusBarColor 0x30a4ad

#define kStatusBarHeight 20
#define kNavigationBarHeight 50
#define kTabBarHeight 48

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif