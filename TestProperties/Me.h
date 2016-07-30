//
//  Me.h
//  TestProperties
//
//  Created by zhuxuhong on 16/7/30.
//  Copyright © 2016年 zhuxuhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Me : NSObject

@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSDictionary *experience;
@property(nonatomic,copy)NSDictionary *education;
@property(nonatomic,copy)NSArray *friends;
@property(nonatomic,assign)BOOL graduated;
@property(nonatomic,assign)float age;

@end