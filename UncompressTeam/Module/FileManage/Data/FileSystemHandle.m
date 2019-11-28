//
//  FileSystemHandle.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemHandle.h"
#import "FileManagerTool.h"

@implementation FileSystemHandle

+(void)fileHandleAlertShowFileName:(NSString *)fileName FilePath:(NSString *)path collectionVC:(nonnull FileCollectionViewController *)collVC withVC:(nonnull UIViewController *)vc 
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fileName message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    //投送
    [alert addAction:[UIAlertAction actionWithTitle:@"隔空投送/分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *textToShare = [NSString stringWithFormat:@"%@",fileName];
        UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
        //分享的url
        //           NSURL *urlToShare = [NSURL URLWithString:_playingModel.downloadurl];
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        NSArray *activityItems = @[textToShare,imageToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [vc presentViewController:activityVC animated:YES completion:nil];
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"completed");
                
            } else  {
                NSLog(@"cancled");
                
            }
        };
    }]];
    
    //复制
    [alert addAction:[UIAlertAction actionWithTitle:@"拷贝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //拷贝文件夹
        if ([[FileManagerTool sharedManagerTool] directoryIsExist:fileName]) {
            NSString *newName = [fileName stringByAppendingString:@"(副本)"];//新的文件名
            NSString *newSubPath = [[path componentsSeparatedByString:fileName] firstObject];
            NSString *newFilePath = [newSubPath stringByAppendingPathComponent:newName];
            [[FileManagerTool sharedManagerTool] copyItemAtPath:path toPath:newFilePath];
        }else{
            //拷贝文件
            NSString *originlName = [[fileName componentsSeparatedByString:@"."] firstObject]; //获取文件名
            NSString *originlExtension = [[fileName componentsSeparatedByString:@"."] lastObject];//文件后缀

            NSString *newName = [originlName stringByAppendingString:@"(副本)"];//新的文件名
            NSString *newFullName = [[newName stringByAppendingString:@"."] stringByAppendingString:originlExtension];//新的文件名加后缀
            
            NSString *newSubPath = [[path componentsSeparatedByString:fileName] firstObject];
            NSString *newFilePath = [newSubPath stringByAppendingPathComponent:newFullName];
            
            [[FileManagerTool sharedManagerTool] copyItemAtPath:path toPath:newFilePath];
        }
                
        [collVC reloadData];
        
        NSLog(@"%@",path);
    }]];
    
    
    //是都显示解压缩菜单
    NSString *fileExtension = [[fileName pathExtension] lowercaseString];
    if ([fileExtension isEqualToString:@"zip"] || [fileExtension isEqualToString:@"rar"]) {
        //压缩文件显示 解压缩菜单
        [alert addAction:[UIAlertAction actionWithTitle:@"解压缩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self unArchiveWithFilePath:path];
        }]];
    }
   
    //重命名
    [alert addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        /// 重命名文件夹
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重命名" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            textField.placeholder = fileName;
                        }];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            UITextField *textField = [alertController.textFields firstObject];
                            
                            NSLog(@"%@",textField.text);
                            if (textField.text.length == 0) {
                                [SVProgressHUD showErrorWithStatus:@"文件夹名称不可为空！"];
                                return ;
                            }
                            if ([[FileManagerTool sharedManagerTool] directoryIsExist:textField.text]) {
                                [SVProgressHUD showErrorWithStatus:@"该文件夹已经存在！"];
                                return;
                            }
                            
                            NSString *originlExtension = [[fileName componentsSeparatedByString:@"."] lastObject];

                            NSString *newFullName = [[textField.text stringByAppendingString:@"."] stringByAppendingString:originlExtension];
                            
                            NSString *newSubPath = [[path componentsSeparatedByString:fileName] firstObject];
                            NSString *newFullPath = [newSubPath stringByAppendingPathComponent:newFullName];
                            
                            //重命名文件夹
                            [[FileManagerTool sharedManagerTool] moveItemAtPath:path toPath:newFullPath];
                            [collVC  reloadData];
                            
                        }]];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                        [vc presentViewController:alertController animated:YES completion:nil];
    }]];
    
    //删除
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[FileManagerTool sharedManagerTool]deleteFileAtFilePath:path];
        [collVC  reloadData];
    }]];
    
    //取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}

+(void)addActionShowViewFilePath:(NSString *)path collectionVC:(nonnull FileCollectionViewController *)collVC withVC:(nonnull UIViewController *)vc
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"文件管理" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"新建目录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        /// 添加新文件夹
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"创建文件夹" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                 [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                     textField.placeholder = @"请输入文件夹名称";
                 }];
                 [alertController addAction:[UIAlertAction actionWithTitle:@"创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                     UITextField *textField = [alertController.textFields firstObject];
                     
                     NSLog(@"%@",textField.text);
                     if (textField.text.length == 0) {
                         [SVProgressHUD showErrorWithStatus:@"文件夹名称不可为空！"];
                         return ;
                     }
                     if ([[FileManagerTool sharedManagerTool] directoryIsExist:textField.text]) {
                         [SVProgressHUD showErrorWithStatus:@"该文件夹已经存在！"];
                         return;
                     }
                     
                     //创建文件夹
                     [[FileManagerTool sharedManagerTool] createDirectoryWithDirectoryName:textField.text filePath:path];
                     [collVC  reloadData];
                     
                 }]];
                 [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                 [vc presentViewController:alertController animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"新建文本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"导入相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}


/// 解压缩文件
/// @param filePath 文件路径
+ (void)unArchiveWithFilePath:(NSString*)filePath{
    
}

@end
