//
//  ZJDataSectionThreeVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/2.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDataSectionThreeVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"


#define MaxSize 20
//  ElementType根据实际情况而定,这里设定为int
typedef int  ElementType;
typedef struct {
    //数组存储数据元素,最大值为MaxSize
    ElementType data[MaxSize];
    //线性表当前长度
    int length ;
}Sqlist;
#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0
typedef int Status;

//  线性表的单链表存储结构
typedef struct Node {
    ElementType data;
    struct Node *next;
}Node;
//定义线性表
typedef struct Node *LinkList;


@interface ZJDataSectionThreeVC ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJDataSectionThreeVC

static NSString * const kOrderListTypeURL = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/OrderListType.png";
static NSString * const kOrderListInsert = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/LineChartInsert.png";
static NSString * const kOrderListDelete = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/LineChartDelete.jpeg";
static NSString * const kOrderListHeadInsert = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/LineChartHeadInsert.png";

Sqlist* list;

//单链表
LinkList *SingleList;


@dynamic dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    
    
}

// MARK: - 3.2 线性表的定义
- (void)p_definitionOfLineChart {
    /*线性表(List):零个或多个数据元素的有限序列.
     
     线性表元素的个数n(n>=0)定义为线性表的额长度,当n=0时,称为空表.
     
     在非空表中的每个数据元素都有一个确定的位置,如a1是第一个数据元素,an是最后一个数据元素,ai是第i个数据元素
     称i为数据元素ai在线性表中的位序.
     */
}
// MARK: - 3.4 线性表的顺序存储结构
- (void)p_structureOfOrderList {
    /* 描述顺序存储结构需要3个属性
     1.存储空间的起始位置,数组data,它的存储位置就是存储空间的起始位置.
     2.线性表的最大存储容量:数组长度MaxSize
     3.线性表的当前长度:length
     */
    [self p_initOrderList];
    list->length = 0;
    for (int i = 0; i < 10; i ++) {
        list->data[i] = i * 2;
        list->length += 1;
        printf("\nSqlist.Length is %d",list->length);
    }
    
    ElementType type ;
    GetEelement(*list, 2, &type);
    printf("type is:%d",type);
}


// MARK: - 顺序存储结构的插入
- (void)p_insertOrDeleteOfOrderList {
    [self p_initOrderList];
    //未添加元素
    if (list->length < 1) {
        [self p_structureOfOrderList];
    }
    [self p_printOrderList:@"Old"];
    InsertElement(list, 5, 100);
    [self p_printOrderList:@"New"];
}

// MARK: -顺序存储结构的删除
- (void)p_deleteOrDeleteOfOrderList {
    [self p_initOrderList];
    //未添加元素
    if (list->length < 1) {
        [self p_structureOfOrderList];
    }
    [self p_printOrderList:@"Old"];
    DeleteElement(list, 4);
    [self p_printOrderList:@"New"];
}

// MARK: - 线性表的顺序存储结构的优缺点
- (void)p_advantangeAndDisadvantage {
    /*优点:
     1.无须为表示表中元素之间的逻辑关系而增加额外的存储空间.
     2.可以快速地存取表中任一位置的元素.
     
     缺点:
     1.插入和删除操作需要移动大量元素
     2.当线性表长度变化较大时,难以确定存储空间的容量.
     3.造成存储空间的"碎片"
     */
}

// MARK: - 3.6 线性表的链式存储结构
- (void)p_chainStorageOfLineChart {
    /* 线性表的链式存储结构的特点是用一组任意的存储单元存储线性表的数据元素,这组数据元素可以是连续的,也可以是不连续的.
     
     我们把链表中第一个结点的存储位置叫做头指针,那么整个链表的存取就必须是从头指针开始进行了.之后的每个结点,
     其实就是上一个后继指针指向的位置.
     
     最后一个,意味着直接后继不存在了,所以我们规定,线性表的最后一个结点指针为"空"(通常用NULL或者"^"符号表示)
     
     有时,为了更加方便地对链表进行操作,会在单链表的第一个节点前附设一个结点,称为头结点.头结点的数据域可以不存储任何信息,
     也可以存储如线性表的长度等附加信息,头结点的指针域存储指向第一个结点的指针
     
     头指针与头结点的异同:
     
     头指针:
     1.头指针是指链表指向第一个结点的指针,若链表有头结点,则是指向头结点的指针
     2.头指针具有标识作用,所以常用头指针冠以链表的名字.
     3.无论链表是否为空,头指针均不为空;头指针是链表的必要元素.
     
     头结点:
     1.头结点是为了操作的统一和方便而设立的,放在第一元素的结点之前,其数据域一般无意义.
     2.有了头结点,对在第一元素结点前插入结点和删除第一结点,其操作与其它结点的操作就统一了.
     3.头结点不一定是链表必须要素.
     */
}

