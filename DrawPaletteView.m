//
//  Palette.m
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "DrawPaletteView.h"
#import "UIView+QHUIViewCtg.h"
#import "NSString+YYAdd.h"

@implementation DrawPaletteView
{
   CGPoint      MyBeganpoint;
   CGPoint      MyMovepoint;
    
}

@synthesize x;
@synthesize y;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
	
}

- (void)awakeFromNib {
    myallline=[[NSMutableArray alloc] initWithCapacity:10];
    myallColor=[[NSMutableArray alloc] initWithCapacity:10];
    myalllinepencil = [[NSMutableArray alloc]initWithCapacity:10];
    myallwidth=[[NSMutableArray alloc] initWithCapacity:10];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch=[touches anyObject];
    MyBeganpoint=[touch locationInView:self];
    [self IntroductionpointHexColor:self.curHexColor];
    [self IntroductionpointPencil:[NSString stringWithFormat:@"%d",(int)self.curPencilTpye]];
    [self IntroductionpointWidth:self.curWidth];
    [self IntroductionpointInitPoint];
    [self IntroductionpointAddPoint:MyBeganpoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* MovePointArray=[touches allObjects];
    MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:self];
    [self IntroductionpointAddPoint:MyMovepoint];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self IntroductionpointSavePoint];
   // [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect  {
	//获取上下文
	CGContextRef context=UIGraphicsGetCurrentContext();
	
	//画之前线
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);

    //设置画线的连接处　拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    //画自己的
	if (myallline.count > 0) {
		for (int i = 0 ; i < [myallline count]; i++) {
            NSArray* tempArray = [NSArray arrayWithArray:[myallline objectAtIndex:i]];
			if ([myallColor count] > 0) {
                segmentColor = [DrawPaletteView colorWithHexString:myallColor[i]].CGColor;
                if([myalllinepencil[i] isEqualToString:@"0"])
                {
                    CGContextSetLineCap(context, kCGLineCapRound);
                }
                else if([myalllinepencil[i] isEqualToString:@"1"])
                {
                    CGContextSetLineCap(context, kCGLineCapButt);
                }
                Intsegmentwidth = [[myallwidth objectAtIndex:i]floatValue]+1;
			}
			if ([tempArray count] > 1)
            {
				CGContextBeginPath(context);
				CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
				CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                for (int j=0; j < [tempArray count] - 1; j++)
                {
					CGPoint myEndPoint = [[tempArray objectAtIndex:j+1] CGPointValue];
					CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);	
				}
				CGContextSetStrokeColorWithColor(context, segmentColor);
				CGContextSetLineWidth(context, Intsegmentwidth);
				CGContextStrokePath(context);
			}
		}
	}
    
	//画当前的线
	if ([myallpoint count] > 1) {
		CGContextBeginPath(context);
		//起点
		CGPoint myStartPoint = [[myallpoint objectAtIndex:0] CGPointValue];
		CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
		//把move的点全部加入　数组
		for (int i = 0 ; i < [myallpoint count]-1 ; i++) {
			CGPoint myEndPoint = [[myallpoint objectAtIndex:i+1] CGPointValue];
			CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
		}
		//在颜色和画笔大小数组里面取不相应的值
		segmentColor = [DrawPaletteView colorWithHexString:[myallColor lastObject]].CGColor;
        
		Intsegmentwidth = [[myallwidth lastObject]floatValue] + 1;
        
        if(self.curPencilTpye == 0)
        {
            //设置笔冒
            CGContextSetLineCap(context, kCGLineCapRound);
        }
        else
        {
            //设置笔冒
            CGContextSetLineCap(context, kCGLineCapButt);
        }
        
		//绘制画笔颜色
		CGContextSetStrokeColorWithColor(context, segmentColor);
		CGContextSetFillColorWithColor(context, segmentColor);
		//绘制画笔宽度
		CGContextSetLineWidth(context, Intsegmentwidth);
		//把数组里面的点全部画出来
		CGContextStrokePath(context);
	}
}

- (void)IntroductionpointInitPoint {
	myallpoint = [[NSMutableArray alloc] initWithCapacity:10];
}

//把画过的当前线放入　存放线的数组
-(void)IntroductionpointSavePoint {
	[myallline addObject:myallpoint];
}
-(void)IntroductionpointAddPoint:(CGPoint)sender {
	NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
	[myallpoint addObject:pointvalue ];
}

- (void)IntroductionpointHexColor:(NSString *)color {
	[myallColor addObject:color];
}

- (void)IntroductionpointPencil:(NSString *)type {
    [myalllinepencil addObject:type];
}

- (void)IntroductionpointWidth:(int)sender {
	[myallwidth addObject:@(sender)];
}

- (void)myalllineclear {
	if ([myallline count] > 0)  {
		[myallline removeAllObjects];
		[myallColor removeAllObjects];
        [myalllinepencil removeAllObjects];
		[myallwidth removeAllObjects];
		[myallpoint removeAllObjects];
		myallline=[[NSMutableArray alloc] initWithCapacity:10];
		myallColor=[[NSMutableArray alloc] initWithCapacity:10];
        myalllinepencil = [[NSMutableArray alloc]initWithCapacity:10];
		myallwidth=[[NSMutableArray alloc] initWithCapacity:10];
		[self setNeedsDisplay];
	}
}

- (void)myLineFinallyRemove {
	if ([myallline count] > 0) {
		[myallline  removeLastObject];
		[myallColor removeLastObject];
        [myalllinepencil removeLastObject];
		[myallwidth removeLastObject];
		[myallpoint removeAllObjects];
    }
	[self setNeedsDisplay];
    if ([myallline count] <= 0) {
    }
}

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrim] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (UIColor *) colorWithHexString: (NSString *)color {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(color, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com