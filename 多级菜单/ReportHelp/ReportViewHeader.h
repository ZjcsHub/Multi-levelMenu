//
//  ReportViewHeader.h
//  Osport_Plus
//
//  Created by App005 SYNERGY on 2019/5/23.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportHelpModel.h"
@class ReportViewHeader;
@protocol ReportViewHeaderDelegate <NSObject>

- (void)groupHeader:(ReportViewHeader *)header group:(ReportHelpModel *)reportModel;

@end

@interface ReportViewHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) ReportHelpModel * reportModel;
@property (nonatomic, weak) id<ReportViewHeaderDelegate> delegate;

@end

