//
//  HYCalendarEventCell.h
//  POD_HYCanlendar
//
//  Created by HanYong on 2020/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYCalendarEventCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
