//
//  ZJAboutQueue.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/14.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJAboutQueue.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

#define MAXSIZE 100
#define OK 1
#define ERROR 0

typedef int Status;
//假设数据类型为int
typedef int  SEelemType;

// MARK: - 循环队列顺序存储结构
typedef struct {
    SEelemType data[MAXSIZE];
//  头指针
    int front;
//  尾指针,若队列不为空,则指向队尾元素的下一个位置
    int rear;
}SqQueue;

// MARK: - 链队列的结构
//结点结构
typedef struct QNode{
    SEelemType data;
    struct QNode *next;
}QNode,*QueuePtr;

//队列的链表结构
typedef struct {
//  队头,队尾指针
    QueuePtr front,rear;
}LinkQueue;


@interface ZJAboutQueue ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJAboutQueue

@dynamic dataArray;

static NSString * const kChainOfQueue = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/ChainOfQueue.png";

static NSString * const kEnterChainOfQueue = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/EnterChainOfQueue.png";

static NSString * const kOutChainOfQueue = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/OutChainOfQueue.png";

static NSString * const kSummaryChainOfQueue = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/SummaryChainOfQueue.png";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

// MARK: - 4.10 队列的定义
- (void)p_definetionOfQueue {
    /* 队列(queue)是只允许在一端进行插入操作,而在另一端进行删除操作的线性表.
     队列是一种先进先出(First In First Our)的线性表,简称FIFO.
     允许插入的一端称为队尾,允许删除的一端称为队头.
     */
    
    /*4.12 队列循环
     4.12.1 队列顺序存储的不足:
     入队列操作,其实就是在队尾追加一个元素,不需要移动任何元素,因此时间复杂度为O(1),
     与栈不同的是,队列元素的出列是在对头,即下标为0的位置,意味着,队列中的所有元素都得向前移动,
     以保证队列的对头,也就是下标为0的位置不为空,此时时间复杂度为O(n)
     
     4.12.2 循环队列定义:
     队列满的条件是(rear + 1) %QueueSize == front(取模的目的就是为了整合rear与front大小为一个问题)
     
     通用的计算队列长度公式:(rear - front +QueueSize) %  QueueSize
     
     参照EnQueue() 与DeQueue()函数
     单是顺序存储,若不是循环队列,算法的时间性能是不高的,但循环队列又面临着数组可能溢出的问题,
     所以我们还需要研究一下不需要担心队列长度的链式存储结构.
     */
}

// MARK: - 4.13 队列的链式存储结构
- (void)p_chainStrorageOfQueue {
    /* 队列的链式存储结构,其实就是线性表的单链表,只不过它只能尾进头出而已,我们把它简称为队列.
     为了操作上的方便,我们将头指针指向链队列的头结点,而尾指针指向终端结点;
     空队列时,front和rear都指向头结点,
     */
}

// MARK: - 4.13.1 队列的链式存储结构--入队操作
- (void)p_enterOfLineQueue {
    /* 入队操作时,其实就是在链表尾部插入结点,
     参照 LineEnQueue()
     */
    LinkQueue *Queue = (LinkQueue *)malloc(sizeof(LinkQueue));
    //初始化一个空队列 (头和尾指针都指向头结点时)
    LinePrintLinkQueue(Queue);
    
    LineEnQueue(Queue, 1);
    LineEnQueue(Queue, 2);
    LineEnQueue(Queue, 3);
}

// MARK: - 4.13.2 队列的链式存储结构--出队操作
- (void)p_outOfLineQueue {
    /*出队操作时,就是头结点的后继结点出队,将头结点的后继改为它后面的结点,若链表除头结点之外只剩一个元素时,
     则需将rear指向头结点
     */
    
    /*对于循环队列与链队列的比较,可以从两方面考虑,从时间上,其实它们的基本操作都是常数时间,即都是O(1),
     不过循环队列是事先申请好空间,试用期间不释放,而对于链队列,每次申请和释放结点也会存在一些时间开销,
     如果入队出队频繁,则两者还是有细微差异.对于空间上来说,循环队列必须要有一个固定的长度,所以就有了
     存储元素个数和空间浪费的问题.而链队不存在这个问题,尽管它需要一个指针域,会产生一些空间上的开销;
     所以在空间上,链队列更加灵活.
     
     总的来说,在可以确定队列长度最大值的情况下,建议使用循环队列,如果无法预估队列的长度时,则用链队列.
     */
}

