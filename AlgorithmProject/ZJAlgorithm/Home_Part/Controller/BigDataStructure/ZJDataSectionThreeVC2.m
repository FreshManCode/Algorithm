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
typedef int ElementType;
typedef int Status;

typedef struct {
    NSString * data;
    //游标(cursor),为0时表示无指向
    int cur;
}Component,
//对于不提供结构sturct 的程序设计语言,可以使用一对并行数组data和cur来处理.
StaticLinkList[MAXSIZE];

typedef struct Node {
    ElementType data;
    struct Node *next;
}Node;

typedef struct DoubleNode {
    ElementType data;
    struct DoubleNode *next;
    struct DoubleNode *prior;
}DoubleNode;

typedef struct Node * CircleLink ;

typedef struct DoubleNode * DoubleLink ;

@interface ZJDataSectionThreeVC2 ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJDataSectionThreeVC2

@dynamic dataArray;

static NSString * const kStaticLinkChart = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/StaticLineChartInsert.png";

static NSString * const kStaticLinkChartDelete = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/StaticLineChartDelete.png";

static NSString * const kStaticLinkChartCompare = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/StaticLineChartCompare.png";

static NSString * const kCircleLinkComposite = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/CircleLinkComposite.png";

static NSString * const kDoubleLinkInsert = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/DoubleLinkInsert.png";

static NSString * const kDoubleLinkDelete = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/DoubleLinkDelete.png";

static NSString * const kLineChartContent = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/LineChartContent.png";





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

// MARK: - 3.12.2 静态链表的删除操作
- (void)p_deleteOfStaticLineChart {
    StaticLinkList testLink ;
    StaticInitList(testLink);
    StaticInsert(testLink, 3, @"丙");
    StaticPrint(testLink, @"New");
    //删除乙
    StaticDeleteList(testLink, 2);
    StaticPrint(testLink, @"New");
}


// MARK: - 3.12.3 静态链表的优缺点
- (void)p_compareOfStaticLineChart {
    /*优点:
     1.在插入和删除操作时,只需要修改游标,不需要移动元素,从而改进了在顺序存储结构中的插入和删除
     需要移动大量元素的缺点.
     
     缺点:
     1.没有解决连续分配存储带来的表长难以确定的问题.
     2.失去了顺序存储结构随机存储的特性
     总的来说,静态链表其实是为了给没有指针的高级语言设计的一种实现单链表能力的方法.
     */
}

// MARK: - 3.13 循环链表
- (void)p_cycleLineChart {
    /* 将单链表中终端结点的指针端由空指针改为指向头结点,就使整个单链表形成一个还,这种头尾相接的单链表称为单循环链表,
     简称循环链表(circular linked list)
     
     其实循环链表和单链表的主要差异就在于循环的判断条件上,原来是判断p->next是否为空,现在则是p->next不等于头结点,
     则循环结束
     如下循环链表A和B
     */
    CircleLink CircleLinkA ;
    InitCircleLinkList(&CircleLinkA, 20);
    CircleLinkPrint(&CircleLinkA,"LinkA");
    
    CircleLink CircleLinkB ;
    InitCircleLinkList(&CircleLinkB, 10);
    CircleLinkPrint(&CircleLinkB,"LinkB");
}

// MARK: - 3.14 双向链表
- (void)p_doubleCycleLineChart {
    /* 双向链表(double linked list)
     在单链表的每个结点中的结点都有两个指针域,一个指向直接后继,另一个指向直接前驱
     
     对于双向链表,其中的某个结点p,它的后继的前驱?
     p->next->prior= p = p->prior->next
     */
    DoubleLink DoubleLink;
    InitDoubleLinkList(&DoubleLink, 10);
    [self printDoubleLink:&DoubleLink];
}

// MARK: - 3.14.1双向链表的插入
- (void)p_doubleCycleLineChartInsert {
    /*例如:在p结点之后插入s结点
     //把p复制给s的前驱
     s->prior = p;
     //把p->next赋值给s的后继
     s->next  = p->next;
     //把s赋值给p->next的前驱
     p->next->prior = s;
     //把s赋值给p的后继
     p->next  = s;
     
     */
    DoubleLink DoubleLink;
    InitDoubleLinkList(&DoubleLink, 5);
    [self printDoubleLink:&DoubleLink];
    DoubleLinkInsert(&DoubleLink, 3, 300);
    [self printDoubleLink:&DoubleLink];
}

