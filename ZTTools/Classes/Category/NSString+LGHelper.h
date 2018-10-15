//
//  NSString+LGHelper.h
//  GLearningGenie
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Jing Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGHelper)
+ (BOOL)LGValidateEmail:(NSString *)email;
+ (BOOL)LGValidateMobile:(NSString *)mobile;
+ (BOOL)LGJudgePassWordLegal:(NSString *)pass;
+ (BOOL)isUrlString:(NSString *)string;
+ (BOOL)PLGAvailablePassword:(NSString *)string;
+ (BOOL)isLGEmpty:(NSString *)str;

@end
