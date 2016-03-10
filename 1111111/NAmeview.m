//
//  NAmeview.m
//  ADDD
//
//  Created by 206 on 13-7-9.
//  Copyright (c) 2013年 吴丁虎. All rights reserved.
//

#import "NAmeview.h"

@implementation NAmeview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        

        mutalearray =  [NSMutableArray array] ;
        mutag =  [NSMutableArray array] ;
        resulttext = [[UITextField alloc]initWithFrame:CGRectMake(20, 30, 200, 40)];
        
        [resulttext resignFirstResponder];
        [self  addSubview:resulttext];
        
       
        for (int i=0; i<9; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.hidden = YES;
            [button setFrame:CGRectMake(26+(i%3)*98, 126+(i/3)*98, 72, 72)];
            
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setBackgroundImage:[UIImage imageNamed:@"21"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateSelected];
           button.userInteractionEnabled= NO;//用户交互
            button.alpha = 0.9;
            button.tag = i+10000;
            [self addSubview:button];
            [mutalearray addObject:button];
            
        }
    }

    return self;
   
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    CGPoint point= [[touches anyObject]locationInView:self];
    curentpoint = point;
    for (UIButton *thisbutton in mutalearray) {
        CGFloat xdiff =point.x-thisbutton.center.x;
        CGFloat ydiff=point.y - thisbutton.center.y;
        //按钮点击成功
        if (fabs(xdiff) <36 &&fabs (ydiff) <36){
            
            NSLog(@"%ld",thisbutton.tag-9999);
            resulttext.text = [NSString stringWithFormat:@"%ld",thisbutton.tag-9999];
            resulttext.text = [resulttext.text stringByAppendingString:resulttext.text];
            
            if (!thisbutton.selected) {
                thisbutton.selected = YES;
                [mutag  addObject:thisbutton];
}
        
}
}
    [self setNeedsDisplay];
    [self addstring];
//    NSLog(@"shuzhu  %@",mutag);

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIButton *thisButton in mutalearray) {
        [thisButton setSelected:NO];
    }
    [mutag removeAllObjects];
    [self setNeedsDisplay];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint begainpoint=[[touches anyObject]locationInView:self];
    begainpoint = [[touches anyObject]locationInView:self];

    for (UIButton *thisbutton in mutalearray) {
    
    CGFloat xdiff =begainpoint.x-thisbutton.center.x;
    CGFloat ydiff=begainpoint.y - thisbutton.center.y;
    
    if (fabsf(xdiff) <36 &&fabsf (ydiff) <36&&fabsf(xdiff)<0&&fabsf (ydiff)<0){
         if (!thisbutton.selected) {
                thisbutton.selected = YES;
                [mutag  addObject:thisbutton];
}
}
}

    [self setNeedsDisplay];
    [self addstring];
}
//
-(void)drawRect:(CGRect)rect{
  CGContextRef  contextref = UIGraphicsGetCurrentContext();
    UIButton *buttonn;
    UIButton *buttonn1;
    
    if (mutag.count!=0) {
        buttonn = mutag[0];
        [[UIColor  redColor]set];
        CGContextSetLineWidth(contextref, 15);
        CGContextMoveToPoint(contextref, buttonn.center.x, buttonn.center.y);
        
        for (int t=1; t<mutag.count; t++) {
            buttonn1 = mutag[t];
            CGContextAddLineToPoint(contextref, buttonn1.center.x, buttonn1.center.y);
           
        }
        CGContextAddLineToPoint(contextref, curentpoint.x, curentpoint.y); 
       
    }
     CGContextStrokePath(contextref);
}
-(void)addstring{
    UIButton *strbutton;
    NSString *string=@"";
    
    for (int t=0; t<mutag.count; t++) {
        strbutton = mutag[t];
         string= [string stringByAppendingFormat:@"%d",strbutton.tag-9999];
        
    }

resulttext.text = string;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
