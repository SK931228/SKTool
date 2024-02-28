//
//  WaterNav.m
//  WaterManager
//
//  Created by 宋可 on 2024/1/30.
//

#import "BaseNav.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define XStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define XNavBarHeight    44.0
#define XNavHeight       (XStatusBarHeight + XNavBarHeight)
#define SK_Image(name) [UIImage imageNamed:name]
#define SKRGBColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define sk_HaveBlock(block, ...) if (block) { block(__VA_ARGS__); };
#define SK_mediumfont(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]

@interface BaseNav ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLab;
@end
@implementation BaseNav

+ (BaseNav *)showIn:(UIView *)base title:(NSString *)str leftblock:(void (^)(void))leftblock{
    BaseNav *nav = [[BaseNav alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, XNavHeight)];
    [base addSubview:nav];
    nav.titleLab.text = str;
    nav.leftBtn.hidden = NO;
    [nav.leftBtn setImage:SK_Image(@"icon_back") forState:UIControlStateNormal];
    nav.leftClick = ^{
        leftblock();
    };
    return nav;
}

+ (BaseNav *)showHomeIn:(UIView *)base title:(NSString *)str RightImage:(NSString *)rightImg RightClick:(void (^)(void))rightblock{
    BaseNav *nav = [[BaseNav alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, XNavHeight)];
    [base addSubview:nav];
    nav.titleLab.text = str;
    if (rightImg) {
        [nav.rightBtn setImage:SK_Image(rightImg) forState:UIControlStateNormal];
        nav.rightBtn.userInteractionEnabled = YES;
        nav.rightBtn.hidden = NO;
        nav.rightClick = ^{
            rightblock();
        };
    }
    return nav;
}

- (void)setAlphaFromY:(float)y{
    NSLog(@"%f",y);
    float alpha = 1-(y/50.0);
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
    self.titleLab.textColor = [SKRGBColor(253, 141, 60) colorWithAlphaComponent:alpha];
    self.leftBtn.backgroundColor = [SKRGBColor(188, 188, 188) colorWithAlphaComponent:y/50>0.7?0.7:y/50];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)leftBtnClick{
    sk_HaveBlock(self.leftClick);
}

- (void)rightBtnClick{
    sk_HaveBlock(self.rightClick);
}

- (void)initUI{
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(10, XNavHeight-50, 50, 50);
    [_leftBtn addTarget:self action:@selector(leftBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.layer.cornerRadius = 25;
    _leftBtn.hidden = YES;
    [self addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(ScreenWidth-50-10, XNavHeight-50, 50, 50);
    [_rightBtn addTarget:self action:@selector(rightBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.layer.cornerRadius = 25;
    _rightBtn.hidden = YES;
    [self addSubview:_rightBtn];
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.frame = CGRectMake(60, XNavHeight-50, ScreenWidth-120, 50);
    _titleLab.font = SK_mediumfont(18);
    _titleLab.textAlignment = 1;
    _titleLab.textColor = SKRGBColor(74, 92, 86);
    [self addSubview:_titleLab];
}

@end
