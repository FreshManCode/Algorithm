//
//  ZJAboutStackVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/13.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJAboutStackVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

#define MAXSIZE 100
#define OK 1
#define ERROR 0

typedef int Status;
//假设数据类型为int
typedef int  SEelemType;

typedef struct {
    SEelemType data[MAXSIZE];
    //用于栈顶指针
    int top;
}SqStack;


//两栈共享空间结构
typedef struct {
    SEelemType data[MAXSIZE];
    int top1;//栈1栈顶指针
    int top2;//栈2栈顶指针
} SqDoubleStack;

// MARK: - 链栈
//链栈的结构代码如下:
typedef struct StackNode {
    SEelemType data;
    struct StackNode *next;
}StackNode,*LinkStackPtr;

typedef struct LinkStack {
    LinkStackPtr top;
    int count;
}LinkStack;


@interface ZJAboutStackVC ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;

@end

@implementation ZJAboutStackVC

@dynamic dataArray;

static NSString * const kStackInAndOut = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/StackInAndOut.png";

static NSString * const kTwoStackShare = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/Alogithm/TwoStackShare.png";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

// MARK: - 4.1 栈的定义
- (void)p_definetionOfStack {
    /*栈(stack)
     限定仅在表尾进行插入和删除操作的线性表.
     
     把允许插入和删除的一端称为栈顶(top),另一端称为栈底(bottom),不含任何数据元素的栈称为空栈.
     栈又称为后进先出(Last in  First Out)的线性表,简称LIFO结构.
     
     注意:
     栈是一个线性表,也就是说栈具有线性关系,即前驱后继关系.只不过它是一种特殊的线性表而已.
     定义说是在线性表的表尾进行插入和删除操作,这里表尾是指栈顶,而不是栈底.
     
     它的特殊之处就在于限定了这个线性表的插入和删除位置,它始终只在栈顶进行.这就使得:栈底是固定的,
     最先进栈的只能在栈底.
     
     栈的插入操作叫做入栈,也交压栈,入栈.
     栈的删除操作叫做出栈,也有的叫做弹栈.
     
     */
    /* 4.2.2 进栈出栈变化形式
     最先进栈的元素,是不是只能是最后出栈呢?
     不一定,要看什么情况.栈对线性表的插入和删除的位置进行了限制,并没有对元素进行的时间进行限制,也就说,
     在不是所有元素都进栈的情况下,事先进去的元素也可以出栈,只要保证是栈顶元素出栈就可以.
     
     例如:我们现在是有3个整型数字元素1,2,3依次入栈,会有哪些出栈次序呢?
     第一种:1->2->3,出栈顺序:3->2->1
     第二种:1->1,2->2,3->3 1->2->3.也就是进一个出一个
     第三种:1->2,2->1出栈后,3进栈,2-1->3
     第四种:1->1,之后2进,3进,1->3->2
     第五种:1->2出栈,2出栈之后3再入栈2->3->1
     
     出栈顺序有没有可能是3->1->2呢?不会,因为3先出栈,就意味着3曾经入栈,既然3都入栈了,那么1和2也就入栈了,
     此时2一定在1的上面,就是更接近栈顶,那么出栈只可能是3->2->1.
     
     从这个简单的例子中可以看出,只是3个元素,就有5种可能的出栈次序,如果元素数量多,其实出栈的变化将会更多的.
     */
}

// MARK: - 4.4 栈的顺序存储结构及实现
- (void)p_orderStrorageOfStack {
    /* 既然栈是线性表的特例,那么栈的顺序存储其实也是线性表顺序存储的简化,我们简称为顺序栈.线性表是用数组来实现的,
     对于栈这种只能一头插入删除的线性表来说,用数组哪一端来作为栈顶和栈底比较好?
     
     下标为0的一端作为栈底比较好,因为首元素都存在栈底,变化最小,所以让它作为栈底.
     
     定义一个top变量来指定栈顶元素在数组中的位置,这top就如同物理学过的游标卡尺的游标,它可以来回移动,
     意味着栈顶的top可以变大变小,但无论如何游标不能超出尺的长度.同理,若存储栈的长度为StackSize,则栈顶位置top
     必须小于StackSize.当栈存在一个元素时,top等于0,因此通常把空栈的判定条件定义top等于-1
     
     如OrderPush() OrderPop两个函数
     两者没有涉及到任何循环语句,时间复杂度均是O(1)
     */
}

// MARK: - 4.5 两栈共享空间
- (void)p_shareOfTwoStack {
    /*
     数组有两个端点:两个栈有两个栈底,让一个栈的栈底为数组的始端,即下标为0处,另一个栈为数组的末端,即下标为n-1处,
     这样,两个栈如果增加元素,就是两端点向中间延伸.
     
     关键思路是:它们是在数组的两端,向中间靠拢.top1和top2是栈1和栈2的栈顶指针,可以想象,只要它们俩不见面,两个栈
     就可以一直使用.
     
     从上分析出来:栈1位空时,就是top1等于-1时;而当top2等于n时,即是栈2为空时,那什么时候满栈呢?
     若栈2是空栈,栈1的top1为n-1时,就是栈1满了.反之,当栈1位空栈时,top2等于0时,为栈2满栈.
     两个栈见面之时,也就是两个指针相差1时,即top1+1=top2为满栈.
     
     对于两栈共享空间的push方法,我们除了要插入元素参数外,还需要有一个判断是栈1还是栈2的栈号参数stackNumber.插入元素
     代码如下:
     DoublePush()
     DoublePop()
     
     当然,这只是针对两个具有相同数据类型的栈的一个设计上的技巧,如果是不相同的数据类型的栈,这种办法不但不能更好地
     处理问题,反而使问题更加复杂.
     */
}

