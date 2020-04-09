//
//  ZJDataSectionOneVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDataSectionOneVC.h"

@interface ZJDataSectionOneVC ()

@end

@implementation ZJDataSectionOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_typeOfStruct];
}

- (void)p_beiefIntroduce {
    /*
     数据结构:是相互之间存在一种或多种特定关系的数据元素的集合.
     */
    
    /*逻辑结构与物理结构
     按照视点的不同,我们把数据结构分为逻辑结构和物理结构
     逻辑结构:是指数据对象中数据元素之间的相关关系.逻辑结构分为以下四种.
     
     1.集合结构
     集合结构:集合结构中的数据元素除了同属于一个集合外,它们之间没有其他关系.各个数据元素是平等的.它们的共同属性是"同属于一个集合".
     数据结构中的集合关系就类似于数学中的集合.
     
     2.线性结构
     线性结构中的数据元素之间是一一对应的关系.
     
     3.树形结构
     树形结构中的数据元素之间存在一种一对多的层次关系.
     
     4.图形结构
     图形结构的数据元素是多对多的关系
     */
    
    /* 物理结构:
     数据的逻辑结构在计算机中的存储形式
     数据的存储结构应反映出数据元素之间的逻辑关系,这才是最为关键的.如何存储数据元素之间的逻辑关系,是实现物理结构的重点和难点.
     */
}

// MARK: - 物理结构
- (void)p_saveStructue {
    /* 1.顺序存储结构
     把数据元素存放在地址连续的存储单元里,其数据间的逻辑关系和物理关系是一致的.
     */
    /*2.链式存储结构
     把数据元素存放在任意的存储单元里,这组存储单元可以是连续的,也可以是不连续的.数据元素的存储关系并不能反映其逻辑关系,
     因此需要用一个指针存放数据元素的地址,这样通过地址就可以找到相关联数据元素的位置.
     */
}

// MARK: - 1.6 抽象数据类型
- (void)p_abstractDataType {
    /*1.6.1 数据类型
     一组性质相同的值的集合及定义在此集合上的一些操作的总称.
     
     在C语言中,按照取值的不同,数据类型可以分为两类:
     1.原子类型:是不可以再分解的基本类型,包括整型,实型,字符型等.
     2.结构类型:由若干个类型组合而成,是可以再分解的.例如,整型数组是由若干个整型数据组成的.
     */
    
    /*1.6.2 抽象数据类型
     抽象数据类型(Abstract Data Type,ADT):是指一个数学模型及定义在该模型上的一组操作.抽象数据类型的定义
     仅取决于它的一组逻辑特性,而与其在计算机内部如何表示和实现无关.
     
     */
}

// MARK: - 结构体的几种类型
- (void)p_typeOfStruct {
    
    /**
     第一种类型结构体,有结构体名,
     有结构体变量
     */
    struct str {
        int a;
        int b;
    }str1;
    
    
    /**
     第二种类型结构体,有结构体名,无结构体变量
     */
    struct str2 {
        int a;
        int b;
    };
    
    /**
     第三种结构体的形式,把结构体重定义为STR3
     */
    typedef struct {
        int a;
        int b;
    }STR3;
    
    /**
     第四种类型结构体:把结构体重定义为STR4,还有结构体名称
     */
    typedef struct str4 {
        int a;
        int b;
    }STR4;
    
    
    //  定义各类的指针:
    struct str *p;
    struct str2 *p2;
    STR3 *p3;
    struct str4 *p4;
    STR4 *p5;
    
//  结构体指针指向结构体变量的地址首地址
    p=&str1;
    p->a = 1;
    p->b = 2;
    printf("p->a = %d,p->b = %d\n",p->a,p->b);
    //p->a = 1,p->b = 2
    
//  为结构体指针分配对应结构体类型的大小的首选地址
    p2=(struct str2 *)malloc(sizeof(struct str2));
    p2->a = 2;
    p2->b = 4;
    printf("p2->a = %d,p2->b = %d\n",p2->a,p2->b);
    //p2->a = 2,p2->b = 4
    
    //为结构体指针分配对应结构体类型的大小的首地址
    p3=(STR3 *)malloc(sizeof(STR3));
    p3->a = 3;
    p3->b = 6;
    printf("p3->a = %d,p3->b = %d\n",p3->a,p3->b);
    //p3->a = 3,p3->b = 6
    
//  为结构体指针分配对应结构体类型的大小的首地址
    p4=(struct str4 *)malloc(sizeof(struct str4));
    p4->a = 4;
    p4->b = 8;
    printf("p4->a = %d,p4->b = %d\n",p4->a,p4->b);
    //p4->a = 4,p4->b = 8
    
    struct str4 str4a;
    p4=&str4a;//结构体指针指向结构体变量的地址的首地址
    printf("p4->a = %d,p4->b = %d\n",p4->a,p4->b);
    //p4->a = 53298882,p4->b = 1
    p4->a = 41;
    p4->b = 42;
    printf("p4->a = %d,p4->b = %d\n",p4->a,p4->b);
    //p4->a = 1,p4->b = 2
    
    //为结构体指针分配对应结构体类型的大小的首选地址
    p5 = (STR4 *)malloc(sizeof(STR4));
    p5->a = 5;
    p5->b = 10;
    printf("p5->a = %d,p5->b = %d\n",p5->a,p5->b);
    //p5->a = 5,p5->b = 10
    
    //结构体指针指向结构体变量的地址的首地址
    p5 = &str4a;
    printf("p5->a = %d,p5->b = %d\n",p5->a,p5->b);
    //p5->a = 41,p5->b = 42
    p5->a = 15;
    p5->b = 16;
    printf("p5->a = %d,p5->b = %d\n",p5->a,p5->b);
    //p5->a = 15,p5->b = 16
    
    
    

    
    
    
    
    
}


@end