// MARK: - 3.14.2 双向链表的删除
- (void)p_doubleCycleLineChartDelete {
    DoubleLink DoubleLink;
    InitDoubleLinkList(&DoubleLink, 5);
    [self printDoubleLink:&DoubleLink];
    DoubleLinkDelete(&DoubleLink, 2);
    [self printDoubleLink:&DoubleLink];
}

// MARK: - 3.15 总结
- (void)p_summary {
    
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
            NSString *str = Data[i];
            space[i].data = Data[i - 1];
            //"庚"后面的位置为空,则next(cur)用0表示
            if (str.length < 1) {
                space[i].cur = 0;
            }
            else {
                space[i].cur = i + 1;
            }
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
        //两次循环:第一次k=999,k=L[999].cur=1,
        //第二次:k=L[1].cur=2
        for (int l = 1; l < i ; l++) {
            k = L[k].cur;
        }
        //把第i个元素之前的cur赋值给新元素的cur
        //把插入元素的游标改为指定索引的游标
        L[j].cur = L[k].cur;
        //把第i个元素之前的位置的游标换成之前最后元素的游标
        L[k].cur = j;
        return OK;
    }
    return ERROR;
}



/**
 删除在L中的第i个数据元素

 @param L 链表L
 @param i 索引
 @return  成功/失败
 */
Status StaticDeleteList(StaticLinkList L,int i) {
    int j ,k;
    if (i < 1 || i > StaticListLength(L)) {
        return ERROR;
    }
    k = MAXSIZE - 1;
    /* 假如删除乙 i = 2;
     k = L[999].cur = 1;
     */
    for (j = 1; j < i; j ++) {
        k = L[k].cur;
    }
    j = L[k].cur;
    //j = L[1].cur = 2;
    L[k].cur = L[j].cur;
    //L[1].cur=L[2].cur = 3;
    StaticFree_SSL(L, j);
    return OK;
}

/**
 静态链表的资源回收 (把下标为k的空闲结点回收到备用链表中)

 @param L 链表
 @param k 索引
 */