// MARK: - 4.6 栈的链式存储结构及实现
- (void)p_chainStorageOfStack {
    /*栈的链式存储结构,简称为链栈.
     
     对于链栈来说,基本不存在栈满的情况,除非内存中已没有可以使用的空间,如果真的发生,那此时的计算机操作系统已经面临
     死机崩溃的情况,而不是这个链栈是否溢出的问题.
     
     但对于空栈来说,链表原定义是头指针指向空,那么链栈的空其实就是top=NULL的时候
     
     链栈的操作绝大部分都和单链表类似,只是在插入和删除上特殊一些.
     */
    
    /* 4.6.2 链栈的进栈与出栈操作
     链栈的进栈push和出栈Pop操作都很简单,没有任何循环操作,时间复杂度均为O(1)
     
     */
    LinkStack *stack = (LinkStack *)malloc(sizeof(LinkStack));
    //进栈
    ChainPush(stack, 1);
    ChainPush(stack, 2);
    ChainPush(stack, 3);
    ChainPush(stack, 4);
    ChainPrint(stack);
    SEelemType popData;
    //出栈
    ChainPop(stack, &popData);
    ChainPrint(stack);
}

// MARK: - 4.9 栈的应用
- (void)p_applyOfStack {
    /* 后缀表达式:
     所有的符号都是在要运算数字的后面出现.
     规则:从左到右遍历表达式的每个数字和符号,遇到是数字就进栈,遇到是符号,就将处于栈顶两个数字出栈,进行运算,
     运算结果进栈,一直到最终获得结果.
     9 3 1-3*+10 2/+
     
     1.初始化一个空栈;此栈用来要对运算的数字进出使用.
     2.后缀表达式中前三个都是数字,9->3->1 进栈
     3.接下来是"-",栈顶前两个出栈运算,3-1结果为2,2进栈9->2
     4.接着是3进栈,9->2->3
     5.后面是"*",意味着3和2出栈,2与3相乘,2*3=6,结果入栈9->6
     6.下面是"+",所以栈中6和9出栈运算,6+9=15,结果入栈15
     7.接着,10与2入栈15->10->2,
     8.接下来是"/",10/2 = 5,解雇入栈15->5
     9.最后一个是"+"号,出栈运算15+5 = 20;
     10.将运算结果20入栈,最后栈中的结果就是20,20出栈,栈变为空.
     */
    
    /*4.9.3 中缀表达式转后缀表达式
     "9+(3-1)*3+10/2",这个中缀表达式如何转换为后缀表达式得到:"9 3 1-3*+10 2/+"?
     
     规则:从左到右遍历中缀表达式的每个数字和符号,若是数字就输出,即成为后缀表达式的一部分;
     若是符号,则判断与其栈顶符号的优先级,是右括号或优先级不高于栈顶符号(乘除优先加减)则
     栈顶元素一次出栈并输出,并将当前括号进栈,一直到最终输出表达式为止.
     
     1.初始化一空栈,用来对符号进出栈使用.
     2.第一个字符是数字9,输出9,后面是符号"+",进栈.
     3.第三个是"(",依然是符号,因为是左括号,未匹配,进栈 +->(
     4.第四个字符是数字3,输出,总表达式为 9 3,接着是"-",进栈 "+"->"("->"-"
     5.接下来是数字1,输出,总表达式为 9 3 1,后面是符号")",此时,我们需要去匹配此前的"(",所以栈顶出栈,并输出
     直到"("出栈为止,此时左括号上方只有"-",输出,总的输出表达式为9 3 1 -
     6.紧接着是"*",此时栈顶符号"+",优先级低于"*",因此不输出,"*"进栈,"+"->"*",接着数字3,输出
     总表达式为 9 3 1 - 3
     7.之后是符号"+",此时当前栈顶元素"*"比这个"+"的优先级搞,因此栈中元素出栈并输出(没有比"+"号更低的优先级,所以全部出栈),
     总输出表达式为 9 3 1 - 3 * +.然后将当前"+"号入栈."+"->
     8.紧接着数字10,输出,总表达式变为9 3 1 - 3 * +10.后是符号"/",所以"/"进栈,"+"->"/"
     9.最后一个数字2,输出,总的表达式9 3 1 - 3 * +10 2
     10.因为已经到最后,所以将栈中符号全部出栈并输出,最终输出的后缀表达式结果为 9 3 1-3*+10 2/+
     
     */
}

