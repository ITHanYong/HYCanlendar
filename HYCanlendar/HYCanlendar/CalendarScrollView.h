//
//  CalendarScrollView.h
//  Calendar
//
//  Created by Mac on 2018/1/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarContentView.h"
#import "CalendarWeekDayView.h"
@interface CalendarScrollView : UIScrollView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)CalendarContentView *calendarView;

@property (nonatomic,strong)UIColor *bgColor;
- (void)scrollToSingleWeek;

- (void)scrollToAllWeek;
@end
