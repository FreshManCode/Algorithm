//
//  ZJDataSectionTwoVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDataSectionTwoVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

@interface ZJDataSectionTwoVC ()

@property (nonatomic, strong) NSMutableArray <ZJRowImageModel *> *dataArray;


@end

@implementation ZJDataSectionTwoVC


static NSString * const kCommonTime = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/TestImage/WeChatfb6fcf24e1043078361c1e2751972f3e.png";

static NSString * const kCompareTime = @"https://xunpizhangjj.coding.net/p/CodingImageURL/d/CodingImageURL/git/raw/master/TestImage/AlgotithmTime.png";

@dynamic dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
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
    [self showExplainImage:model.imageURL];
}


// MARK: - 2.算法
- (void)p_algorithm {
    /* 2.5 算法的特性
     算法具有五个基本特性:输入,输出,有穷性,确定性和可行性.
     2.5.1 输入输出:
     算法具有0个或者多个输入.至少有一个或者多个输出.
     
     2.5.2 有穷性:
     指算法在执行有限的步骤之后,自动结束而不会出现无限循环,并且每个步骤在可接受的时间内完成.
     
     2.5.3 确定性:
     算法的每一步都具有确定性的含义,不会出现二义性.
     
     2.5.4 可行性:
     算法的每一步都是必须可行的,也就是说,每一步都能通过执行有限次数来完成.
     */
    
    /* 2.6 算法设计的要求
     正确性:算法的正确性是指算法至少应该具有输入,输出和加工处理无歧义性,能正确反映问题的需求,能够得到问题的正确答案.
     
     算法的正确通常在语法上有很大的差别,大体分为以下四个层次:
     1.算法程序没有语法错误.
     2.算法程序对于合法的输入数据能够产生满足要求的输出结果.
     3.算法程序对于非法的输入数据能够得出满足规格说明的结果.
     4.算法程序对于精心选择的,甚至刁难的测试数据都有满足要求的测试结果.
     
     一般情况下,把层次3作为一个算法是否正确的标准.
     
     2.6.1 正确性
     2.6.2 可读性
     2.6.3 健壮性
     2.6.4 时间效率高和存储量低
     
     */
}

// MARK: -  函数的渐近增长与算法时间复杂度
- (void)p_gradualIncrdentOfFunction {
    /* 输入规模n在没有限制的情况下,只要超过一个数值N,这个函数就总是大于另一函数,我们称函数是渐近增长的.
     
     函数的渐近增长:给定两个函数f(n)和g(n),如果存在一个整数N,使得对于所有的n>N,f(n)总是比g(n)大,那么我们说f(n)的
     增长渐近快于g(n).
     
     某个算法:随着n的增大,它会越来越优于另一个算法,或者越来越差于另一算法.这其实就是事前估算方法的理论依据,
     通过算法时间复杂度来估算算法时间效率.
     */
    
    /*
     2.9 算法时间复杂度:
     算法的时间复杂度,也就是算法的时间量度,记作:T(n) = O(f(n)).它表示随规模n的增大,算法
     执行时间的增长率和f(n)的增长率相同,称作算法的渐近时间复杂度,简称为时间复杂度.其中f(n)
     是问题规模n的某个函数.
     
     用大写O()来体现算法时间复杂度的记法,我们称之为大O记法.
     一般情况下,随着n的增大,T(n)增长率最慢的算法为最优算法.
     例如三个求和算法的时间复杂度分别为O(n),O(1),O(n*n).我们分别给它们取了非官方的名称,
     O(1)叫做常数阶,O(n)叫做线性阶,O(n*n)叫做平方阶
     
     2.9.2 推导大0阶方法:
     推导大O阶:
     1.用常数1取代运行时间中的所有加法常数
     2.在修改后的运行次数函数中,只保留最高阶项
     3.如果最高阶存在且不是1,则去除与这个项相乘的常数.
     得到的结果就是大O阶
     
     看如下算法:

     */
}

//常数阶
- (void)p_constAlgorithm {
    int sum = 0,n = 100;  //执行一次
    sum = (1 + n) * n /2; //执行一次
    printf("%d",sum);     //执行一次
/*
 这个算法的运行次数函数是f(n) = 3.
 第一步把常数项改为1,在保留最高阶时发现,它没有最高阶,所以这个算法的时间复杂度为O(1)
 
 注意:不管这个常数是多少,我们都记作O(1),而不能是O(3),O(12)等其任何数字.
 */
}

//线性阶
- (void)p_lineAlgorithm {
    int n = 100;
    for (int i = 0; i <n ; i ++) {
        //时间复杂度为O(1)的程序步骤序列.
    }
}

// MARK: - 对数阶
- (void)p_logorithm {
    int count  = 1;
    int n  = 128;
    while (count < n) {
        count = count * 2;
    }
    /* 由于每次*2之后,距离就更近了,也就是说有多少个2相乘最后大于n,则会退出循环.由
     pow(x, 2) = n,
     得到x = log2^n.所以这个循环的时间复杂度为O(log n)
     */
}

// MARK: - 平方阶
- (void)p_squareAlgorithm {
    int n = 100;
    for (int i = 0 ;i < n ; i ++) {
        for (int j = 0; j < n; j ++) {
            //时间复杂度为O(1)的程序步骤序列.
        }
    }
    /* 对于外层的循环,不过是内部这个时间复杂度为O(n)的语句,再循环n次,所以这段代码的时间复杂度为O(n*n)
     如果外层循环的次数改成了m,时间复杂度O(m * n)
     
     循环的复杂度等于循环体的复杂度乘以该循环运行的次数,
     */
    
    for (int i = 0; i < n; i ++) {
        for (int j = i; j < n; j ++) {
            //
        }
    }
    /*
     循环体的复杂度*该循环运行的次数
     内层循环的执行次数是:n + (n-1) + (n-2)+.....+1 = n *(n+1)/2 = n^2/2 +n/2
     用大O阶推导:
     1.没有加法常数不予考虑
     2.只保留最高项,因此保留n^2/2
     3.去除这个最高项相乘的常数,也就是去除1/2,最终这段代码的时间复杂度为O(n^2)
     */
}

// MARK: - 看以下的时间复杂度:
- (void)p_caculateOfTimeOne {
    int n = 100; //1次
    n ++;
    function(n); //n次
    //执行次数为n^2
    for (int i = 0; i < n; i ++) {
        function(i);
    }
    
    for (int i = 0; i < n; i ++) {
        for (int j = i; j < n; j ++) {
            //哈哈
        }
    }
    /* 执行次数为f(n) = “1+n+n2+n(n+1)/2=3/2·n2+3/2·n+1”
     根据大O阶的方法,最终这段代码的时间复杂度也是O(n^2)
     */
}

void function (int count) {
    int  j = 0;
    int  n = 100;
    for (j = count; j <n ; j ++) {
        //时间复杂度为O(1)的程序
    }
}

- (NSArray <ZJRowImageModel *> *)rowsModel {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < 2; i ++) {
        ZJRowImageModel *model = [ZJRowImageModel new];
        if (i == 0) {
            [model setText:@"常见的时间复杂度" imageURL:kCommonTime];
        }
        else if (i == 1) {
            [model setText:@"常用的时间复杂度所耗费的时间从小到大依次是" imageURL:kCompareTime];
        }
        [tempArray addObject:model];
    }
    return tempArray;
}

@end
