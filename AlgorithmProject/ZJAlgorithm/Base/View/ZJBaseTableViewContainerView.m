//
//  ZJBaseTableViewContainerView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewContainerView.h"
#import <Masonry.h>

@interface ZJBaseTableViewContainerView ()
@property (nonatomic, strong) UIView *containerView;

/**是否在展示中*/
@property (nonatomic, assign,getter=isShowing) BOOL show;


@end

@implementation ZJBaseTableViewContainerView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.animateDuration = 0.4;
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
        [self addSubview:self.containerView];
        [self zj_registerTableViewCell:self.tableView];
        [self.containerView addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    [self.tableView reloadData];
    if (self.isShowing) {
        return;
    }
    [self setShow:true];
    [view addSubview:self];
    [UIView animateWithDuration:self.animateDuration
                     animations:^{
                         CGRect frame      = self.containerView.frame;
                         frame.origin.y    = 0;
                         self.containerView.frame = frame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)dismissView {
    [self dismissView:nil];
    
}

- (void)dismissView:(void(^)(void))complete {
    [UIView animateWithDuration:self.animateDuration
                     animations:^{
                         CGRect frame   = self.containerView.frame;
                         frame.origin.y = -self.frame.size.height;
                         self.containerView.frame = frame;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self setShow:false];
                         if ([self.delegate respondsToSelector:@selector(tableContainerViewDidDissmiss:)]) {
                             [self.delegate tableContainerViewDidDissmiss:self];
                         }
                         !complete ? : complete ();
                     }];
}

- (void)notiSelectedIndex:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(tableContainerView:didClickIndex:)]) {
        [_delegate tableContainerView:self didClickIndex:index];
    }
}

- (void)zj_registerTableViewCell:(UITableView *)tableView {
    
}

- (UITableViewCell *)zj_tableView:(UITableView *)tableView
          cellForRowWithIentifier:(NSString *)identifier
                        indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [self zj_tableView:tableView configureCell:cell indexPath:indexPath];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"子类要重写该方法");
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissView];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [UIView new];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (NSMutableArray *)listsArray{
    if(!_listsArray){
        _listsArray = [NSMutableArray new];
    }
    return _listsArray;
}



@end
