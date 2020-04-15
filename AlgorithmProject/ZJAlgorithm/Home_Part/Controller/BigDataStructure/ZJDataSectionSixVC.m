//
//  ZJDataSectionSixVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/15.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDataSectionSixVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

// MARK: - 双亲表示法的结点结构
/* 树的双亲表示法结点结构定义 */
#define MAX_TREE_SIZE 100
/* 树结点的数据类型，目前暂定为整型 */
typedef int TElemType;
//结点结构
typedef struct PTNode {
    //结点数据
    TElemType data;
    //双亲位置
    int parent;
}PTNode;

//树结构
typedef struct {
    //结点数组
    PTNode nodes[MAX_TREE_SIZE];
    //根的位置和结点数
    int r,n;
}PTree;


@interface ZJDataSectionSixVC ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJDataSectionSixVC

@dynamic dataArray;

static NSString * const kDefinetionOfTree = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/DefinetionOfTree.png";

static NSString * const kDefinetionOfNode = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/DefinetionOfNode.png";

static NSString * const kParentMethodOfTree = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/ParentMethodOfTree.png";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

// MARK: - 6. 树的相关定义
- (void)p_definitionOfTree {
    /* 树:(Tree)是n(n>=0)个结点的有限集合.n=10时称为空树.在任意一棵非空树中:
     (1)有且仅有一个特定的称为根(Root)的结点;
     (2)当n>1时,其余结点可分为m(m>0)个互不相交的有限集T1,T2,....Tn,其中每一个
     集合本身又是一棵树,并且称为根的子树(SubTree).
     
     对于树的定义还需要强调两点:
     1.n>0时根结点是唯一的,不可能存在多个根结点.
     2.m>0时,子树的个数没有限制,但它们一定是互不相交的.
     */
}

// MARK: - 6.2 结点
- (void)p_definitionOfNode {
    /* 数的结点包含一个数据元素及若干指向其子树的分支.结点拥有的子树数称为结点的度(Degree).度为0的结点称为
     叶节点(Leaf)或终端结点;度不为0的结点称为非终端结点或分支结点.
     除根结点之外,分支结点也称为内部结点.树的度是树内各结点的度的最大值.
     */
    
    /*6.2.2 结点间关系
     结点的子树的根称为该结点的孩子(Child),相应地,该结点称为孩子的双亲(Parent).
     同一个双亲的孩子之间互称为兄弟(Sibling).结点的祖先是从根到该结点所经分支上的所有结点.
     */
    
    /*6.2.3 树的其他相关概念
     结点的层次(Level)从根开始定义,根为第一层,根的孩子为第二层.若某结点在第l层,则其子树就在l+1层.
     树种结点的最大层次称为树的深度(Depth)的高度,当前树的深度为4.
     
     如果将树种结点的各子树看成从左到右是有次序的,不能互换的,则称为有序树,否则称为无序树.
     
     森林(forest)是m(m>=0)棵互不相交的数的集合.对树种每个结点而言,其子树的集合即为森林.
     
     线性结构:
     1.>第一个数据元素:无前驱.
     2.>最后一个数据元素:无后继.
     3.>中间元素:一个前驱一个后继.
     
     树结构:
     1.>根节点:无双亲,唯一.
     2.>叶节点:无孩子,可以多个.
     3.>中间结点:一个双亲多个孩子.
     */
}

// MARK: - 6.4 树的存储结构
- (void)p_storageOfTree {
    /* 利用顺序存储结构和链式存储结构的特点,完全可以实现对树的存储结构的表示.这里主要介绍三种不同的表示法:
     双亲表示法,孩子表示法,孩子兄弟表示法.
     */
    /*6.4.1 双亲表示法
     假设以一组连续空间存储树的结点,同时在每个结点中,附设一个指示其双亲结点在数组中的位置.
     也就说,每个结点除了知道自己是谁以外,还知道它的双亲在哪里.它的结点结构如下表示:
     
     ([data] [Parent])
     其中data是数据域,存储结点的数据信息.而parent是指针域,存储该结点的双亲在数组中的下标.
     
     有了这样的结构定义,我们就可以来实现双亲表示法了,由于根结点是没有双亲的,所以我们约定根结点的位置域设置为-1;
     这也就意味着,我们所有的结点都存有它双亲的位置.
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
    for (int i = 0; i < 3; i ++) {
        ZJRowImageModel *model = [ZJRowImageModel new];
        if (i == 0) {
            [model setText:@"6 树的定义相关"
                  imageURL:kDefinetionOfTree
              functionName:@"p_definitionOfTree"];
        }
        else if (i == 1) {
            [model setText:@"6.2  结点"
                  imageURL:kDefinetionOfNode
              functionName:@"p_definitionOfNode"];
        }
        else if (i == 2) {
            [model setText:@"6.4 树的存储结构"
                  imageURL:kParentMethodOfTree
              functionName:@"p_storageOfTree"];
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
