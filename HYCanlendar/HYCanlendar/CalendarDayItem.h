//
//  CalendarDayItem.h
//  Calendar
//
//  Created by Mac on 2018/1/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface CalendarDayItem : NSObject
@property (nonatomic,strong)NSDate *date;
@property (nonatomic,assign)BOOL isOtherMonth;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,strong)UIColor *eventDotColor;
@property (nonatomic,assign)BOOL showEventDot;
@end
