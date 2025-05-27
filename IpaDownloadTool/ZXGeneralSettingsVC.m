#import "ZXGeneralSettingsVC.h"

@interface ZXGeneralSettingsVC ()
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionItems;
@property (nonatomic, strong) UISwitch *sendButtonStyleSwitch;
@end

@implementation ZXGeneralSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用";
    self.sectionTitles = @[@"界面与显示", @"聊天", @"聊天记录", @"其他"];
    self.sectionItems = @[
        @[@"深色模式", @"字体大小", @"多语言", @"翻译"],
        @[@"聊天背景", @"我的表情", @"照片、视频、文件与通话", @"使用听筒播放语音消息", @"使用独立的发送按钮"],
        @[@"聊天记录迁移与备份", @"清空全部聊天记录"], 
        @[@"存储空间"]
    ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionItems[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 为发送按钮样式开关的cell设置更高的高度以容纳提示文本
    if (indexPath.section == 1 && indexPath.row == 4) {
        return 60.0; // 增加高度以容纳提示文本
    }
    return 44.0; // 默认高度
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.sectionItems[indexPath.section][indexPath.row];
    
    // 深色模式单元格特殊处理
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *systemLabel = [[UILabel alloc] init];
        systemLabel.text = @"跟随系统";
        systemLabel.textColor = [UIColor grayColor];
        systemLabel.font = [UIFont systemFontOfSize:14];
        [systemLabel sizeToFit];
        cell.accessoryView = systemLabel;
    }
    // 听筒播放开关
    else if (indexPath.section == 1 && indexPath.row == 3) {
        UISwitch *switchView = [[UISwitch alloc] init];
        [switchView setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"useEarphoneMode"]];
        [switchView addTarget:self action:@selector(earphoneSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchView;
    }
    // 发送按钮样式开关
    else if (indexPath.section == 1 && indexPath.row == 4) {
        self.sendButtonStyleSwitch = [[UISwitch alloc] init];
        [self.sendButtonStyleSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"useNewSendButtonStyle"]];
        [self.sendButtonStyleSwitch addTarget:self action:@selector(sendButtonStyleChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = self.sendButtonStyleSwitch;
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, tableView.frame.size.width-30, 15)];
        hintLabel.text = @"开启后键盘发送按钮将替换为换行";
        hintLabel.textColor = [UIColor grayColor];
        hintLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:hintLabel];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - Switch Action
- (void)earphoneSwitchChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"useEarphoneMode"];
}

- (void)sendButtonStyleChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"useNewSendButtonStyle"];
    [self.tableView reloadData];
}

@end
