//
//  TransparentHomeForLine.m
//  DraggableLine
//
//  Created by Annie Graham on 7/15/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "TransparentHomeForLine.h"

@interface TransparentHomeForLine ()

@property(strong, nonatomic)NSLayoutConstraint *xPositionConstraint;
@property(nonatomic)UIView *leftPoint;
@property(nonatomic)UIView *rightPoint;

@end

@implementation TransparentHomeForLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initWithLine {

    [self initPoints];

    self.backgroundColor = [UIColor lightGrayColor];
    self.line = [DraggableLine new];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];


    [self.line initAsLine];

    [self addSubview:self.line];

    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.line
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1.0
                         constant:0.0]];

    self.xPositionConstraint = [NSLayoutConstraint constraintWithItem:self.line
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                          constant:[UIScreen mainScreen].bounds.size.width/2];
    [self addConstraint:self.xPositionConstraint];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    self.xPositionConstraint.constant = [touch locationInView:touch.view].x;
    [self layoutIfNeeded];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    self.xPositionConstraint.constant = [touch locationInView:touch.view].x;
    [self layoutIfNeeded];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGFloat touchXPosition = [touch locationInView:touch.view].x;
    if (fabs(self.leftPoint.center.x - touchXPosition) <= fabs(self.rightPoint.center.x - touchXPosition)){
        self.xPositionConstraint.constant = self.leftPoint.center.x;
    } else {
        self.xPositionConstraint.constant = self.rightPoint.center.x;
    }
    [self layoutIfNeeded];
}


- (void)initPoints{
    self.rightPoint = [UIView new];
    self.rightPoint.backgroundColor = [UIColor purpleColor];
    [self.rightPoint setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.leftPoint = [UIView new];
    self.leftPoint.backgroundColor = [UIColor purpleColor];
    [self.leftPoint setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.rightPoint];
    [self addSubview:self.leftPoint];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightPoint
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.leftPoint
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightPoint
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.1
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.leftPoint
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.1
                                                      constant:0.0]];


    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.rightPoint
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.1
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.leftPoint
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.1
                                                      constant:0.0]];

    NSDictionary *viewsDictionary = @{@"leftPoint":self.leftPoint, @"rightPoint":self.rightPoint};

    NSArray *horizontalFormattingLeftPoint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[leftPoint]"
                                                                                      options:0
                                                                                      metrics:nil views:viewsDictionary];

    [self addConstraints:horizontalFormattingLeftPoint];

    NSArray *horizontalFormattingRightPoint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightPoint]-30-|"
                                                                                     options:0
                                                                                     metrics:nil views:viewsDictionary];

    [self addConstraints:horizontalFormattingRightPoint];

}

@end
