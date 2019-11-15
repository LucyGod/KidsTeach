//
//  UIImage+HAFExtension.h
//  ZeroCartoon
//
//  Created by Liuxg on 5/10/16.
//  Copyright © 2016 DR. All rights reserved.
//  通过颜色创建UIImage

#import <UIKit/UIKit.h>

@interface UIImage (HAFExtension)

+ (instancetype)imageWithUIColor:(UIColor *)color size:(CGSize)size;
+ (instancetype)imageWithCGColor:(CGColorRef)colorref size:(CGSize)size;

/**
 *  绘制圆形图片
 *
 *  @return 返回绘制好的圆形图片
 */
- (UIImage *)cirleImage;

/**
 *  绘制指定尺寸的图片
 *
 *  @param size 指定尺寸
 *
 *  @return 指定大小的图片
 */
- (UIImage *)cirleImageWithSize:(CGSize)size;


/**
 *  拼接图片上传的参数字典
 *
 *  @param keyParam   参数名
 *  @param base64Heap 参数值(图片/图片数组)
 *  @param type       裁剪类型(0.头像 100 * 100 1.社团 80 * 80 2.不裁剪)
 *
 *  @return 参数字典
 *
 *      
 *  
    // 1.得到图片或图片组对象
    // ...
    
    // 2.处理参数请求
    NSDictionary *params = [UIImage createImageKey:@"" value:nil withClipType:0];
 
    // 3.发送请求
    [[HAFHttpManager sharedHttpManager] POST:@"接口名" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
 *
 */
+ (NSDictionary *)createImageKey:(NSString *)keyParam value:(id)base64Heap withClipType:(NSUInteger)type;

// 图片缩放
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

//按照 高 等比缩放
- (UIImage *)imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;
//按照宽等比 缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

- (UIImage *)fixOrientation;
+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

@end
