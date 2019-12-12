//
//  ReportHelpCell.h
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/5/23.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReportHelpModel.h"

@interface ReportHelpCell : UITableViewCell

@property (nonatomic,strong) ReportHelpModel * reportHelpModel;

- (CGFloat)bindingDataWithReportHelpModel:(ReportHelpModel *)reportHelpModel;
@end

