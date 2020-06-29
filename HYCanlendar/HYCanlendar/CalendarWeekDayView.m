//
//  CalendarWeekDayView.m
//  scrollTest
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "CalendarWeekDayView.h"
#import "CalendarAppearance.h"

@implementation CalendarWeekDayView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
   [self commonInit];
    
    return self;
}


- (void)commonInit{
    //周日 - 周六
    for(NSString *day in [self daysOfWeek]){
        UILabel *view = [UILabel new];
        view.font = [CalendarAppearance share].weekDayTextFont;
        view.textColor = [CalendarAppearance share].weekDayTextColor;
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        [self addSubview:view];
    }
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *days = nil;
    
    switch([CalendarAppearance share].weekDayFormat) {
        case CalendarWeekDayFormatSingle:
            days = [[dateFormatter veryShortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case CalendarWeekDayFormatShort:
            days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
            break;
        case CalendarWeekDayFormatFull:
            days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
            break;
    }
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
    }
    
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = [CalendarAppearance share].calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
        
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)layoutSubviews
{
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
   
        for(UIView *view in self.subviews){
            view.frame = CGRectMake(x, 0, width, height);
            x = CGRectGetMaxX(view.frame);
        }
    
    
    // No need to call [super layoutSubviews]
}

+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

- (void)reloadAppearance
{
    for (UIView *view in self.subviews ) {
        [view removeFromSuperview];
        cacheDaysOfWeeks = nil;
        
    }
    [self commonInit];
    self.backgroundColor = [CalendarAppearance share].weekDayBgColor;
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        
        view.font = [CalendarAppearance share].weekDayTextFont;
        view.textColor = [CalendarAppearance share].weekDayTextColor;
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}

@end
