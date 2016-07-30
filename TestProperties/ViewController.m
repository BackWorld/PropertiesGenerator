//
//  ViewController.m
//  TestProperties
//
//  Created by zhuxuhong on 16/7/30.
//  Copyright © 2016年 zhuxuhong. All rights reserved.
//

#import "ViewController.h"
#import "PropertiesGenerator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{
                           @"name": @"zhuxuhong",
                           @"age": [NSNumber numberWithFloat:22],
                           @"nickname": @"flytoo",
                           @"friends": @[@"1",@"2",@"3"],
                           @"experience": @{@"2016": @"BISTU"},
                           @"password": @"1234",
                           @"education": @{@"2016": @"BISTU"},
                           @"graduated": [NSNumber numberWithBool:true]
                           };
    
    [[PropertiesGenerator generator] autoGeneratePropertiesInModelClass:@"Me" Dictionary:dict];
}

-(BOOL)class: (id)class isKindOfClass: (NSString*)string{
    return [class isKindOfClass:NSClassFromString(string)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
