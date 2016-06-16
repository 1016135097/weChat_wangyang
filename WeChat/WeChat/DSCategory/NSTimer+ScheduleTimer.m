//
//  NSTimer+ScheduleTimer.m
//  test1
//
//  Created by wangyang on 16/3/21.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "NSTimer+ScheduleTimer.h"

@implementation NSTimer (ScheduleTimer)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void (^)())block
                                    repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer
{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
