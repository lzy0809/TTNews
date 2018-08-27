//
//  TTCommonDefines.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#ifndef TTCommonDefines_h
#define TTCommonDefines_h

#define ScreenHeigth                      ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth                       ([UIScreen mainScreen].bounds.size.width)
#define IS_iPhoneX                        ScreenWidth == 812 || ScreenHeigth == 812

#define StatusBarH                        (IS_iPhoneX ? MIN(44, [UIApplication sharedApplication].statusBarFrame.size.height) : MIN(20, [UIApplication sharedApplication].statusBarFrame.size.height))
#define NavigationBarH                   (StatusBarH + 44)

#define TTWeakSelf                          __weak typeof(self)weakSelf = self;

#endif /* TTCommonDefines_h */