// MARK: - 3.7 单链表的读取
- (void)p_readOfSignleLineChart {
    /* 获得链表第i个数据的算法思路:
     1.声明一个指针p指向链表第一个结点,初始化j从1开始;
     2.当j<i时,就遍历链表,让p的指针向后移动,不断指向下一节点,j累计+1
     3.若到链尾p为空,则说明第i个结点不存在;
     4.否则就查找成功,返回结点p的数据.
     
     实现算法如:GetElement方法,该算法最坏情况下的时间复杂度是O(n)
     
     由于单链表的结构中没有定义表长,所以不能事先知道要循环多少次,因此也就不方便使用for循环来控制循环.
     其主要核心思想就是"工作指针后移",这其实也是很多算法的常用技术.
     */
}

// MARK: - 3.8.1 单链表的插入
- (void)p_insertInSingleLineChart {
    /*
     核心代码如下:
     p->next=s->next;
     p->next=s;
     
     让p的后继结点改成s的后继结点,
     再把结点s变成p的后继结点
     */
    [self p_initLineChart];
    ZJNSLOG(@"insert result:%d",LineChartInsert(SingleList, 0, 10));
    PrintSingleLineChart(SingleList);
    
}

// MARK: - 3.8.2 单链表的删除
- (void)p_deleteSingleLineChart {
    /* 核心代码如下:
     q=p->next;
     p->next=q->next;
     
     把p的后继结点改成p后继的后继结点.
     
     单链表第i个数据删除结点的算法思路:
     1.声明一指针p指向链表头结点,初始化j从1开始;
     2.当j<i时,遍历表,让p的指针向后移动,不断指向下一个结点,j累计+1;
     3.若到链表末尾p为空,则说明第i个结点不存在;
     4.否则就查找成功,将欲删除的结点p->next赋值给q,
     5.单链表的删除标准语句:p->next=q->next;
     6.再将q结点中的数据赋值给e,作为返回;
     7.释放q结点;
     8.返回成功
     */
    
    /* 从整个算法来说,我们很容易得出:它们的时间复杂度都是O(n).如果在我们不知道第i个结点的指针位置,单链表数据
     结构在插入和删除操作上,与线性表的顺序存储结构是没有太大优势的.但如果,我们希望从第i个位置,插入10个结点,对于顺序
     存储结构意味着,每一次插入都需要移动n-i个结点每次都是O(n).但单链表,我们只需要在第一次时,找到第i个位置的指针,
     此时为O(n),接下来只是简单通过赋值移动指针而已,时间复杂度都是O(1).显然,对于插入和删除数据越频繁的操作,
     单链表的效率优势就越是明显.
     */
}

// MARK: - 3.9单链表的整表创建
- (void)p_crateSingleLineChart {
    /*对于单链表来说,它所占用空间的大小和位置是不需要预先分配划定的,可以根据系统的情况和实际的需求及时生成.
     所以创建单链表的过程就是一个动态生成链表的过程.即从"空表"的初始状态起,依次建立各元素结点,并逐个插入链表.
     
     单链表整表创建的算法思路:
     1.声明一指针p和计算器变量i;
     2.初始化一空链表L;
     3.让L的头结点的指针指向NULL,即建立一个带头结点的单链表
     4.循环
     (4.1:生成一新结点赋值给p;
     (4.2:随机生成一个数字赋值给p的数据域p->data;
     (4.3:将p插入到头结点与前一结点之间.
     
     */
    LinkList *Linkst = NULL;
    CreateListHead(Linkst, 50);
    PrintSingleLineChart(Linkst);
    
    
}

/**初始化线性表*/
- (void)p_initOrderList {
    if (list == NULL) {
        //      结构体的初始化
        list = (Sqlist *)malloc(sizeof(Sqlist));
        list->length = 0;
        ZJNSLOG(@"初始化一个线性链表");
    }
}


/**初始化单链表*/
- (void)p_initLineChart {
    if (SingleList == NULL) {
        SingleList = (LinkList *)malloc(sizeof(Node));
    }
}

- (void)p_freeCObject {
    //    if (list) {
    //        free(list);
    //    }
}

Status GetEelement(Sqlist L,int i,ElementType *e) {
    if (L.length == 0 || L.length < i ||i < 1) {
        return ERROR;
    }
    *e = L.data[ i -1];
    return OK;
}


/**
 插入操作
 
 @param L 线性表
 @param i 插入的索引
 @param e 插入的元素
 @return 成功还是失败
 */
Status InsertElement(Sqlist *L,int i,ElementType e) {
    if (L->length >= MaxSize || i < 1 || i >MaxSize - 1) {
        return ERROR;
    }
    //插入到末尾
    L->length ++;
    if (i>L->length) {
        L->data[i] = e;
        return OK;
    }
    //插入到中间的i位置,i之后的元素都向后移动一个位置
    //记录之前的数据
    for (int j = L->length; j >= i; j -- ) {
        L->data[j] = L->data[j - 1];
    }
    L->data[i - 1] = e;
    return OK;
}

