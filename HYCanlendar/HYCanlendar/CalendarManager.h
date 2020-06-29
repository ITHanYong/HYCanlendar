//
//  CalendarManager.h
//  Calendar
//
//  Created by Mac on 2018/1/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarScrollView.h"
#import "CalendarEventSource.h"
@interface CalendarManager : NSObject
@property (nonatomic,strong)CalendarScrollView *calenderScrollView;

@property (nonatomic,strong) CalendarWeekDayView *weekDayView;

@property (weak, nonatomic) id<CalendarEventSource> eventSource;

@property (nonatomic,strong , readonly) NSDate *currentSelectedDate;


///回到今天
- (void)goBackToday;

/// 重新加载外观
- (void)reloadAppearanceAndData;

///  前一页。上个月
- (void)loadPreviousPage;

///   下一页 下一个月
- (void)loadNextPage;

//单周
- (void)showSingleWeek;

- (void)showAllWeek;
@end
