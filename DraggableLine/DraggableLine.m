//
//  DraggableLine.m
//  DraggableLine
//
//  Created by Annie Graham on 7/15/16.
//  Copyright © 2016 Annie Graham. All rights reserved.
//

#import "DraggableLine.h"

@implementation DraggableLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initAsLine {
    self.backgroundColor = [UIColor colorWithRed:0.02 green:0.70 blue:0.90 alpha:1.0];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[line(5)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"line": self}];

    [self addConstraints:widthConstraints];
}

@end