Status DeleteElement(Sqlist * L,int i) {
    if (i < 0 || i > L->length) {
        return ERROR;
    }
    
    //插入到中间的i位置,i之后的元素都向后移动一个位置
    //记录之前的数据
    for (int j = i; j <L->length;j ++) {
        L->data[ j - 1] = L->data[j];
    }
    L->length --;
    return OK;
}

//线性表的查找操作
Status GetElement(LinkList L,int i,ElementType *e) {
    int j = 1;
    LinkList p;//声明一指针p
    p = L->next;//让p指向链表L的第一个结点
    while (p && j < i) {
        p = p ->next;
        j++;
    }
    if (!p || j > i) {
        return ERROR;
    }
    *e = p ->data;
    return OK;
}

// MARK: - 单链表的插入
Status LineChartInsert(LinkList *L,int i ,ElementType e) {
    int j = 1;
    LinkList p,s;
    p = *L;
    //寻找第i-1 个结点
    while (p && j < i) {
        p = p->next;
        j++;
    }
    //第i个结点不存在
    if (!p || j > i) {
        return ERROR;
    }
    //声明新的结点
    s = (LinkList) malloc(sizeof(LinkList));
    s->data = e;
    //将p的后继结点赋值给s的后继
    s->next = p->next;
    //将s赋值给p的后继
    p->next = s;
    return OK;
}

Status LineChartDelete(LinkList *L,int i ,ElementType *e) {
    LinkList p,q;
    int j =1;
    p = *L;
    while (p && j < i) {
        p=p->next;
        j++;
    }
    //第i个结点不存在
    if (!(p->next)||j > i) {
        return ERROR;
    }
    q = p->next;
    //将q的后继赋值给p的后继
    p->next = q->next;
    //将q节点中的数据给e
    *e = q->data;
    //回收此节点,释放内存
    free(q);
    return OK;
}


void PrintSingleLineChart(LinkList *L) {
    //  让P指向链表L的第一个结点
    LinkList p = *L;
    while (p) {
        printf("L.data is %d",p->data);
        p = p->next;
    }
}

void CreateListHead(LinkList *L,int n) {
    LinkList p;
    *L = (LinkList )malloc(sizeof(Node));
    //建立一个带头结点的单链表
    (*L)->next = NULL;
    for (int i=0; i < n; i ++) {
        //生成新结点
        p = (LinkList)malloc(sizeof(Node));
        //随机生成100以内的数字
        p->data = rand()%100 + 1;
        p->next = (*L)->next;
        //插入到表头
        (*L)->next=p;
    }
    /*这段算法代码里,我们其实使用的是插队的办法,就是始终让新结点在第一的位置.我们也可以把这种算法称为头插入法:
     
     
     */
}




- (void)p_printOrderList:(NSString *)prefixStr {
    for (int i = 0; i < list->length; i ++) {
        NSLog(@"%d: %@ is%d",i + 1,prefixStr.length > 0 ? prefixStr:@"",list->data[i]);
    }
}


- (void)configureUI {
    [self zj_registerSingleTableViewCell:[ZJDesignCell class] cellID:kDesignCellID];
    [self.dataArray addObjectsFromArray:[self rowsModel]];
    [self.tableView reloadData];
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

- (NSArray <ZJRowImageModel *> *)rowsModel {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < 10; i ++) {
        ZJRowImageModel *model = [ZJRowImageModel new];
        if (i == 0) {
            [model setText:@"1.线性表的定义"
                  imageURL:@""];
        }
        else if (i == 1) {
            [model setText:@"2.线性表的顺序存储结构"
                  imageURL:nil
              functionName:@"p_structureOfOrderList"];
        }
        else if (i == 2) {
            [model setText:@"3.顺序存储结构的插入"
                  imageURL:nil
              functionName:@"p_insertOrDeleteOfOrderList"];
        }
        else if (i == 3) {
            [model setText:@"4.顺序存储结构的删除"
                  imageURL:nil
              functionName:@"p_deleteOrDeleteOfOrderList"];
        }
        else if (i == 4) {
            [model setText:@"5.线性顺序存储结构的优缺点"
                  imageURL:kOrderListTypeURL
              functionName:@""];
        }
        else if (i == 5) {
            [model setText:@"6.线性表的链式存储结构"
                  imageURL:nil
              functionName:@""];
        }
        else if (i == 6) {
            [model setText:@"7.单链表的读取"
                  imageURL:nil
              functionName:@""];
        }
        else if (i == 7) {
            [model setText:@"8.1单链表的插入"
                  imageURL:kOrderListInsert
              functionName:@"p_insertInSingleLineChart"];
        }
        else if (i == 8) {
            [model setText:@"8.2单链表的删除"
                  imageURL:kOrderListDelete
              functionName:@"p_deleteSingleLineChart"];
        }
        else if (i == 9) {
            [model setText:@"9.单链表的整表创建"
                  imageURL:kOrderListHeadInsert
              functionName:@"p_crateSingleLineChart"];
        }
        [tempArray addObject:model];
    }
    return tempArray;
}

- (void)dealloc {
    ZJNSLOG(@"哈哈哈");
    [self p_freeCObject];
}


@end

