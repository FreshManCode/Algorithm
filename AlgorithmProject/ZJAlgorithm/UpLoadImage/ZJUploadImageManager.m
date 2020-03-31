//
//  ZJUploadImageManager.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJUploadImageManager.h"
#import "TZImagePickerController.h"
#import "ZJUploadImageAdapter.h"
#import "NSObject+ZJEncoder.h"

@interface ZJUploadImageManager () <TZImagePickerControllerDelegate,ZJBaseNetAdapterProtocol>

@property (nonatomic, strong,nullable) TZImagePickerController *imagePickerVC;
@property (nonatomic, strong) ZJUploadImageAdapter *uploadAdapter;
@property (nonatomic, strong) ZJBaseUpImageNetModel *reqImageModel;
@property (nonatomic, strong) NSDateFormatter *yearToSecondFormatter;



@end

@implementation ZJUploadImageManager

+ (instancetype)manager {
    static ZJUploadImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)pushToSelectImageViewController:(ZJBaseViewController *)fromVC {
    [fromVC.navigationController presentViewController:self.imagePickerVC
                                              animated:true
                                            completion:nil];
}

- (void)beginUpLoadImage:(UIImage *)image {
    [ZJWaitHUDView show];
    if (!_uploadAdapter) {
        _uploadAdapter = [ZJUploadImageAdapter new];
        [_uploadAdapter setDelegate:self];
    }
    if (!_reqImageModel) {
        _reqImageModel = [ZJBaseUpImageNetModel initWithImage:image
                                                    message:@"网络图片"];
    } else {
        [_reqImageModel setImage:image];
    }
    [_reqImageModel setMessage:[self fileName]];
    NSString *filePath = [NSString stringWithFormat:@"Image/%@",[self fileName]];
    [_uploadAdapter setURLFilePath:filePath];
    [_uploadAdapter runImage:_reqImageModel];
}


- (void)imagePickerController:(TZImagePickerController *)picker
       didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                 sourceAssets:(NSArray *)assets
        isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
                        infos:(NSArray<NSDictionary *> *)infos {
    UIImage *image = photos.firstObject;
    [self beginUpLoadImage:image];
    ZJNSLOG(@"avatar:%@",photos.firstObject);
}
- (void)ZJBaseNetAdapterDelegate:(ZJBaseNetAdapter *)adapter
                            head:(ZJBaseNetResHeadModel *)headModel
                        response:(ZJBaseNetModel *)response {
    if (adapter == _uploadAdapter) {
        if (response ) {
            ZJUpLoadImageResModel *resModel = (ZJUpLoadImageResModel *)response;
            if (resModel.content) {
                ZJNSLOG(@"download_url:%@",resModel.content.download_url);
            }
        }
        [ZJWaitHUDView hide];
    }
}


- (TZImagePickerController *)imagePickerVC{
    if(!_imagePickerVC){
        _imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1
                                                                    columnNumber:3
                                                                        delegate:self];
        _imagePickerVC.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
            [leftButton setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
            [leftButton setImage:ZJ_LoadImage(@"ZJCloseLogo") forState:UIControlStateNormal];
        };
        _imagePickerVC.allowTakePicture = true;
        _imagePickerVC.sortAscendingByModificationDate = false;
        _imagePickerVC.allowPickingVideo = false;
        _imagePickerVC.allowPickingGif = false;
        _imagePickerVC.allowTakeVideo  = false;
        _imagePickerVC.allowCrop = true;
        _imagePickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
        NSInteger left = 30;
        NSInteger widthHeight = ZJScreenWidth - 2 * left;
        NSInteger top = (ZJScreenHeight - widthHeight) / 2;
        _imagePickerVC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
        _imagePickerVC.scaleAspectFillCrop = YES;
    }
    return _imagePickerVC;
}

- (NSString *)fileName {
    NSString *imageName = [self.yearToSecondFormatter stringFromDate:[NSDate date]];
    NSString *fileName  = [NSString stringWithFormat:@"%@.jpg",imageName];
    return fileName;
}

- (NSDateFormatter *)yearToSecondFormatter{
    if(!_yearToSecondFormatter){
        _yearToSecondFormatter = [NSDateFormatter new];
        [_yearToSecondFormatter setDateFormat:@"yyyyMMddHHmmss"];
    }
    return _yearToSecondFormatter;
}

@end
