//
//  CalendarCollectionCell.h
//  Calendar
//
//  Created by Mac on 2018/1/9.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDayItem.h"
@interface CalendarCollectionCell : UICollectionViewCell
@property (nonatomic,strong)CalendarDayItem *item;
@property (nonatomic,assign)BOOL isSelected;
@end
