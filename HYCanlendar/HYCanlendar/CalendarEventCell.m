//
//  CalendarEventCell.m
//  HYCanlendar
//
//  Created by HanYong on 2020/3/23.
//

#import "CalendarEventCell.h"

@interface CalendarEventCell ()

@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation CalendarEventCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"HYCalendarEventCell";
    CalendarEventCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CalendarEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUp];
    }
    return self;
}

-(void)setUp{
    [self.testLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    //layout 子view
    //子view的上边缘离父view的上边缘40个像素
    NSLayoutConstraint *contraintTop = [NSLayoutConstraint constraintWithItem:self.testLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0];
    //子view的左边缘离父view的左边缘40个像素
    NSLayoutConstraint *contraintLeft = [NSLayoutConstraint constraintWithItem:self.testLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:16.0];
    //子view的下边缘离父view的下边缘40个像素
    NSLayoutConstraint *contraintBottom = [NSLayoutConstraint constraintWithItem:self.testLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.0];
    //子view的右边缘离父view的右边缘40个像素
    NSLayoutConstraint *contraintRight = [NSLayoutConstraint constraintWithItem:self.testLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-16.0];
    //把约束添加到父视图上
    NSArray *contraints = [NSArray arrayWithObjects:contraintTop,contraintLeft,contraintBottom,contraintRight, nil];
    [self.contentView addConstraints:contraints];
}

-(void)setContent:(NSString *)content{
    _content = content;
    self.testLabel.text = content;
}

-(UILabel *)testLabel{
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.numberOfLines = 0;
        _testLabel.font = [UIFont systemFontOfSize:15];
        _testLabel.textColor = [UIColor blackColor];
        _testLabel.text = @"列夫托尔斯泰";
        [self.contentView addSubview:_testLabel];
    }
    return _testLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
