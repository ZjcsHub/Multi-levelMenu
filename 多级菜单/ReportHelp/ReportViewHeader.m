//
//  ReportViewHeader.m
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/5/23.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import "ReportViewHeader.h"

@interface ReportViewHeader ()

@property (nonatomic, strong) UIButton * button;
@end


@implementation ReportViewHeader
- (UIButton *)button {
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _button.backgroundColor = [UIColor systemBackgroundColor];
        
        //水平向左对齐
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        _button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _button.adjustsImageWhenHighlighted = NO;
    }
    return _button;
}
- (void)clickButton:(UIButton *)button {
    
    _reportModel.isOpen = !_reportModel.isOpen;
    
    if ([self.delegate respondsToSelector:@selector(groupHeader:group:)]) {
        [self.delegate groupHeader:self group:self.reportModel];
    }
}
- (void)setReportModel:(ReportHelpModel *)reportModel{
    _reportModel = reportModel;
    [self.button setTitle:reportModel.titleName forState:UIControlStateNormal];

}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.button];
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
}
@end
