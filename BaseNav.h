//
//  WaterNav.h
//  WaterManager
//
//  Created by 宋可 on 2024/1/30.
//

#import <UIKit/UIKit.h>



@interface BaseNav : UIView
+ (BaseNav *)showIn:(UIView *)base title:(NSString *)str leftblock:(void (^)(void))leftblock;
+ (BaseNav *)showHomeIn:(UIView *)base title:(NSString *)str RightImage:(NSString *)rightImg RightClick:(void (^)(void))rightblock;
- (void)setAlphaFromY:(float)y;
@property (nonatomic,copy) void (^leftClick) (void);
@property (nonatomic,copy) void (^rightClick) (void);
@end


