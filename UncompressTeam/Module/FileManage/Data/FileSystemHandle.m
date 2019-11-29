//
//  FileSystemHandle.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemHandle.h"
#import "FileManagerTool.h"
#import "ZLPickPhotoViewController.h"
#import <PhotosUI/PhotosUI.h>

@interface FileSystemHandle ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) UIImagePickerController *imgPicker;
@property (nonatomic ,weak) FileCollectionViewController *weakVC;
@property (nonatomic ,copy) NSString *weakPath;


@end

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
            
            NSInteger fileIndex = 0;
            NSString *oldSubPath = [[path componentsSeparatedByString:fileName] firstObject];
            
            NSString *newName = [[fileName componentsSeparatedByString:@"."] firstObject];
            NSString *newPath = [oldSubPath stringByAppendingPathComponent:newName];
            
            while ([[FileManagerTool sharedManagerTool] directoryIsExistWithFullPath:newPath]) {
                fileIndex ++;
                //如果新路径个之前文件夹名字重复 则换名字
                newName = [[[fileName componentsSeparatedByString:@"."] firstObject] stringByAppendingString:[NSString stringWithFormat:@"%ld",fileIndex]];
                newPath = [oldSubPath stringByAppendingPathComponent:newName];
            }
            
            [self unArchiveWithFilePath:path VC:collVC unArchiveDirectionName:newName];
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
        /// 添加新文件夹
              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文件" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            textField.placeholder = @"请输入名称";
                        }];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            UITextField *textField = [alertController.textFields firstObject];
                            
                            if (textField.text.length == 0) {
                                [SVProgressHUD showErrorWithStatus:@"文本名称不可为空！"];
                                return ;
                            }
                    
                            //创建文本
                            [[FileManagerTool sharedManagerTool] createTxtName:textField.text filePath:path];
                            [collVC  reloadData];
                            
                        }]];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                        [vc presentViewController:alertController animated:YES completion:nil];
       
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"导入相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ZLPickPhotoViewController *photo = [[ZLPickPhotoViewController alloc] initWithCompleteHandle:^(NSArray *images,NSArray *assetArr) {
            for (int i = 0; i < images.count; i++) {
                PHAsset *asset = assetArr[i];
                NSData *data = UIImageJPEGRepresentation(images[i], 1);
                
                [data writeToFile:[path?path:DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[asset valueForKey:@"filename"]]] atomically:YES];
                [collVC reloadData];
            }
        }];
        // 限制最多能选多少张
//        photo.limitCount = 99;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photo];
        [vc presentViewController:nav animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        #if TARGET_IPHONE_SIMULATOR
                //模拟器
                return;
        #elif TARGET_OS_IPHONE
                [FileSystemHandle sharedManagerHandel].weakVC = collVC;
                     [FileSystemHandle sharedManagerHandel].weakPath = path;
                //真机
          [FileSystemHandle sharedManagerHandel].imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
          [vc presentViewController:[FileSystemHandle sharedManagerHandel].imgPicker animated:YES completion:nil];

        #endif
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
}


/// 解压缩文件
/// @param filePath 文件路径
+ (void)unArchiveWithFilePath:(NSString*)filePath VC:(FileCollectionViewController*)vc unArchiveDirectionName:(NSString*)dirName{
    [SVProgressHUD showWithStatus:@"解压中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    SARUnArchiveANY *unarchive = [[SARUnArchiveANY alloc]initWithPath:filePath];
    unarchive.completionBlock = ^(NSArray *filePaths){
        [SVProgressHUD dismiss];
        [vc reloadData];
        NSLog(@"For Archive : %@",filePath);
        for (NSString *filename in filePaths) {
            NSLog(@"File: %@", filename);
        }
    };
    unarchive.failureBlock = ^(){
        [SVProgressHUD dismiss];
    };
    [unarchive deCompressWithDirectoryName:dirName];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   UIImage *  eimage = [info objectForKey:UIImagePickerControllerOriginalImage];
   NSData *data = UIImageJPEGRepresentation(eimage, 1);
  [data writeToFile:[_weakPath?_weakPath:DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG",[self getCurrentTime]]] atomically:YES];
  [_weakVC reloadData];
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-hh-mm-ss"];
        NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    return nowDateString;
}
-(UIImagePickerController *)imgPicker
{
    if (!_imgPicker) {
        _imgPicker = [[UIImagePickerController alloc] init];
        _imgPicker.delegate = self;
    }
    return _imgPicker;
}
+ (instancetype)sharedManagerHandel {
    static FileSystemHandle *managerHandle= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerHandle = [[FileSystemHandle alloc] init];
    });
    
    return managerHandle;
}

@end