void StaticFree_SSL(StaticLinkList L,int k) {
    //把第一个元素的cur值赋给要删除的分量cur
    L[k].cur = L[0].cur;
    //把要删除的分量下标赋值给第一个元素的cur
    L[0].cur = k;
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

void InitCircleLinkList(CircleLink *L,int maxNumber) {
    CircleLink r,p;
    *L = malloc(sizeof(CircleLink));
//  给头结点设置一个特殊的值
    (*L)->data = 9999;
    r  = *L;
    for (int i = 0; i < maxNumber; i++) {
        p = malloc(sizeof(Node));
        p->data = i + 1;
        r->next =p;
        r = p;
    }
//  将终端结点的尾指针指向头结点
    r->next = *L;
}

void InitDoubleLinkList (DoubleLink *Link,int MaxNumber) {
    DoubleLink r,p,headNode;
    *Link = malloc(sizeof(DoubleLink));
    //  给头结点设置一个特殊的值
    (*Link)->data = 0;
    r  = *Link;
    headNode = r;
    for (int i = 0; i < MaxNumber; i++) {
        p = malloc(sizeof(DoubleNode));
        p->data = i + 1;
        r->next = p;
        
        p->prior = r;
        p->next  = NULL;
        r = p;
        //首结点的直接前驱是最后一个结点
        if (i == MaxNumber - 1) {
            headNode->prior = p;
        }
    }
    
    //将终端结点的尾指针指向头结点
    r->next = *Link;
}

- (void)printDoubleLink:(DoubleLink *)link{
    DoubleLink q = NULL;
    DoubleLink p = *link;
    while (p != q) {
        //      记录首结点
        if (q == NULL) {
            q = p;
        }
        printf("\n<<%d>>前驱:%d:后继%d",p->data ,p->prior->data,p->next->data);
        p =  p -> next;
    }
}
// MARK: - 双向链表的插入
void DoubleLinkInsert(DoubleLink *link,int index ,ElementType e) {
    int j = 1;
    DoubleLink p = *link;
    while (j < index && p) {
        p = p ->next;
        j ++;
    }
    if (p == NULL || j > index) {
        printf("插入失败了哦");
        return;
    }
    //  创建新的结点
    DoubleLink s = (DoubleLink)malloc(sizeof(DoubleNode));
    s->data = e;
    //把p赋给S的前驱
    s->prior = p;
    //把p->next赋值给s的后继
    s->next  = p->next;
    //把s值赋给p->next的前驱
    p->next->prior = s;
    //把s值赋给p的后继
    p->next  = s;
}

// MARK: - 双向链表的删除操作
void DoubleLinkDelete (DoubleLink *link ,int index) {
    int j = 1;
    DoubleLink p = *link;
    while (j < index && p != NULL) {
        p = p->next;
        j ++;
    }
    if (j > index || p == NULL) {
        return;
    }
//  把p->next赋值给p->prior的后继,如图中1所示
    p->prior->next = p->next;
//  把p->prior 赋值给p->next->prior 的前驱如图中2所示
    p->next->prior = p->prior;
//  释放结点
    free(p);
}



void CircleLinkPrint(CircleLink * L,char * prefix) {
    CircleLink q = NULL;
    CircleLink p = *L;
    while (p != q) {
//      记录首结点
        if (q == NULL) {
            q = p;
        }
        printf("\n%s:%d",prefix ? prefix : "", p->data);
        p =  p -> next;
    }
}






//获取一个链表的尾指针
CircleLink CircleTailPointer (CircleLink *L) {
    CircleLink q = NULL;
    CircleLink p = *L;
    while (p != q) {
        //      记录首结点
        if (q == NULL) {
            q = p;
        }
        p =  p -> next;
    }
    return p;
}

////合并L1,L2,结果为L3
//void CompositeCircleLink (CircleLink *L1,CircleLink *L2,CircleLink *L3) {
//    //L1 的尾结点
//    CircleLink tailNodeA = CircleTailPointer(L1);
//    //L2 的尾结点
//    CircleLink tailNodeB = CircleTailPointer(L2);
//
//    //将本指向B的第一个结点(不是头结点)
//    tailNodeA->next = tailNodeB->next->next;
//    //第2步
//    CircleLink q = tailNodeB->next;
//    //将原A表的头结点赋值给tailNodeB->next,即第3步
//    tailNodeB->next = tailNodeA;
//
//    *L3= malloc(sizeof(CircleLink));
//    CircleLink newNode  =  NULL;
//    CircleLink headNode =  *L1;
//    while (headNode != newNode) {
//        //      记录首结点
//        if (newNode == NULL) {
//            newNode = headNode;
//        }
//        (*L3)->data = headNode->data;
//        (*L3)->next = headNode->next;
//        headNode = headNode->next;
//    }
//    free(q);
//}


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
    for (int i = 0; i < 8; i ++) {
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
            [model setText:@"3.12.2 静态链表的删除操作"
                  imageURL:kStaticLinkChartDelete
              functionName:@"p_deleteOfStaticLineChart"];
        }
        else if (i == 3) {
            [model setText:@"3.12.3 静态链表的优缺点"
                  imageURL:kStaticLinkChartDelete
              functionName:@"p_compareOfStaticLineChart"];
        }
        else if (i == 4) {
            [model setText:@"3.13 循环链表"
                  imageURL:kCircleLinkComposite
              functionName:@"p_cycleLineChart"];
        }
        else if (i == 5) {
            [model setText:@"3.14 双向链表"
                  imageURL:nil
              functionName:@"p_doubleCycleLineChart"];
        }
        else if (i == 6) {
            [model setText:@"3.14.1 双向链表的插入"
                  imageURL:kDoubleLinkInsert
              functionName:@"p_doubleCycleLineChartInsert"];
        }
        else if (i == 7) {
            [model setText:@"3.14.2 双向链表的删除"
                  imageURL:kDoubleLinkDelete
              functionName:@"p_doubleCycleLineChartDelete"];
        }
        else if (i == 8) {
            [model setText:@"3.15 总结"
                  imageURL:kLineChartContent
              functionName:@"p_summary"];
        }
        
        [tempArray addObject:model];
    }
    return tempArray;
}




@end
