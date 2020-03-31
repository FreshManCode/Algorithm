//
//  NSObject+YWMethodAddition.m
//  ImitateBaiduCourse
//
//  Created by stone on 2018/2/27.
//  Copyright © 2018年 能伍网络. All rights reserved.
//

#import "NSObject+YWMethodAddition.h"

#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (YWMethodAddition)

static NSString * const kSemaphoreKey = @"CreateSemaphoreKey";
static NSString * const ivarListKey   = @"AllIvarsKey";



- (void)setSemaphore:(dispatch_semaphore_t)semaphore {
    objc_setAssociatedObject(self, &kSemaphoreKey, semaphore, OBJC_ASSOCIATION_RETAIN);
}

- (dispatch_semaphore_t)semaphore {
    if (!objc_getAssociatedObject(self, &kSemaphoreKey)) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        self.semaphore = semaphore;
    }
    return objc_getAssociatedObject(self, &kSemaphoreKey);
}


+ (void)load {
    [self p_avoidCrash];
}

+ (void)p_avoidCrash {
    Class class = self;
    Method originalMethod = class_getInstanceMethod(class, @selector(setValue:forKey:));
    Method safeMethod = class_getInstanceMethod(class, @selector(safeSetValue:forKey:));
    BOOL didAdd = class_addMethod(class,
                                  @selector(setValue:forKey:),
                                  method_getImplementation(safeMethod),
                                  method_getTypeEncoding(safeMethod));
    if (didAdd) {
        class_addMethod(class,
                        @selector(safeSetValue:forKey:),
                        method_getImplementation(originalMethod),
                        method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, safeMethod);
    }
}


- (void)safeSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self safeSetValue:value forKey:key];
    } @catch (NSException *exception) {
    } @finally {
        
    }
}

+ (NSMutableAttributedString *)getAttributeStringWithContent:(NSString *)content
                                                 lineSpacing:(CGFloat)space
                                                    wordFont:(UIFont *)font{
    if (content.length < 1) {return nil;}
    __block NSMutableAttributedString *attributeString;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        attributeString = [[NSMutableAttributedString alloc]initWithString:content];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.lineSpacing = space;
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, content.length)];
        [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
        dispatch_semaphore_signal(self.semaphore);
    });
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return attributeString;
}

- (CGSize)attributionHeightWithString:(NSString *)string
                            lineSpace:(CGFloat)lineSpace
                                 font:(UIFont *)font
                                width:(CGFloat)width {
    if (string.length < 1) {
        return CGSizeMake(0.1f, 0.1f);
    }
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dict
                                       context:nil].size;
    
    return size;
}

/**
 获取所有的属性
 
 @return 属性集合
 */
- (NSArray *)allPropertys {
    NSArray *cachedIvarList = objc_getAssociatedObject(self, &ivarListKey);
    if (!cachedIvarList) {
        unsigned int propertysCount = 0;
        objc_property_t  *propertys    = class_copyPropertyList([self class], &propertysCount);
        NSMutableArray *propertysArray = [NSMutableArray new];
        @autoreleasepool {
            for (int i = 0; i < propertysCount; i++) {
                objc_property_t property = propertys[i];
                NSString *propertyName   = [NSString stringWithUTF8String:property_getName(property)];
                [propertysArray addObject:propertyName];
            }
        }
        cachedIvarList = propertysArray.copy;
        objc_setAssociatedObject(self, &ivarListKey, cachedIvarList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        free(propertys);
    }
    return cachedIvarList;
}


/**
 获取所有的属性 过滤不想进行操作的属性
 
 @param ignoredArrays 需要过滤属性的集合
 @return 除了需要过滤属性之外的属性集合
 */
- (NSArray *)allPropertysWithIgnoredSet:(NSArray <NSString *> *)ignoredArrays {
    NSArray *cachedIvarList = objc_getAssociatedObject(self, &ivarListKey);
    NSMutableArray *resultArray = [NSMutableArray new];
    if (!cachedIvarList) {
        unsigned int propertysCount = 0;
        objc_property_t  *propertys    = class_copyPropertyList([self class], &propertysCount);
        NSMutableArray *propertysArray = [NSMutableArray new];
        @autoreleasepool {
            for (int i = 0; i < propertysCount; i++) {
                objc_property_t property = propertys[i];
                NSString *propertyName   = [NSString stringWithUTF8String:property_getName(property)];
                if (![ignoredArrays containsObject:propertyName]) {
                    [resultArray addObject:propertyName];
                }
                [propertysArray addObject:propertyName];
            }
            objc_setAssociatedObject(self, &ivarListKey, propertysArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        free(propertys);
    }
    else {
        [cachedIvarList enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL * stop) {
            if (![cachedIvarList containsObject:obj]) {
                [resultArray addObject:obj];
            }
        }];
    }
    return resultArray.copy;
}

/**
 获取当前时间戳 (s级要是转为ms级需要*1000)
 
 @return 时间戳
 */
- (NSTimeInterval)currentTimestamp {
    NSDate *date = [NSDate date];
    return [date timeIntervalSince1970];
}

@end
