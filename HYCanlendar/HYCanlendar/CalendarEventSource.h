//
//  CalendarEventSource.h
//  Calendar
//
//  Created by Mac on 16/5/24.
//  Copyright © 2016年 Mac. All rights reserved.
//  点击有事件日期。。。

#import <Foundation/Foundation.h>
@class CalendarManager;

@protocol CalendarEventSource <NSObject>

/**
 该日期是否有事件
 @param date  NSDate
 @return BOOL
 */
@optional
- (BOOL)calendarHaveEventWithDate:(NSDate *)date;
- (UIColor *)calendarHaveEventDotColorWithDate:(NSDate *)date;

/**
 点击 日期后的执行的操作
 @param date 选中的日期
 */
- (void)calendarDidSelectedDate:(NSDate *)date;


/**
 翻页完成后的操作

 */
- (void)calendarDidLoadPageCurrentDate:(NSDate *)date;

@end
