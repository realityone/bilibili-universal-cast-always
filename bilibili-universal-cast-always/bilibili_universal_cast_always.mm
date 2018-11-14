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

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()


@interface bilibili_universal_cast_always : NSObject

@end

@implementation bilibili_universal_cast_always

-(id)init
{
	if ((self = [super init]))
	{
	}

    return self;
}

@end

CHDeclareClass(BBPlayerCastHelper);
CHDeclareClass(BBPlayerCustomComponnetPreferences);

CHPropertyGetter(BBPlayerCastHelper, showBiliCast, bool)
{
    return true;
}

CHPropertyGetter(BBPlayerCastHelper, supportCast, bool)
{
    return true;
}

CHPropertyGetter(BBPlayerCastHelper, showDanmakuWhenBiliCast, bool)
{
    return true;
}

CHPropertyGetter(BBPlayerCustomComponnetPreferences, screenCastAvailable, bool)
{
    return true;
}

CHConstructor // code block that runs immediately upon load
{
	@autoreleasepool
	{
        NSLog(@"Injecting to bili-universal and enable screen cast always");

        CHLoadLateClass(BBPlayerCastHelper);
        CHLoadLateClass(BBPlayerCustomComponnetPreferences);
        
        CHHook(0, BBPlayerCastHelper, showBiliCast);
        CHHook(0, BBPlayerCastHelper, supportCast);
        CHHook(0, BBPlayerCastHelper, showDanmakuWhenBiliCast);

        CHHook(0, BBPlayerCustomComponnetPreferences, screenCastAvailable);
    }
}
