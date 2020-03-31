//
//  ZJBaseTableViewCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

@interface ZJBaseTableViewCell ()

@property (nonatomic, strong) CAShapeLayer *sepratorLayer;

@end

@implementation ZJBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self ZJ_addDefaultConfig];
        [self zj_addSubviews];
        [self zj_addConstraints];
    }
    return self;
}

- (void)zj_addSubviews {
    
}

- (void)zj_addConstraints {
    
}

- (void)ZJ_addDefaultConfig {
    ZJCellEdgeinset edgeInset = {15,15};
    self.lineHeight   = 0.7f;
    self.lineColor    = ZJECLineColor;
    self.Edgeinset    = edgeInset;
    self.sepratorType = ZJCellSepratorNone;
}

/**添加Cell 分割线*/
- (void)zj_addSepratorLine:(CGRect)frame {
    CGFloat width  = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    self.sepratorLayer.lineWidth   = _lineHeight;
    self.sepratorLayer.strokeColor = _lineColor.CGColor;
    self.sepratorLayer.fillColor   = _lineColor.CGColor;
    [self.sepratorLayer removeFromSuperlayer];
    switch (self.sepratorType) {
        case ZJCellSepratorNone: {}
            break;
        case ZJCellSepratorTop: {
            [bezierPath moveToPoint:CGPointMake(_Edgeinset.left, _lineHeight)];
            [bezierPath addLineToPoint:CGPointMake(width - _Edgeinset.right, _lineHeight)];
            self.sepratorLayer.path = bezierPath.CGPath;
            [self.contentView.layer addSublayer:self.sepratorLayer];
        }
            break;
        case ZJCellSepratorBottom: {
            [bezierPath moveToPoint:CGPointMake(_Edgeinset.left, height - _lineHeight)];
            [bezierPath addLineToPoint:CGPointMake(width - _Edgeinset.right,height - _lineHeight)];
            self.sepratorLayer.path = bezierPath.CGPath;
            [self.contentView.layer addSublayer:self.sepratorLayer];
        }
            break;
        case ZJCellSepratorTopAndBottom: {
            [bezierPath moveToPoint:CGPointMake(_Edgeinset.left, _lineHeight)];
            [bezierPath addLineToPoint:CGPointMake(width - _Edgeinset.right, _lineHeight)];
            [bezierPath moveToPoint:CGPointMake(_Edgeinset.left, height - _lineHeight)];
            [bezierPath addLineToPoint:CGPointMake(width - _Edgeinset.right,height - _lineHeight)];
            self.sepratorLayer.path = bezierPath.CGPath;
            [self.contentView.layer addSublayer:self.sepratorLayer];
        }
            break;
        default:
            break;
    }
}

- (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    [self layoutSubviews];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self layoutSubviews];
}

- (void)setEdgeinset:(ZJCellEdgeinset)Edgeinset {
    _Edgeinset = Edgeinset;
    [self layoutSubviews];
}
- (void)setSepratorType:(ZJCellSepratorType)sepratorType {
    _sepratorType = sepratorType;
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    if (frame.size.width > 0) {
        [self zj_addSepratorLine:frame];
    }
}

- (CAShapeLayer *)sepratorLayer{
    if(!_sepratorLayer){
        _sepratorLayer = [CAShapeLayer layer];
    }
    return _sepratorLayer;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
