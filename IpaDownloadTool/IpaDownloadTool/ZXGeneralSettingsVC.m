#import "ZXGeneralSettingsVC.h"

@interface ZXGeneralSettingsVC ()
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionItems;
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
    // 不需要注册，我们将在cellForRowAtIndexPath中创建不同样式的cell
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // 深色模式单元格特殊处理 - 使用Value1样式显示详细信息
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.textLabel.text = self.sectionItems[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = @"跟随系统";
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } 
    // 听筒播放开关
    else if (indexPath.section == 1 && indexPath.row == 3) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = self.sectionItems[indexPath.section][indexPath.row];
        UISwitch *switchView = [[UISwitch alloc] init];
        [switchView setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"useEarphoneMode"]];
        [switchView addTarget:self action:@selector(earphoneSwitchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = switchView;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = self.sectionItems[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - Switch Action
- (void)earphoneSwitchChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:@"useEarphoneMode"];
}

@end