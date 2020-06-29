//
//  ViewController.m
//  HYCanlendar
//
//  Created by HanYong on 2020/6/29.
//  Copyright © 2020 HanYong. All rights reserved.
//

#import "ViewController.h"
#import "CalendarManager.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

//颜色
#define UIColorFromRGB(rgbValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<CalendarEventSource,UINavigationControllerDelegate>{
    NSMutableDictionary *eventsByDate;
}
@property (nonatomic,strong)CalendarManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [CalendarManager new];
    self.manager.eventSource = self;
    self.manager.weekDayView = [[CalendarWeekDayView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30)];
    [self.view addSubview:self.manager.weekDayView];
    
    self.manager.calenderScrollView = [[CalendarScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manager.weekDayView.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.manager.weekDayView.frame))];
    [self.view addSubview:self.manager.calenderScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self createRandomEvents];
    [self addButton];
    
    [self changeColor];
}

#pragma mark - 添加事件源
- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];

    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];

        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];

        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }

        [eventsByDate[key] addObject:randomDate];
    }
    [self.manager reloadAppearanceAndData];
}


// 该日期是否有事件
- (BOOL)calendarHaveEventWithDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    return NO;
}
//当前 选中的日期  执行的方法
- (void)calendarDidSelectedDate:(NSDate *)date {
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    //self.label.text =  key;
    NSArray *events = eventsByDate[key];
   self.title = key;
    NSLog(@"%@",date);
    if (events.count>0) {
        
        //该日期有事件    tableView 加载数据
    }
}

-(void)addButton{
    
    NSArray *row1 = @[@"回到今天",@"显示农历",@"改变颜色"];
    for (NSInteger i = 0; i<row1.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:row1[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(self.view.frame.size.width/3*i, 40, self.view.frame.size.width/3, 25);
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn addTarget:self action:@selector(goBackToday) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [btn addTarget:self action:@selector(isShowLunar) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    NSArray *row2 = @[@"上个月",@"下个月",@"星期一开始"];
    for (NSInteger i = 0; i<row2.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:row2[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(self.view.frame.size.width/3*i, 40+25, self.view.frame.size.width/3, 25);
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn addTarget:self action:@selector(previousMonth) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [btn addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(monday) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    NSArray *row3 = @[@"singleweek",@"allweek",@"星期日开始"];
    for (NSInteger i = 0; i<row3.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:row3[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(self.view.frame.size.width/3*i, 40+25+25, self.view.frame.size.width/3, 25);
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn addTarget:self action:@selector(singleweek) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [btn addTarget:self action:@selector(allweek) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(sunday) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    NSArray *row4 = @[@"星期一",@"周一",@"一"];
    for (NSInteger i = 0; i<row4.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:row4[i] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(self.view.frame.size.width/3*i, 40+25+25+25, self.view.frame.size.width/3, 25);
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn addTarget:self action:@selector(full) forControlEvents:UIControlEventTouchUpInside];
        }else if (i == 1){
            [btn addTarget:self action:@selector(fullShort) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(single) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark -- 回到今天
-(void)goBackToday{
    
    [self.manager goBackToday];
}

#pragma mark -- 显示农历
- (void)isShowLunar{
    [CalendarAppearance share].isShowLunarCalender = ![CalendarAppearance share].isShowLunarCalender;
   //重新加载外观
    [self.manager reloadAppearanceAndData];
}

#pragma mark -- 改变颜色
- (void)changeColor {
    //日历背景颜色
    //[CalendarAppearance share].calendarBgColor = RandColor;
    //周视图背景颜色
    //[CalendarAppearance share].weekDayBgColor = RandColor;
    //日期选中颜色
    [CalendarAppearance share].dayCircleColorSelected = UIColorFromRGB(0xFF8A0D);
    //今天颜色
    [CalendarAppearance share].dayCircleColorToday = UIColorFromRGB(0xFF8A0D);
    //圈圈颜色
    [CalendarAppearance share].dayBorderColorToday = UIColorFromRGB(0xFF8A0D);
    //圆点颜色
    [CalendarAppearance share].dayDotColor = UIColorFromRGB(0xFF8A0D);
    [CalendarAppearance share].dayDotColorSelected = [UIColor whiteColor];
    
    //农历字体
    [CalendarAppearance share].lunarDayTextColor = UIColorFromRGB(0x7E7E7E);
    [CalendarAppearance share].lunarDayTextFont = [UIFont systemFontOfSize:9];
    
    //阳历字体
    [CalendarAppearance share].dayTextFont = [UIFont systemFontOfSize:16];
    [CalendarAppearance share].dayTextColor = UIColorFromRGB(0x1E1E1E);
    
    //周视图
    [CalendarAppearance share].weekDayTextColor = UIColorFromRGB(0x7E7E7E);
    [CalendarAppearance share].weekDayTextFont = [UIFont systemFontOfSize:13];
    
    [CalendarAppearance share].dayCircleSize = self.view.frame.size.width/7-10;
    
    [self.manager reloadAppearanceAndData];
}

#pragma mark -- 上个月
- (void)previousMonth {
    [self.manager loadPreviousPage];
}

#pragma mark -- 下个月
- (void)nextMonth {
    [self.manager loadNextPage];
}

#pragma mark -- 从周一开始
- (void)monday {
    [CalendarAppearance share].firstWeekday = 2;
    [self.manager reloadAppearanceAndData];
}

#pragma mark -- 从周日开始
- (void)sunday {
    [CalendarAppearance share].firstWeekday = 1;

    [self.manager reloadAppearanceAndData];
}

#pragma mark -- 星期几
- (void)full {
    [CalendarAppearance share].weekDayFormat = CalendarWeekDayFormatFull;
    [self.manager.weekDayView reloadAppearance];
}

#pragma mark -- 周几
- (void)fullShort {
    [CalendarAppearance share].weekDayFormat = CalendarWeekDayFormatShort;
    [self.manager.weekDayView reloadAppearance];
}

#pragma mark - 几
- (void)single {
    [CalendarAppearance share].weekDayFormat = CalendarWeekDayFormatSingle;
    [self.manager.weekDayView reloadAppearance];
}

#pragma mark -- singleweek
- (void)singleweek{
    [self.manager showSingleWeek];
}

#pragma mark -- allweek
- (void)allweek{
    [self.manager showAllWeek];
}


- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy.MM.dd";
    }
    
    return dateFormatter;
}

@end