// MARK: - 4.9.1 栈的应用--递归
- (void)p_recursionOfStack {
    /*斐波那契数列实现
     1->1->2->3->5->8->13->21->34...
     这个数列有个十分明显的特点:前面相邻两项之和,构成了后一项
     */
    /*
     递归定义:把一个直接调用自己或通过一系列的调用语句间接地调用自己的函数,称做递归函数.
     
     递归和迭代的区别:迭代使用的是循环结构,递归使用的是选择结构.
     递归能使程序的结构更清晰,更简洁,更容易让人理解,从而减少读懂代码的时间.但是大量的递归调用会建立函数的副本,会
     耗费大量的时间和内存.迭代则不需要反复调用函数和占用额外的内存.因此我们应该视不同情况选择不用的代码实现方式.
     */
    
    /* 递归和栈的关系
     简单说,就是在前行阶段,对于每一层递归,函数的局部变量,参数值以及返回地址都被压入栈中.在退回阶段,位于栈顶的局部变量,
     参数值和返回地址被弹出,用于返回调用层次中执行代码的其余部分,也就是恢复了调用的状态.
     
     */
    
}

int Fbi(int n) {
    if (n == 0) {
        return 0;
    }
    else if (n == 1) {
        return 1;
    }
    //这里Fbi 就是函数自己,他在调用自己
    return Fbi(n-1) + Fbi(n-2);
}


Status OrderPush(SqStack *S,SEelemType e) {
//  满栈了
    if (S->top == MAXSIZE - 1) {
        return ERROR;
    }
    //栈顶指针+1
    S->top++;
    //将新插入元素赋值给栈顶空间
    S->data[S->top] = e;
    return OK;
}

Status OrderPop(SqStack *S,SEelemType *e) {
    //  满栈了
    if (S->top == - 1) {
        return ERROR;
    }
    *e = S->data[S->top];
    //栈顶指针-1
    S->top--;
    //将新插入元素赋值给栈顶空间
    return OK;
}

//插入元素为e为新的栈顶元素
Status DoublePush(SqDoubleStack *stack,SEelemType e,int stackNumber) {
    if (stack->top1 + 1 == stack->top2) {
        NSLog(@"栈满了,不能入栈");
        return ERROR;
    }
    //栈1入栈
    if (stackNumber == 1) {
        //先给top+1之后,给数组元素赋值
        stack->data[++stack->top1] = e;
    }
    //栈2入栈
    else if (stackNumber == 2) {
        //先给top-1后给数组元素赋值
        stack->data[--stack->top2] = e;
    }
    return OK;
}

//若栈不为空,则删除s的栈顶元素,并用e返回其值,并返回OK,否则返回ERROR
Status DoublePop(SqDoubleStack *stack,SEelemType *e,int stackNumber) {
    if (stackNumber == 1) {
        //空栈
        if (stack->top1 == -1 ) {
            return ERROR;
        }
        //栈1的栈顶元素出栈
        *e = stack->data[stack->top1--];
    }
    else if (stackNumber == 2) {
        if (stack->top2 == MAXSIZE ) {
            //满栈,溢出
            return ERROR;
        }
        *e = stack->data[stack->top2++];
    }
    return OK;
}

// MARK: - 链栈进栈和出栈
Status ChainPush(LinkStack *s,SEelemType e) {
    LinkStackPtr node = malloc(sizeof(StackNode));
    node->data = e;
//  将当前的栈顶元素赋值给新结点的直接后继
    node->next = s->top;
//  将新结点s赋值给栈顶指针
    s->top = node;
    s->count ++;
    return OK;
}

Status ChainPop(LinkStack *s,SEelemType *e) {
    //将栈顶结点赋值给p
    LinkStackPtr top = s->top;
    *e = top->data;
    //使得栈顶指针下移一位,指向后一结点
    s->top = top->next;
    free(top);
    s->count--;
    return OK;
}

void ChainPrint (LinkStack *s) {
    int count = 0;
    LinkStackPtr top = s->top;
    while (top!=NULL && count < s->count) {
        printf("\n数据是: %d---索引是: %d",top->data,count);
        top = top->next;
        count ++;
    }
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
            [model setText:@"4.1 栈的定义"
                  imageURL:kStackInAndOut
              functionName:@"p_definetionOfStack"];
        }
        else if (i == 1) {
            [model setText:@"4.4 栈的顺序存储结构及实现"
                  imageURL:nil
              functionName:@"p_orderStrorageOfStack"];
        }
        else if (i == 2) {
            [model setText:@"4.5 两栈共享空间"
                  imageURL:kTwoStackShare
              functionName:@"p_shareOfTwoStack"];
        }
        else if (i == 3) {
            [model setText:@"4.6 栈的链式存储结构及实现"
                  imageURL:nil
              functionName:@"p_chainStorageOfStack"];
        }
        else if (i == 4) {
            [model setText:@"4.9 栈的应用"
                  imageURL:nil
              functionName:@"p_applyOfStack"];
        }
        else if (i == 5) {
            [model setText:@"4.9.1 栈的应用---递归"
                  imageURL:nil
              functionName:@"p_recursionOfStack"];
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
