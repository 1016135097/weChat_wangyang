//
//  NSTimer+ScheduleTimer.h
//  test1
//
//  Created by wangyang on 16/3/21.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ScheduleTimer)

/**
 * interval   delay time after repeats
 * block      action once repeats
 * repeats    is repeats
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void (^)())block
                                    repeats:(BOOL)repeats;
@end

