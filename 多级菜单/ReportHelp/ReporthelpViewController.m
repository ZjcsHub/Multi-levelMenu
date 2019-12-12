//
//  ReporthelpViewController.m
//  Osport_Plus
//
//  Created by app002synergy on 2019/5/23.
//  Copyright © 2019 app002synergy. All rights reserved.
//

#import "ReporthelpViewController.h"
#import "ReportHelpCell.h"
#import "ReportViewHeader.h"
#import "ReportHelpModel.h"
@interface ReporthelpViewController ()<UITableViewDelegate,UITableViewDataSource,ReportViewHeaderDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataList;
@property (nonatomic, strong) NSMutableDictionary * cellHeightDict;

@end

@implementation ReporthelpViewController
- (NSMutableDictionary *)cellHeightDict {
    
    if (!_cellHeightDict) {
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ReportHelpCell class] forCellReuseIdentifier:NSStringFromClass([ReportHelpCell class])];
        [_tableView registerClass:[ReportViewHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ReportViewHeader class])];
        self.tableView.estimatedRowHeight = 100;
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self initWithUI];
    
    // Do any additional setup after loading the view.
}
- (void)initData{
    
    ReportHelpModel * model1 = [[ReportHelpModel alloc] init];
    model1.titleName = NSLocalizedString(@"hrv_help_title1", nil);
    model1.contents = [NSString stringWithFormat:@"%@\n0-70:%@\n70-90:%@\n90-100:%@",NSLocalizedString(@"hrv_help_health_text", nil),NSLocalizedString(@"general_level", nil),NSLocalizedString(@"good_level", nil),NSLocalizedString(@"optimal_level", nil)];
    
    ReportHelpModel * model2 = [[ReportHelpModel alloc] init];
    model2.titleName = NSLocalizedString(@"hrv_help_fatigue_title", nil);
    model2.contents = [NSString stringWithFormat:@"%@\n0-45:%@\n45-70:%@\n70-100:%@",NSLocalizedString(@"hrv_help_fatigue_text", nil),NSLocalizedString(@"general_level", nil),NSLocalizedString(@"good_level", nil),NSLocalizedString(@"optimal_level", nil)];
    
    ReportHelpModel * model3 = [[ReportHelpModel alloc] init];
    model3.titleName = NSLocalizedString(@"hrv_help_load_title", nil);
    model3.contents = [NSString stringWithFormat:@"%@\n0-55:%@\n55-80:%@\n80-100:%@",NSLocalizedString(@"hrv_help_load_text", nil),NSLocalizedString(@"general_level", nil),NSLocalizedString(@"good_level", nil),NSLocalizedString(@"optimal_level", nil)];
    ReportHelpModel * model4 = [[ReportHelpModel alloc] init];
    model4.titleName = NSLocalizedString(@"hrv_help_quality_title", nil);
    model4.contents = [NSString stringWithFormat:@"%@\n40-70:%@\n70-90:%@\n90-100:%@",NSLocalizedString(@"hrv_help_quality_text", nil),NSLocalizedString(@"general_level", nil),NSLocalizedString(@"good_level", nil),NSLocalizedString(@"optimal_level", nil)];
    ReportHelpModel * model5 = [[ReportHelpModel alloc] init];
    model5.titleName = NSLocalizedString(@"hrv_help_heart_title", nil);
    model5.contents = [NSString stringWithFormat:@"%@\n40-70:%@\n70-90:%@\n90-100:%@",NSLocalizedString(@"hrv_help_heart_text", nil),NSLocalizedString(@"general_level", nil),NSLocalizedString(@"good_level", nil),NSLocalizedString(@"optimal_level", nil)];
    
    self.dataList = [@[model1,model2,model3,model4,model5] mutableCopy];
}
-(void)initWithUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlebar.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportHelpCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReportHelpCell class]) forIndexPath:indexPath];
    ReportHelpModel * model = self.dataList[indexPath.section];
    CGFloat height = [cell bindingDataWithReportHelpModel:model];
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @(height);
    }
//    cell.reportHelpModel = model;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportHelpModel * model = self.dataList[indexPath.section];

    if (model.isOpen) {
        
        if (self.cellHeightDict[indexPath]) {
            return [self.cellHeightDict[indexPath] doubleValue];
        }else{
            ReportHelpCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            CGFloat height = [cell bindingDataWithReportHelpModel:model];
            self.cellHeightDict[indexPath] = @(height);
            return height;
        }
        
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //从复用池里取GroupHeader
    ReportViewHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ReportViewHeader class])];
    
    header.reportModel = self.dataList[section];
    
    header.delegate = self;
    
    return header;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (void)groupHeader:(ReportViewHeader *)header group:(ReportHelpModel *)reportModel{
    NSUInteger index = [self.dataList indexOfObject:reportModel];
    //刷新Section操作
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
