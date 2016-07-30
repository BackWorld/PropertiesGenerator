# PropertiesGenerator
自动生成property到.h文件-OC

效果图

![final cut.png](http://upload-images.jianshu.io/upload_images/1334681-b2fb07fd2b2b9f49.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 实现原理
1. 配置Info.plist文件，加入自定义的字段：`ProjectDir : $(SRCROOT)/$(PROJECT_NAME)`
2. 遍历dictionary中的key和value，拼接字符串：@property(nonatomic,cop)NSString *key;
3. 分类整理-纯为了简洁
4. 保存到指定的.h文件中
5. 用NSAssert进行了出错提示，比如没有配置ProjectDir、.h文件找不到、.h文件读取失败

##配置Info.plist

![Info.plist.png](http://upload-images.jianshu.io/upload_images/1334681-e1294f00a1cf7c16.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##用法
```
#import "PropertiesGenerator.h"
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
    
    [[PropertiesGenerator generator] autoGeneratePropertiesInModelClass:@"Me" Dictionary:dict]; //判断是否写入成功
```
