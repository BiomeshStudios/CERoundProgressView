//
//  CERoundProgressView.m
//  RoundProgress
//
//  Created by Renaud Pradenc on 25/05/12.
//  Copyright (c) 2012 Céroce. All rights reserved.
//

#import "CERoundProgressView.h"
#import "CERoundProgressLayer.h"

@interface CERoundProgressView ()

- (void) _initIVars;

@end

@implementation CERoundProgressView

+ (Class) layerClass
{
    return [CERoundProgressLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initIVars];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self _initIVars];
    }
    return self;
}

- (void) _initIVars
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.tintColor = [UIColor colorWithRed:0.2 green:0.45 blue:0.8 alpha:1.0];
    self.trackColor = [UIColor whiteColor];
}


- (float) progress
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    return layer.progress;
}

- (void) setProgress:(float)progress
{
    BOOL growing = progress > self.progress;
    [self setProgress:progress animated:growing];
}

- (void) setProgress:(float)progress animated:(BOOL)animated
{
    
    
    // Coerce the value
    if(progress < 0.0f)
        progress = 0.0f;
    else if(progress > 1.0f)
        progress = 1.0f;
    
    // Apply to the layer
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    if(animated)
    {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = 0.25;
        animation.fromValue = [NSNumber numberWithFloat:layer.progress];
        animation.toValue = [NSNumber numberWithFloat:progress];
        [layer addAnimation:animation forKey:@"progressAnimation"];
        
        layer.progress = progress;
    }
    
    else {
        layer.progress = progress;
        [layer setNeedsDisplay];
    }
}

- (UIColor *)tintColor
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    return layer.tintColor;
}
- (void) setTintColor:(UIColor *)tintColor
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    layer.tintColor = tintColor;
    [layer setNeedsDisplay];
}

- (UIColor *)trackColor
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    return layer.trackColor;
}

- (void) setTrackColor:(UIColor *)trackColor
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    layer.trackColor = trackColor;
    [layer setNeedsDisplay];
}


- (float) startAngle
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    return layer.startAngle;
}

- (void) setStartAngle:(float)startAngle
{
    CERoundProgressLayer *layer = (CERoundProgressLayer *)self.layer;
    layer.startAngle = startAngle;
    [layer setNeedsDisplay];
}

/*- (void)drawRect:(CGRect)rect
{
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2.0;
    CGPoint center = {self.bounds.size.width/2.0, self.bounds.size.height/2.0};
    
    // Background circle
    UIBezierPath *backgroundCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                    radius:radius
                                                                startAngle:0.0
                                                                  endAngle:2.0*M_PI
                                                                 clockwise:YES];
    
    [trackColor setFill];
    [backgroundCircle fill];
    
    // Elapsed arc
    UIBezierPath *pieShare = [UIBezierPath bezierPathWithArcCenter:center 
                                                            radius:radius 
                                                        startAngle:startAngle
                                                          endAngle:startAngle + progress*2.0*M_PI
                                                         clockwise:YES];
    [pieShare addLineToPoint:center];
    [pieShare closePath];
    
    [tintColor setFill];
    [pieShare fill];                                   
}*/


@end
