//
//  ReportHelpCell.m
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/5/23.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import "ReportHelpCell.h"

@interface ReportHelpCell ()
@property (nonatomic,strong) UILabel * contentsLabel;

@property (nonatomic,strong) NSDictionary * attributeStringDict;
@end

static CGFloat padding = 10;
@implementation ReportHelpCell

- (NSDictionary *)attributeStringDict{
    if (!_attributeStringDict) {
        _attributeStringDict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    }
    return _attributeStringDict;
}

- (UILabel *)contentsLabel{
    if (!_contentsLabel) {
        _contentsLabel = [[UILabel alloc] init];
        _contentsLabel.numberOfLines = 0;
        _contentsLabel.font = [self.attributeStringDict objectForKey:NSFontAttributeName];
        _contentsLabel.textColor = [UIColor blackColor];
    }
    return _contentsLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentsLabel];
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
- (void)setReportHelpModel:(ReportHelpModel *)reportHelpModel{
    self.contentsLabel.text = reportHelpModel.contents;
}
- (CGFloat)bindingDataWithReportHelpModel:(ReportHelpModel *)reportHelpModel{
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT);
    CGSize size = [reportHelpModel.contents boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:self.attributeStringDict context:nil].size;
    CGFloat height = 0;
    if (reportHelpModel.isOpen) {
        height = size.height;
//        [UIView animateWithDuration:0.5 animations:^{
            self.contentsLabel.frame = CGRectMake(padding, padding, maxSize.width, height);
//        }];
    }else{
        height = 0;
        self.contentsLabel.frame = CGRectMake(padding, padding, maxSize.width, height);

    }
   
    _reportHelpModel = reportHelpModel;
    self.contentsLabel.text = reportHelpModel.contents;
   
    return size.height + padding*2;
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
