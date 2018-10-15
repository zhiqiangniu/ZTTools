//
//  NSString+LGHelper.m
//  GLearningGenie
//
//  Created by ap on 2018/3/21.
//  Copyright © 2018年 Jing Shi. All rights reserved.
//

#import "NSString+LGHelper.h"

@implementation NSString (LGHelper)

+ (BOOL)LGValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+ (BOOL)isUrlString:(NSString *)string{
    NSString *emailRegex = @"[a-zA-z]+://.*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}
//手机号码验证
+ (BOOL)LGValidateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
  //  NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(19[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//+ (BOOL)LGJudgePassWordLegal:(NSString *)pass{
//    BOOL result = false;
//    if ([pass length] >= 8 && [pass length] <= 20){
//        // 判断长度大于8位后再接着判断是否同时包含数字和字符
//        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
//        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        result = [pred evaluateWithObject:pass];
//    }
//    return result;
//}
//+ (BOOL)LGJudgePassWordLegal:(NSString *)pass{
//    BOOL result = NO;
//    if ([pass length] >= 8 && [pass length] <= 20){
//        NSString * regex = @"^(?=.*[0-9].*)(?=.*[A-Za-Z].*).{8,20}$";
//        result = [self regexPatternResultWithRegex:regex TargetString:pass];
//    }
//    return result;
//}
+ (BOOL)LGJudgePassWordLegal:(NSString *)pass{
    BOOL result = NO;
    if ([pass length] >= 8 && [pass length] <= 20){
       NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//*******************

+ (BOOL)PLGAvailablePassword:(NSString *)string{
    BOOL result = NO;
    if ([string length] >= 8 && [string length] <= 20) {
        int checkNum = [NSString checkIsHaveNumAndLetter:string];
        if (checkNum == 3 || checkNum == 5) {
            result = YES;
        }
    }
    return result;
}
+ (int)checkIsHaveNumAndLetter:(NSString*)password{  //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (tNumMatchCount == password.length) {   //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == password.length) {   //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {   //符合英文和符合数字条件的相加等于密码长度
        return 3;
    }else if (tNumMatchCount > 0 && tLetterMatchCount > 0){//表示含有数字、字母
        return 5;
    }
    
    else {
        return 4; //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
}
+ (BOOL)LGNumber:(NSString *)targetString{
    NSString *regex = @"^([0-9])$";
    return [self regexPatternResultWithRegex:regex TargetString:targetString];
}
+ (BOOL)LGLetter:(NSString *)targetString{
    NSString *regex = @"^([a-zA-Z])$";
    return [self regexPatternResultWithRegex:regex TargetString:targetString];
}
//验证是否包含有 ^%&',;=?$/"等字符
+ (BOOL)validateIsSpecialCharacters:(NSString *)targetString{
    NSString *regex = @"^([~!/@#$%^&*()-_=+\\|[{}];:\'\",<.>/?]+)$";
    return [self regexPatternResultWithRegex:regex TargetString:targetString];
}
//最终正则匹配结果
+ (BOOL)regexPatternResultWithRegex:(NSString *)regex TargetString:(NSString *)targetString{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:targetString];
}

//**************
//**************
//是否为空
+ (BOOL)isStringNull:(NSString *)tmpString{
    BOOL bFlag = ( (tmpString == nil) || ([tmpString isEqualToString:@""]) );
    return  bFlag;
}

//空格
+ (BOOL)isHaveSpace:(NSString *)tmpString{
    BOOL bFlag = [self isMatchedByRegex:@"[\\s]+" string:tmpString];
    return  bFlag;
}

//中文
+ (BOOL)isHaveChinese:(NSString *)tmpString{
    BOOL bFlag = [self isMatchedByRegex:@"[\u2E80-\u9FFF]+" string:tmpString];
    return  bFlag;
}

//数字
+ (BOOL)isHaveNum:(NSString *)tmpString{
    BOOL bFlag = [self isMatchedByRegex:@"[\\d]+" string:tmpString];
    return  bFlag;
}
+ (BOOL)isMatchedByRegex:(NSString *)regex string:(NSString *)string{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}
///^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z\#\@\!\~\$\%\^\&\*\(\)\{\}\'\"\|\/\?\<\>\,\.\-\:\;\[\]\+\`]{8,20}$/;
//判断字母、特殊字符 、数字等自己慢慢看哈详细解说上面有
//判断密码强度
#define PWD_MAX_LENGTH 20

#define PWD_MIN_LENGTH 6

#define PWD_CLOSE_INTERVAL_WHITE_SPACE 32

#define PWD_CLOSE_INTERVAL_MATH_OPERATION_CODE_MIN 33

#define PWD_CLOSE_INTERVAL_MATH_OPERATION_CODE_MAX 47

#define PWD_CLOSE_INTERVAL_NUMBER_CODE_MIN 48

#define PWD_CLOSE_INTERVAL_NUMBER_CODE_MAX 57

#define PWD_CLOSE_INTERVAL_CONDITIONAL_OPERATION_CODE_MIN 58

#define PWD_CLOSE_INTERVAL_CONDITIONAL_OPERATION_CODE_MAX 64

#define PWD_CLOSE_INTERVAL_UPPER_LETTER_CODE_MIN 65

#define PWD_CLOSE_INTERVAL_UPPER_LETTER_CODE_MAX 90

#define PWD_CLOSE_INTERVAL_SPECIAL_CODE_1_MIN 91

#define PWD_CLOSE_INTERVAL_SPECIAL_CODE_1_MAX 96

#define PWD_CLOSE_INTERVAL_LOWER_LETTER_CODE_MIN 97

#define PWD_CLOSE_INTERVAL_LOWER_LETTER_CODE_MAX 122

#define PWD_CLOSE_INTERVAL_SPECIAL_CODE_2_MIN 123

#define PWD_CLOSE_INTERVAL_SPECIAL_CODE_2_MAX 126
/*********************************************************************
 函数名称 : checkPasswordStronger
 函数描述 : 检查密码强度
 
 输入参数 : N/A
 
 输出参数 : N/A
 
 返回值 : 0:低 , 1:中 , 2:高 , -1:密码为空
 
 作者 : LingDay
 
 是否包含空格 32  add by He_ping  回车=13 换行-10
 
 是否包含数学运算符  33-47
 
 是否包含数字 48-57
 
 是否包含条件运算符 58-64
 
 是否包含大写字母  65-90
 
 是否包含特殊字符1  91-96
 
 是否包含小写字母  97-122
 
 是否包含特殊字符2  123-126
 
 
 ASCII值 分布表
 
 0 NUT 32 (space) 64 @ 96 、
 
 1 SOH 33 ！ 65 A 97 a
 
 2 STX 34 ” 66 B 98 b
 
 3 ETX 35 # 67 C 99 c
 
 4 EOT 36 $ 68 D 100 d
 
 5 ENQ 37 % 69 E 101 e
 
 6 ACK 38 & 70 F 102 f
 
 7 BEL 39 , 71 G 103 g
 
 8 BS 40 ( 72 H 104 h
 
 9 HT 41 ) 73 I 105 i
 
 10 LF 42 * 74 J 106 j
 
 11 VT 43 + 75 K 107 k
 
 12 FF 44 , 76 L 108 l
 
 13 CR 45 - 77 M 109 m
 
 14 SO 46 . 78 N 110 n
 
 15 SI 47 / 79 O 111 o
 
 16 DLE 48 0 80 P 112 p
 
 17 DCI 49 1 81 Q 113 q
 
 18 DC2 50 2 82 R 114 r
 
 19 DC3 51 3 83 X 115 s
 
 20 DC4 52 4 84 T 116 t
 
 21 NAK 53 5 85 U 117 u
 
 22 SYN 54 6 86 V 118 v
 
 23 TB 55 7 87 W 119 w
 
 24 CAN 56 8 88 X 120 x
 
 25 EM 57 9 89 Y 121 y
 
 26 SUB 58 : 90 Z 122 z
 
 27 ESC 59 ; 91 [ 123 {
 
 28 FS 60 < 92 \ 124 |
 
 29 GS 61 = 93 ] 125 }
 
 30 RS 62 > 94 ^ 126 ~
 
 31 US 63 ? 95 — 127 DEL
 
 *********************************************************************/
//判断密码强度
+ (NSInteger)checkPasswordStronger:(NSString *)password{
    if ([password length] == 0 || nil == password){
        return -1;
    }
    
    if ([password length] >= PWD_MIN_LENGTH && [password length] <= PWD_MAX_LENGTH) {
        
        BOOL containsWhiteSpace = NO;                //是否包含空格 32  add by He_ping  回车=13 换行-10
        
        BOOL containsMathOperationCode=NO;           //是否包含数学运算符  33-47
        
        BOOL containsNumber=NO;                      //是否包含数字 48-57
        
        BOOL containsConditionalOperationCode=NO;    //是否包含条件运算符 58-64
        
        BOOL containsUpperLetterCode=NO;             //是否包含大写字母  65-90
        
        BOOL containsSpecialCode1=NO;                //是否包含特殊字符1  91-96
        
        BOOL containsLowerLetterCode=NO;             //是否包含小写字母  97-122
        
        BOOL containsSpecailCode2=NO;                //是否包含特殊字符2  123-126
        
        
        
        for (int i=0; i<[password length]; i++){
            
            char chTemp=[password characterAtIndex:i];
            
            //检测
            
            if (chTemp >= PWD_CLOSE_INTERVAL_MATH_OPERATION_CODE_MIN
                
                && chTemp <= PWD_CLOSE_INTERVAL_MATH_OPERATION_CODE_MAX){
                
                containsMathOperationCode = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_NUMBER_CODE_MIN && chTemp <= PWD_CLOSE_INTERVAL_NUMBER_CODE_MAX){
                
                containsNumber = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_CONDITIONAL_OPERATION_CODE_MIN && chTemp <= PWD_CLOSE_INTERVAL_CONDITIONAL_OPERATION_CODE_MAX){
                
                containsConditionalOperationCode = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_UPPER_LETTER_CODE_MIN && chTemp <= PWD_CLOSE_INTERVAL_UPPER_LETTER_CODE_MAX){
                
                containsUpperLetterCode = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_SPECIAL_CODE_1_MIN && chTemp <= PWD_CLOSE_INTERVAL_SPECIAL_CODE_1_MAX){
                
                containsSpecialCode1 = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_LOWER_LETTER_CODE_MIN && chTemp <= PWD_CLOSE_INTERVAL_LOWER_LETTER_CODE_MAX){
                
                containsLowerLetterCode = YES;
                
            }
            
            else if (chTemp >= PWD_CLOSE_INTERVAL_SPECIAL_CODE_2_MIN && chTemp <= PWD_CLOSE_INTERVAL_SPECIAL_CODE_2_MAX){
                
                containsSpecailCode2 = YES;
                
            }
            
            else if (chTemp == PWD_CLOSE_INTERVAL_WHITE_SPACE){// 是否包含空格，add by He_ping
                
                containsWhiteSpace = YES;
                
            }
            
        }
        
        
        
        //是否包含特殊字符 ** add containsWhiteSpace by Heping
        
        BOOL containsSpecialCode = (containsWhiteSpace || containsMathOperationCode || containsConditionalOperationCode || containsSpecialCode1 || containsSpecailCode2);
        
        
        
        if((containsNumber && !containsUpperLetterCode && !containsLowerLetterCode && !containsSpecialCode)
           
           || (!containsNumber && containsUpperLetterCode && !containsLowerLetterCode && !containsSpecialCode)
           
           || (!containsNumber && !containsUpperLetterCode && containsLowerLetterCode && !containsSpecialCode)
           
           || (!containsNumber && !containsUpperLetterCode && !containsLowerLetterCode && containsSpecialCode)){
            
            return 0;
            
        }else if ((containsNumber && containsUpperLetterCode && !containsLowerLetterCode && !containsSpecialCode)
                  
                  || (containsNumber && !containsUpperLetterCode && containsLowerLetterCode && !containsSpecialCode)
                  
                  || (containsNumber && !containsUpperLetterCode && !containsLowerLetterCode && containsSpecialCode)
                  
                  || (!containsNumber && containsUpperLetterCode && containsLowerLetterCode && !containsSpecialCode)
                  
                  || (!containsNumber && containsUpperLetterCode && !containsLowerLetterCode && containsSpecialCode)
                  
                  || (!containsNumber && !containsUpperLetterCode && containsLowerLetterCode && containsSpecialCode)){
            
            return 1;
            
        }
        
        else if ((containsNumber && containsUpperLetterCode && containsLowerLetterCode && !containsSpecialCode)
                 
                 || (containsNumber && containsUpperLetterCode && !containsLowerLetterCode && containsSpecialCode)
                 
                 || (containsNumber && !containsUpperLetterCode && containsLowerLetterCode && containsSpecialCode)
                 
                 || (!containsNumber && containsUpperLetterCode && containsLowerLetterCode && containsSpecialCode)
                 
                 || (containsNumber && containsUpperLetterCode && containsLowerLetterCode && containsSpecialCode)){

            return 2;
        }
    }
    return -1;
}
+ (BOOL)isLGEmpty:(NSString *)str{
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
@end
