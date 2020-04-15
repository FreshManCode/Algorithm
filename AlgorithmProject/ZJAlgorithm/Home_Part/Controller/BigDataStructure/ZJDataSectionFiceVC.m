//
//  ZJDataSectionFiceVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/15.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDataSectionFiceVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

@interface ZJDataSectionFiceVC ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJDataSectionFiceVC

@dynamic dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

// MARK: - 5.1 串的定义相关
- (void)p_definetionOfString {
    /* 串:(string) 是由零个或多个字符组成的有限序列,又叫字符串.
     
     子串与主串:串中任意个数的连续字符组成的子序列称为该串的子串,相应地,包含子串的串称为主串.
     子串在主串中的位置就是子串的第一个字符在主串中的序号.
     */
    /* 5.3 串的比较
     事实上,串的比较是通过组成串的字符之间的编码来进行的,而字符的编码指的是字符在对应字符集中的符号.
     
     计算机中的常用字符是使用标准的ASCII编码,更准确一点是由7位二进制数字表示一个字符,总共可以表示128个字符.
     后来由于一些特殊符号出现,128个不够用,于是扩展ASCII吗由8位二进制数表示一个字符,总共可以表示256个字符,
     这已经足够满足以英语为主的语言和特殊符号进行输入,存储,输出等操作的字符需要了.
     
     但是全世界估计有成百上千中语言与文字,显然这256个字符是不够的,因此后来就有了Unicode编码,比较常用的是有16位
     的二进制数表示一个字符,这样总共可以表示2^16,约是6.5多个字符.足够表示世界上所有语言的所有字符了.当然,
     为了和ASCII码兼容,Unicode的前256个字符与ASCII码完全相同.
     */
}

// MARK: - 5.4 串的抽象数据类型
- (void)p_abstractDataTypeOfString {
    /*StrCompare(S,T) 若S>T,返回值>0,若S=T,返回0,若S<T,返回值<0.
     Replace(S,T,V):若S,T和V存在,T是非空串.用V替换主串S中出现的所有与T相等的不重叠的子串.
     */
    /*字符串中有几个算法:
     1.朴素的模式匹配算法
     2.KMP模式匹配算法:大大避免重复遍历情况;
     */
    
    /*总结:
     1.本章重点讲了"串"这样的数据结构,(string)是由零个或者多个字符组成的有限序列,又名叫字符串.
     本质上,它是一种线性表的扩展,但相对于线性表关注一个个元素来说,我们对串这种结构更多的是关注它子串的应用问题.
     */
}


// MARK: - UI Config----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath {
    ZJDesignCell *cell = (ZJDesignCell *)currentCell;
    ZJRowImageModel *model = self.dataArray[indexPath.row];
    [cell setText:model.text];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJRowImageModel *model = self.dataArray[indexPath.row];
    if (model.imageURL.length > 0) {
        [self showExplainImage:model.imageURL];
    }
    if (model.functionName.length > 0) {
        SEL selector = NSSelectorFromString(model.functionName);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector];
        }
    }
}


- (void)configureUI {
    [self zj_registerSingleTableViewCell:[ZJDesignCell class] cellID:kDesignCellID];
    [self.dataArray addObjectsFromArray:[self rowsModel]];
    [self.tableView reloadData];
}
- (NSArray <ZJRowImageModel *> *)rowsModel {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < 1; i ++) {
        ZJRowImageModel *model = [ZJRowImageModel new];
        if (i == 0) {
            [model setText:@"5 串的定义相关"
                  imageURL:nil
              functionName:@"p_definetionOfString"];
        }
        else if (i == 1) {
            [model setText:@"5.4  串的抽象数据类型"
                  imageURL:nil
              functionName:@"p_abstractDataTypeOfString"];
        }
        else if (i == 2) {
            [model setText:@"4.13.1 链队的入队操作"
                  imageURL:nil
              functionName:@"p_enterOfLineQueue"];
        }
        else if (i == 3) {
            [model setText:@"4.13.2 链队的出队操作"
                  imageURL:nil
              functionName:@"p_outOfLineQueue"];
        }
        else if (i == 4) {
            [model setText:@"4.14 队列的总结"
                  imageURL:nil
              functionName:@"p_summaryOfQueue"];
        }
        else if (i == 5) {
            [model setText:@"3.14 双向链表"
                  imageURL:nil
              functionName:@"p_doubleCycleLineChart"];
        }
        else if (i == 6) {
            [model setText:@"3.14.1 双向链表的插入"
                  imageURL:nil
              functionName:@"p_doubleCycleLineChartInsert"];
        }
        else if (i == 7) {
            [model setText:@"3.14.2 双向链表的删除"
                  imageURL:nil
              functionName:@"p_doubleCycleLineChartDelete"];
        }
        else if (i == 8) {
            [model setText:@"3.15 总结"
                  imageURL:nil
              functionName:@"p_summary"];
        }
        
        [tempArray addObject:model];
    }
    return tempArray;
}


@end