// MARK: - 4.14 队列的总结
- (void)p_summaryOfQueue {
    /*本章讲的是栈和队列,它们都是特殊的线性表,只不过对插入和删除操作做了限制.
     
     栈(stack) 是限定仅在表尾进行插入和删除操作的线性表.
     
     队列(queue)是只允许在一端进行插入操作,而在另一端进行删除操作的线性表.
     
     它们均可以用线性表的顺序存储结构来实现,但都存在着顺序存储的一些弊端.因此它们各自有各自的技巧来解决这个问题.
     
     对于栈来说,如果是两个相同数据类型的栈,则可以用数组的两端作栈底的方法来让两个栈共享数据,这就可以最大化地利用数组的空间.
     
     对于队列来说,为了避免数组插入和删除时需要移动数据,于是就引入了循环队列,使得队头和队尾可以在数组中循环变化.解决了移动数据的
     时间损耗,使得本来插入和删除都是O(n)的时间复杂度变成了O(1)
     
     它们也都可以通过链式存储结构来实现,实现原则上与线性表基本相同.
     
     栈:
     1.顺序栈
     --->两栈共享空间
     2.链栈
     
     队列:
     1.顺序队列
     --->循环队列
     2.链队列
     
     
     */
}


//初始化一个空队列Q
Status InitQueue(SqQueue *Q) {
    Q->front = 0;
    Q->rear  = 0;
    return OK;
}

//循环队列求队列长度
int QueueLength (SqQueue Q) {
    return (Q.rear - Q.front + MAXSIZE) % MAXSIZE;
}

//循环队列的入队列操作
Status EnQueue (SqQueue * Q,SEelemType e) {
//  队列满的判断
    if ((Q->rear + 1)%MAXSIZE == Q->front) {
        return ERROR;
    }
    //将元素e赋值给队尾
    Q->data[Q->rear] = e;
    //将rear指针向后移一位置
    Q->rear = (Q->rear + 1) % MAXSIZE;
    //若到最后则转到数组头部
    return OK;
}

//循环队列的出队列操作
Status DeQueue (SqQueue *Q,SEelemType *e) {
//  队列空的判断
    if (Q->rear == Q->front) {
        return ERROR;
    }
    *e = Q->data[Q->front];
    //front指针向后移动
    Q->front = (Q->front + 1) % MAXSIZE;
    return OK;
}

// MARK: - 队列的链式存储结构--入队与出队操作

//初始化一个链式空队列 (front 和rear都指向头结点)
Status InitLineQueue (LinkQueue *Q) {
    QueuePtr headNode = (QueuePtr)malloc(sizeof(QNode));
    headNode->data = 0;
    Q->rear  = headNode;
    Q->front = headNode;
    return OK;
}

Status LineEnQueue (LinkQueue *Q,SEelemType e) {
    QueuePtr s = (QueuePtr)malloc(sizeof(QNode));
    //存储分配失败
    if (!s) {
        exit(OVERFLOW);
    }
    s->data = e;
    s->next = NULL;
    //把拥有元素e的新结点s复制给原队尾结点的后继 参见图步骤1
    Q->rear->next = s;
    //把当前的s结点设为队尾结点,rear指向s,参见图步骤2
    Q->rear = s;
    return OK;
}

Status LineOutQueue (LinkQueue *Q,SEelemType *e) {
    //将于删除的队列头结点暂存给headNode,
    QueuePtr headNode = Q->front;
    //已经空队列了
    if (headNode == Q->rear) {
        return ERROR;
    }
    *e = headNode->data;
    //将原队列头结点后继headNode->next赋给头结点后继
    Q->front->next = headNode->next;
    //若对头等于队尾,则删除后将rear指向头结点,如步骤3
    if (Q->rear == headNode) {
        Q->rear = headNode;
    }
    free(headNode);
    return OK;
}

void LinePrintLinkQueue (LinkQueue *Q) {
    QueuePtr headNode = Q->front;
    QueuePtr rearNode = Q->rear;
    
    while (headNode != rearNode) {
        if (headNode != NULL) {
            printf("\n<<%p>>%d",headNode,headNode->data);
        }
        headNode = headNode->next;
    }
    printf("\n<<%p>>%d",rearNode,rearNode->data);
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
    for (int i = 0; i < 5; i ++) {
        ZJRowImageModel *model = [ZJRowImageModel new];
        if (i == 0) {
            [model setText:@"4.10 队列定义"
                  imageURL:nil
              functionName:@"p_definetionOfQueue"];
        }
        else if (i == 1) {
            [model setText:@"4.13 队列的链式存储结构"
                  imageURL:kChainOfQueue
              functionName:@"p_chainStrorageOfQueue"];
        }
        else if (i == 2) {
            [model setText:@"4.13.1 链队的入队操作"
                  imageURL:kEnterChainOfQueue
              functionName:@"p_enterOfLineQueue"];
        }
        else if (i == 3) {
            [model setText:@"4.13.2 链队的出队操作"
                  imageURL:kOutChainOfQueue
              functionName:@"p_outOfLineQueue"];
        }
        else if (i == 4) {
            [model setText:@"4.14 队列的总结"
                  imageURL:kSummaryChainOfQueue
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
