//
//  PropertiesGenerator.h
//  TestProperties
//
//  Created by zhuxuhong on 16/7/30.
//  Copyright © 2016年 zhuxuhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertiesGenerator : NSObject

+(PropertiesGenerator*)generator;
/**
 *  自动生成property 到指定的model类.h文件中
 *
 *  @param className model类名
 *  @param dict      数据源字典
 *
 *  @return 是否生成成功
 */
-(BOOL)autoGeneratePropertiesInModelClass: (NSString*)className Dictionary: (NSDictionary*)dict;

@end
