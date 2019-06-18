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

CHDeclareClass(BBPlayerCastFinder);
CHOptimizedClassMethod0(self, id, BBPlayerCastFinder, sharedFinder)
{
    static dispatch_once_t once;
    BBPlayerCastFinder *obj = (BBPlayerCastFinder *)CHSuper0(BBPlayerCastFinder, sharedFinder);
    dispatch_once(&once, ^{
        NSLog(@"Patch screen cast switches");
        [obj setShowBiliCast: true];
        [obj setSupportCast: true];
        [obj setShowDanmakuWhenBiliCast: true];
    });
    return obj;
}

CHDeclareClass(BBPegasusCardPool);
CHOptimizedClassMethod0(self, NSDictionary *, BBPegasusCardPool, allModelClassDict)
{
    NSDictionary *obj = (NSDictionary *)CHSuper0(BBPegasusCardPool, allModelClassDict);
    NSMutableDictionary *mutObj = [obj mutableCopy];
    [mutObj removeObjectForKey:@"cm_v2"];
    obj = [NSDictionary dictionaryWithDictionary:mutObj];
    return obj;
}

CHDeclareClass(BFCTeenagersEntranceAlertView);
CHOptimizedClassMethod0(self, BOOL, BFCTeenagersEntranceAlertView, isNeedShowTeenagersAlert)
{
    return FALSE;
}

CHConstructor
{
    @autoreleasepool {
        NSLog(@"Injecting to bili-universal and enable screen cast always");
        CHLoadLateClass(BBPlayerCastFinder);
        CHLoadLateClass(BBPegasusCardPool);
        CHLoadLateClass(BFCTeenagersEntranceAlertView);
        
        CHHook0(BBPlayerCastFinder, sharedFinder);
        CHHook0(BBPegasusCardPool, allModelClassDict);
        CHHook0(BFCTeenagersEntranceAlertView, isNeedShowTeenagersAlert);
    }
}

