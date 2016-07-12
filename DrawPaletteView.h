//
//  Palette.h
//  lovewith
//
//  Created by imqiuhang on 15/4/22.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPaletteView : UIView
{
	float x;
	float y;
	float           Intsegmentwidth;
	CGColorRef      segmentColor;
    
	NSMutableArray* myallpoint;
	NSMutableArray* myallline;
    NSMutableArray* myalllinepencil;
	NSMutableArray* myallColor;
	NSMutableArray* myallwidth;
    
    //哈希表暂存 在收到的哈希总数和实际收到的笔画数一致时表示 当前笔画存满 则将收到的所有同伴的笔画显示到画画上
    NSMutableDictionary *partnerHashDrawQuen;
}

@property float x;
@property float y;
@property (nonatomic,weak)UILabel *waitLable;

@property (nonatomic,strong) NSString     *curHexColor;
@property (nonatomic) float curWidth;
@property (nonatomic) int curPencilTpye;

- (void)IntroductionpointInitPoint;
- (void)IntroductionpointSavePoint;
- (void)IntroductionpointAddPoint:(CGPoint)sender;
- (void)IntroductionpointHexColor:(NSString *)hexcolor;
- (void)IntroductionpointPencil:(NSString *)type;
- (void)IntroductionpointWidth:(int)sender;

- (void)myalllineclear;
- (void)myLineFinallyRemove;

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com