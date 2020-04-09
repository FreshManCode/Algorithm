//
//  ZJDataSectionThreeVC2.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/9.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//  线性表2(静态链表,双向链表)

#import "ZJDataSectionThreeVC2.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

#define MAXSIZE 1000
#define OK 1
#define ERROR 0
typedef int  ElementType;
typedef int Status;

typedef struct {
    NSString * data;
    //游标(cursor),为0时表示无指向
    int cur;
}Component,
//对于不提供结构sturct 的程序设计语言,可以使用一对并行数组data和cur来处理.
StaticLinkList[MAXSIZE];

@interface ZJDataSectionThreeVC2 ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJDataSectionThreeVC2

@dynamic dataArray;

static NSString * const kStaticLinkChart = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/StaticLineChartInsert.png";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

// MARK: - 3.12 静态链表
- (void)p_staticLineChart {
    /* 首先让数组的元素都是由两个数据域组成,data和cur.也就是说,数组的每个下标都对应一个data和一个cur.
     数据域data,用来存放数据元素,也就是通常我们要处理的数据;而cur相当于单链表中的next指针,存放该数据元素
     的后继在数组中的下标,我们把cur叫做游标.
     
     把这种用数组描述的链表叫做静态链表,这种描述方法还有起名叫做游标实现法:
     
     另外对数组第一个和最后一个元素作为特殊元素处理,不存数据.通常把未被使用的数组元素称为备用链表.而数组第一个
     元素,即下标为0的元素的cur就存放备用链表的第一个结点的下标;而数组的最后一个元素的cur则存放第一个有数值的元素的
     下标,相当于单链表中的头结点的作用,当整个链表为空时,则为0;
     */
}

// MARK: - 3.12.1 静态链表的插入操作
- (void)p_insertOfStaticLineChart {
    /*
     为了辨明数组中哪些分量未被使用,解决的办法是将所有未被使用过的及已被删除的分量用游标链成一个备用的链表,每当进行插入时,
     便可以从备用链表上取得第一个结点作为待插入的新结点.
     */
    /*Malloc_SLL()函数
     从本图中显示,其实就是返回7.那么既然下标为7的分量准备要使用了,那就得有接替者,所以就把分量7的cur值赋值给头元素,
     也就是把8给space[0].cur,之后就可以继续分配新的空闲分量,实现类似malloc()函数的作用
     */
    
    /*我们现在如果要在"乙"和"丁"之间插入一个"丙"元素,
     */
    StaticLinkList testLink ;
    StaticInitList(testLink);
    StaticPrint(testLink, @"OLD");
    StaticInsert(testLink, 3, @"丙");
    StaticPrint(testLink, @"New");
}

//若备用空间链表为空,则返回分配的节点下标,否则返回0
int Malloc_SLL(StaticLinkList space) {
    //当前数组第一个元素的cur存的值;
    //返回一个备用空闲的下标.
    int i = space[0].cur;
    //由于要拿出一个分量来使用,所以我们就得把它的下一个分量用来做备用
    if (space[0].cur) {
        space[0].cur = space[i].cur;
    }
    return i;
}

Status StaticInitList(StaticLinkList space) {
    int i;
    NSString * Data[10]= {@"甲",@"乙",@"丁",@"戊",@"己",@"庚"};
    for (i = 0 ; i < MAXSIZE - 1; i++) {
        if (i == 0) {
            space[i].cur = 7;
        }
        else if (i < 7){
            space[i].data = Data[i - 1];
            space[i].cur = i + 1;
        }
    }
    space[MAXSIZE - 1].cur = 1;
    return OK;
}

int StaticListLength(StaticLinkList space) {
    int length = 0;
    for (int i = 0; i < MAXSIZE; i++) {
        if (space[i].data) {
            length ++;
        }
    }
    return length;
}


Status StaticInsert(StaticLinkList L,int i,NSString *e) {
    int j,k;
    //k是最后一个元素的下标
    k = MAXSIZE - 1;
    if (i < 1 || i > StaticListLength(L) + 1) {
        return ERROR;
    }
    //获得空闲分量的下标
    j = Malloc_SLL(L);
    if (j) {
        L[j].data = e;
        //找到第i个元素之前的位置
        for (int l = 1; l < i ; l++) {
            k = L[k].cur;
        }
        //把第i个元素之前的cur赋值给新元素的cur
        L[j].cur = L[k].cur;
        //把第i个元素之前的位置的游标换成之前最后元素的游标
        L[k].cur = j;
        return OK;
    }
    return ERROR;
}

void StaticPrint(StaticLinkList L,NSString *prefix) {
    for (int i = 0; i < MAXSIZE; i++) {
        if (i > 0) {
            if (L[i].data.length > 0) {
                NSLog(@"%@--%d--%@",prefix ? prefix : @"",L[i].cur,L[i].data);
            } else {
                break;
            }
        }
    }
}

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
            [model setText:@"3.12 静态链表"
                  imageURL:@""
              functionName:@"p_staticLineChart"];
        }
        else if (i == 1) {
            [model setText:@"3.12.1 静态链表的插入操作"
                  imageURL:kStaticLinkChart
              functionName:@"p_insertOfStaticLineChart"];
        }
        else if (i == 2) {
            [model setText:@""
                  imageURL:nil
              functionName:@""];
        }
        [tempArray addObject:model];
    }
    return tempArray;
}




@end
