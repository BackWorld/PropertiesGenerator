//
//  PropertiesGenerator.m
//  TestProperties
//
//  Created by zhuxuhong on 16/7/30.
//  Copyright © 2016年 zhuxuhong. All rights reserved.
//

#import "PropertiesGenerator.h"

@implementation PropertiesGenerator

// 单例
+(PropertiesGenerator *)generator{
    static PropertiesGenerator *generator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        generator = [PropertiesGenerator new];
    });
    return generator;
}


-(BOOL)autoGeneratePropertiesInModelClass:(NSString *)className
                               Dictionary:(NSDictionary *)dict{
    
    NSString *propertiesString = [NSMutableString string];
    
    /**
     *  是否配置好了 ProjectDir
        Info.plist: ProjectDir : $(SRCROOT)/$(PROJECT_NAME)
        projectDir: /Users/zhuxuhong/Desktop/TestProperties/TestProperties/Me.h
     */
    NSString *infoPlistPath = [[NSBundle mainBundle]pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *infoDict = [NSDictionary dictionaryWithContentsOfFile: infoPlistPath];
    NSString *projectDir = infoDict[@"ProjectDir"];
    NSString *desc = @"请在Info.plist文件中手动加入字段: key: ProjectDir value: $(SRCROOT)/$(PROJECT_NAME), 否则数据将无法写入。 或阅读README.md进行配置 ";
    NSAssert(projectDir, desc);
    
    /**
     *  类.h文件是否存在
     */
    NSString *modelClassFilePath = [NSString stringWithFormat:@"%@/%@.h",projectDir,className];
    NSFileManager *fm = [NSFileManager defaultManager];
    desc = [NSString stringWithFormat:@"%@.h文件不存在",className];
    NSAssert([fm fileExistsAtPath:modelClassFilePath], desc);
    
    // 遍历字典中的key 和 value
    // 分类
    NSMutableArray *propertiesArray = [NSMutableArray array];
    NSMutableArray *NSStringArray = [NSMutableArray array];
    NSMutableArray *NSDictinoaryArray = [NSMutableArray array];
    NSMutableArray *NSArrayArray = [NSMutableArray array];
    NSMutableArray *BOOLArray = [NSMutableArray array];
    NSMutableArray *floatArray = [NSMutableArray array];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str;
        if ([self class:obj isKindOfClass:@"__NSCFString"] || [self class:obj isKindOfClass:@"NSTaggedPointerString"] || [self class:obj isKindOfClass:@"__NSCFConstantString"]) {
            str = [NSString stringWithFormat:@"@property(nonatomic,copy)NSString *%@;",key];
            [NSStringArray addObject:str];
        }
        else if ([self class:obj isKindOfClass:@"__NSCFNumber"]) {
            str = [NSString stringWithFormat:@"@property(nonatomic,assign)float %@;",key];
            [floatArray addObject:str];
        }
        else if ([self class:obj isKindOfClass:@"__NSCFArray"] || [self class:obj isKindOfClass:@"__NSArrayI"]) {
            str = [NSString stringWithFormat:@"@property(nonatomic,copy)NSArray *%@;",key];
            [NSArrayArray addObject:str];
        }
        else if ([self class:obj isKindOfClass:@"__NSCFDictionary"] || [self class:obj isKindOfClass:@"__NSDictionaryI"]) {
            str = [NSString stringWithFormat:@"@property(nonatomic,copy)NSDictionary *%@;",key];
            [NSDictinoaryArray addObject:str];
        }
        else if ([self class:obj isKindOfClass:@"__NSCFBoolean"]) {
            str = [NSString stringWithFormat:@"@property(nonatomic,assign)BOOL %@;",key];
            [BOOLArray addObject:str];
        }
    }];
    [propertiesArray addObjectsFromArray: NSStringArray];
    [propertiesArray addObjectsFromArray: NSDictinoaryArray];
    [propertiesArray addObjectsFromArray: NSArrayArray];
    [propertiesArray addObjectsFromArray: BOOLArray];
    [propertiesArray addObjectsFromArray: floatArray];
    propertiesString = [propertiesArray componentsJoinedByString:@"\n"];
    
    // 然后写到.h文件中
    NSError *error;
    NSURL *URL = [NSURL fileURLWithPath: modelClassFilePath];
    NSString *orgStr = [NSString stringWithContentsOfURL:URL usedEncoding:nil error:&error];
    
    desc = [NSString stringWithFormat:@"非常抱歉，读取.h文件失败: %@\n请尝试手动将打印的属性复制粘贴到%@.h文件中",error.localizedDescription,className];
    if (error) {
        NSLog(@"\n%@",propertiesString);
    }
    NSAssert(!error, desc);
    
    NSArray *comps = [orgStr componentsSeparatedByString:@"@end"];
    NSString *whole = [NSString stringWithFormat:@"%@\n\n%@\n\n%@",comps.firstObject,propertiesString,@"@end"];
    NSData *data = [whole dataUsingEncoding:NSUTF8StringEncoding];
    if ([data writeToURL:URL atomically:true]) {
        NSLog(@"\n%@",propertiesString);
        return true;
    }
    return false;
}

/**
 *  从字符串读取的类是否是属于某一类
 *
 *  @param class  指定的类
 *  @param string 字符串读取某一类
 *
 *  @return 结果
 */
-(BOOL)class: (id)class isKindOfClass: (NSString*)classString{
    return [class isKindOfClass:NSClassFromString(classString)];
}

@end
