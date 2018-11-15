//
//  bilibili_universal_cast_always.mm
//  bilibili-universal-cast-always
//
//  Created by realityone on 2018/11/15.
//  Copyright (c) 2018 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
//
//#ifdef DEBUG
//#import "Cycript/Cycript.h"
//#define CYCRIPT_PORT 8888
//CHDeclareClass(UIApplication);
//CHDeclareClass(BFCApplicationDelegate);
//CHOptimizedMethod2(self, void, BFCApplicationDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options)
//{
//    CHSuper2(BFCApplicationDelegate, application, application, didFinishLaunchingWithOptions, options);
//
//    NSLog(@"Starting Cycript");
//    CYListenServer(CYCRIPT_PORT);
//}
//CHConstructor
//{
//    @autoreleasepool {
//        NSLog(@"Starting Cycript server");
//        CHLoadLateClass(BFCApplicationDelegate);
//        CHLoadLateClass(UIApplication);
//        CHHook2(BFCApplicationDelegate, application, didFinishLaunchingWithOptions);
//    }
//}
//#endif

CHDeclareClass(BBPlayerCastHelper);
CHOptimizedClassMethod0(self, id, BBPlayerCastHelper, sharedHelper)
{
    static dispatch_once_t once;
    BBPlayerCastHelper *obj = (BBPlayerCastHelper *)CHSuper0(BBPlayerCastHelper, sharedHelper);
    dispatch_once(&once, ^{
        NSLog(@"Patch screen cast switches");
        [obj setShowBiliCast: true];
        [obj setSupportCast: true];
        [obj setShowDanmakuWhenBiliCast: true];
    });
    return obj;
}
CHConstructor
{
    @autoreleasepool {
        NSLog(@"Injecting to bili-universal and enable screen cast always");
        CHLoadLateClass(BBPlayerCastHelper);
        CHHook0(BBPlayerCastHelper, sharedHelper);
    }
}

