//
//  MY_ScanQRCodeController.m
//  YiMeiBusiness
//
//  Created by xiaoqiang on 15-4-28.
//  Copyright (c) 2015年 Xiaolinxiaoli. All rights reserved.
//

#import "MY_ScanQRCodeController.h"
#import <AVFoundation/AVFoundation.h>

#define kSPACE    50
#define YMBGCOLOR   [[UIColor blackColor] colorWithAlphaComponent:0.4]

@interface MY_ScanQRCodeController () <AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *boxView;
@property (nonatomic, assign) BOOL isReading;
@property (nonatomic, strong) CALayer *scanLayer;
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) NSString* scanCodeStr;
@end

@implementation MY_ScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self setTitle:@"扫描二维码" isBackButton:YES rightBttonName:@"相册" rightImageName:nil];
    _captureSession = nil;
    _isReading = NO;
    [self startReading];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self startReading];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopReading];
}

- (BOOL)startReading {
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机开启失败！" message:@"请打开手机设置>>隐私>>相机，允许小美店铺访问相机。" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    //4.1.将输入流添加到会话
    [_captureSession addInput:input];
    //4.2.将媒体输出流添加到会话中
    [_captureSession addOutput:captureMetadataOutput];
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:CGRectMake(0, 64, MY_ScreenWidth, MY_ScreenHeight-64)];
    //9.将图层添加到预览view的图层上
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(kSPACE, (MY_ScreenHeight - MY_APP_STATUS_NAVBAR_HEIGHT - (MY_ScreenWidth - kSPACE*2))/2 - 20, MY_ScreenWidth - kSPACE*2, MY_ScreenWidth - kSPACE*2)];
    _boxView.layer.borderColor = [UIColor whiteColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [self.view addSubview:_boxView];
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor greenColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    [timer fire];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, _boxView.bottom+5, MY_ScreenWidth, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"将二维码放入框内，即可自动扫描";
    [self.view addSubview:label];
    //10.开始扫描
    [_captureSession startRunning];
    
    UIView* topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, MY_ScreenWidth, self.boxView.top - 64)];
    topView.backgroundColor = YMBGCOLOR;
    [self.view addSubview:topView];
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom, kSPACE, self.boxView.height)];
    leftView.backgroundColor = YMBGCOLOR;
    [self.view addSubview:leftView];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(self.boxView.right, leftView.top, kSPACE, self.boxView.height)];
    rightView.backgroundColor = YMBGCOLOR;
    [self.view addSubview:rightView];
    
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.boxView.bottom, self.boxView.bottom, MY_ScreenHeight - self.boxView.bottom)];
    bottomView.backgroundColor = YMBGCOLOR;
    [self.view addSubview:bottomView];
    
    return YES;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if (self.scanCodeStr && [self.scanCodeStr isEqualToString:metadataObj.stringValue]) {
            return;
        }
        self.scanCodeStr = metadataObj.stringValue;
        _isReading = NO;

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您确定生成该顾客的坐式美容订单？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self makeOrder];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
        return;
        //判断回传的数据类型
    }
}

- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = -15;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)rightButtonAction {
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count) {
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            NSString *scannedResult = feature.messageString;
            self.scanCodeStr = scannedResult;
            [self makeOrder];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择的图片不对" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (void)makeOrder {
//    XLBaseRequestModel* model = [[XLBaseRequestModel alloc] initWithUrl:YMB_API_FOR_SCAN_QR delegate:self];
//    [model.paramters setObject:self.scanCodeStr forKey:@"qrcode"];
//    [model postCommonRequestIsEncoding:YES verifySign:YES];
}
@end
