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
@property(nonatomic)NSMutableArray *xValues;

@end

@implementation TransparentHomeForLine

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

    self.xValues = [NSMutableArray arrayWithObjects:[NSNumber numberWithDouble:self.rightPoint.center.x], [NSNumber numberWithDouble:self.leftPoint.center.x], nil];
    UITouch *touch = [[event allTouches] anyObject];
    self.xPositionConstraint.constant = [touch locationInView:self].x;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    self.xPositionConstraint.constant = [touch locationInView:self].x;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    double lowestDifference = fabs([[self.xValues objectAtIndex:0]doubleValue] - self.line.center.x);
    double newXValue = [[self.xValues objectAtIndex:0]doubleValue];

    for (NSInteger i=1; i<[self.xValues count]; i++) {
        double xValue = [[self.xValues objectAtIndex:i]doubleValue];
        if (fabs(xValue - self.line.center.x) < lowestDifference) {
            newXValue = xValue;
        }
    }

    self.xPositionConstraint.constant = newXValue;
    [self layoutIfNeeded];
}


- (void)initPoints {
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
                                                                                     metrics:nil
                                                                                       views:viewsDictionary];

    [self addConstraints:horizontalFormattingLeftPoint];

    NSArray *horizontalFormattingRightPoint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightPoint]-30-|"
                                                                                      options:0
                                                                                      metrics:nil
                                                                                        views:viewsDictionary];

    [self addConstraints:horizontalFormattingRightPoint];
}

@end
