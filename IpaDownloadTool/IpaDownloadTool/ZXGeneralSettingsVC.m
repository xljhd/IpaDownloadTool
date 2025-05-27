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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.sectionItems[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end